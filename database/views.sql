USE iot_fleet_tracking;

-- 1. PRIMARY VIEW: vehicle_latest_status
-- Combines vehicle master data with current driver assignment,
-- latest spatial GPS coordinates, and latest engine sensor telemetry.
-- Used extensively by Dashboard and Live Fleet Tracking.
DROP VIEW IF EXISTS vehicle_latest_status;

CREATE VIEW vehicle_latest_status AS
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.vehicle_type,
    v.model,
    v.status AS vehicle_status,
    COALESCE(d.name, 'Unassigned') AS driver_name,
    COALESCE(d.phone, 'N/A') AS driver_phone,
    latest_gps.latitude,
    latest_gps.longitude,
    COALESCE(latest_gps.speed, 0.00) AS speed,
    COALESCE(latest_gps.heading, 0.00) AS heading,
    COALESCE(latest_sensor.fuel_level, 0.00) AS fuel_level,
    COALESCE(latest_sensor.engine_temperature, 0.00) AS engine_temperature,
    COALESCE(latest_sensor.engine_rpm, 0) AS engine_rpm,
    COALESCE(latest_sensor.battery_voltage, 12.00) AS battery_voltage,
    COALESCE(latest_gps.recorded_at, latest_sensor.recorded_at, v.created_at) AS last_updated
FROM vehicles v

-- Join current driver assignment (assigned_to IS NULL represents ongoing active assignment)
LEFT JOIN vehicle_assignments va 
    ON v.vehicle_id = va.vehicle_id 
    AND (va.assigned_to IS NULL OR va.assigned_to >= NOW())
LEFT JOIN drivers d 
    ON va.driver_id = d.driver_id

-- Join latest GPS record using derived subquery
LEFT JOIN (
    SELECT g1.vehicle_id, g1.latitude, g1.longitude, g1.speed, g1.heading, g1.recorded_at
    FROM gps_locations g1
    INNER JOIN (
        SELECT vehicle_id, MAX(recorded_at) AS max_time
        FROM gps_locations
        GROUP BY vehicle_id
    ) g2 ON g1.vehicle_id = g2.vehicle_id AND g1.recorded_at = g2.max_time
) latest_gps ON v.vehicle_id = latest_gps.vehicle_id

-- Join latest Sensor record using derived subquery
LEFT JOIN (
    SELECT s1.vehicle_id, s1.fuel_level, s1.engine_temperature, s1.engine_rpm, s1.battery_voltage, s1.recorded_at
    FROM sensor_data s1
    INNER JOIN (
        SELECT vehicle_id, MAX(recorded_at) AS max_time
        FROM sensor_data
        GROUP BY vehicle_id
    ) s2 ON s1.vehicle_id = s2.vehicle_id AND s1.recorded_at = s2.max_time
) latest_sensor ON v.vehicle_id = latest_sensor.vehicle_id;

-- 2. ACADEMIC VIEW: fleet_summary_metrics
-- Demonstrates aggregation across multiple tables in a virtual table.
DROP VIEW IF EXISTS fleet_summary_metrics;

CREATE VIEW fleet_summary_metrics AS
SELECT 
    COUNT(DISTINCT v.vehicle_id) AS total_vehicles,
    SUM(CASE WHEN v.status = 'ACTIVE' THEN 1 ELSE 0 END) AS active_vehicles,
    SUM(CASE WHEN v.status = 'MAINTENANCE' THEN 1 ELSE 0 END) AS maintenance_vehicles,
    SUM(CASE WHEN v.status = 'INACTIVE' THEN 1 ELSE 0 END) AS inactive_vehicles,
    (SELECT COUNT(*) FROM trips WHERE status = 'ONGOING') AS active_trips,
    (SELECT COUNT(*) FROM trip_events WHERE event_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR)) AS alerts_24h,
    ROUND(AVG(COALESCE(latest_gps.speed, 0)), 1) AS average_fleet_speed
FROM vehicles v
LEFT JOIN (
    SELECT g1.vehicle_id, g1.speed
    FROM gps_locations g1
    INNER JOIN (
        SELECT vehicle_id, MAX(recorded_at) AS max_time
        FROM gps_locations
        GROUP BY vehicle_id
    ) g2 ON g1.vehicle_id = g2.vehicle_id AND g1.recorded_at = g2.max_time
) latest_gps ON v.vehicle_id = latest_gps.vehicle_id;

-- 3. ACADEMIC VIEW: driver_performance_view
-- Demonstrates multi-table joins, GROUP BY, and aggregates for analytical evaluation.
DROP VIEW IF EXISTS driver_performance_view;

CREATE VIEW driver_performance_view AS
SELECT 
    d.driver_id,
    d.name AS driver_name,
    d.license_no,
    COUNT(t.trip_id) AS total_trips,
    SUM(CASE WHEN t.status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_trips,
    COALESCE(SUM(t.distance_km), 0.00) AS total_km_driven,
    COALESCE(SUM(t.fuel_consumed), 0.00) AS total_fuel_liters,
    (
        SELECT COUNT(*)
        FROM trip_events te
        WHERE te.trip_id IN (SELECT t_sub.trip_id FROM trips t_sub WHERE t_sub.driver_id = d.driver_id)
    ) AS total_safety_alerts
FROM drivers d
LEFT JOIN trips t ON d.driver_id = t.driver_id
GROUP BY d.driver_id, d.name, d.license_no;
