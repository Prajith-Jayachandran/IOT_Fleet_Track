USE iot_fleet_tracking;

-- 1. Optimization for vehicle lookup by commercial registration code
-- Primary access path when identifying vehicles from ANPR or manual input
CREATE INDEX idx_vehicles_registration ON vehicles (registration_no);

-- 2. Composite index for GPS temporal queries
-- Optimizes: WHERE vehicle_id = ? ORDER BY recorded_at DESC LIMIT 1
-- and range queries: WHERE vehicle_id = ? AND recorded_at BETWEEN ? AND ?
CREATE INDEX idx_gps_veh_recorded ON gps_locations (vehicle_id, recorded_at DESC);

-- 3. Composite index for Telemetry / Sensor temporal queries
-- Optimizes latest-status joins and engine parameter time-series charts
CREATE INDEX idx_sensor_veh_recorded ON sensor_data (vehicle_id, recorded_at DESC);

-- 4. Composite index for Trip dispatch and vehicle scheduling
-- Optimizes vehicle trip timelines and conflict detection
CREATE INDEX idx_trips_veh_start ON trips (vehicle_id, start_time DESC);

-- 5. Foreign Key and range index for driver trip histories
CREATE INDEX idx_trips_driver ON trips (driver_id, status);

-- 6. Composite index for Maintenance alerting and preventative service queries
-- Optimizes: SELECT * FROM maintenance WHERE next_service_date <= CURDATE()
CREATE INDEX idx_maint_veh_next ON maintenance (vehicle_id, next_service_date);

-- 7. Index on vehicle assignments for current active driver lookups
-- Optimizes: WHERE vehicle_id = ? AND assigned_to IS NULL
CREATE INDEX idx_va_active ON vehicle_assignments (vehicle_id, assigned_to);

-- 8. Index on trip events by trip_id and time for incident forensics
CREATE INDEX idx_events_trip_time ON trip_events (trip_id, event_time DESC);
