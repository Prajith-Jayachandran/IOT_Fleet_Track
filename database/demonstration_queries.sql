USE iot_fleet_tracking;

-- ---------------------------------------------------------------------
-- 1. INNER JOIN & MULTI-TABLE JOIN
-- Retrieve all ongoing trips with assigned driver name, phone, and vehicle registration
-- ---------------------------------------------------------------------
SELECT 
    t.trip_id,
    v.registration_no,
    v.model,
    d.name AS driver_name,
    d.phone AS driver_phone,
    t.start_location,
    t.end_location,
    t.start_time,
    t.distance_km,
    t.status
FROM trips t
INNER JOIN vehicles v ON t.vehicle_id = v.vehicle_id
INNER JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.status = 'ONGOING'
ORDER BY t.start_time DESC;

-- ---------------------------------------------------------------------
-- 2. LEFT JOIN
-- List all vehicles with their currently active driver assignment (if any)
-- Demonstrates how LEFT JOIN retains vehicles that currently have no assigned driver.
-- ---------------------------------------------------------------------
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.vehicle_type,
    v.status AS vehicle_status,
    va.assigned_from,
    COALESCE(d.name, 'NO DRIVER ASSIGNED') AS driver_name
FROM vehicles v
LEFT JOIN vehicle_assignments va 
    ON v.vehicle_id = va.vehicle_id 
    AND (va.assigned_to IS NULL OR va.assigned_to > NOW())
LEFT JOIN drivers d ON va.driver_id = d.driver_id
ORDER BY v.vehicle_id ASC;

-- ---------------------------------------------------------------------
-- 3. AGGREGATE FUNCTIONS & GROUP BY
-- Calculate average speed, maximum speed, and total GPS pings per vehicle
-- ---------------------------------------------------------------------
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.vehicle_type,
    COUNT(g.location_id) AS total_gps_records,
    ROUND(AVG(g.speed), 2) AS average_speed_kmh,
    ROUND(MAX(g.speed), 2) AS top_speed_kmh
FROM vehicles v
INNER JOIN gps_locations g ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_id, v.registration_no, v.vehicle_type
HAVING COUNT(g.location_id) > 0
ORDER BY average_speed_kmh DESC;

-- ---------------------------------------------------------------------
-- 4. SUM & AGGREGATE WITH GROUP BY
-- Compute total maintenance expenditure and service count per vehicle
-- ---------------------------------------------------------------------
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.manufacturer,
    COUNT(m.maintenance_id) AS total_service_jobs,
    COALESCE(SUM(m.cost), 0.00) AS total_maintenance_cost,
    ROUND(AVG(m.cost), 2) AS average_cost_per_service
FROM vehicles v
LEFT JOIN maintenance m ON v.vehicle_id = m.vehicle_id
GROUP BY v.vehicle_id, v.registration_no, v.manufacturer
ORDER BY total_maintenance_cost DESC;

-- ---------------------------------------------------------------------
-- 5. RANGE FILTERING (BETWEEN) & ORDER BY
-- Find all trips dispatched within a specific date window
-- ---------------------------------------------------------------------
SELECT 
    trip_id,
    vehicle_id,
    driver_id,
    start_location,
    end_location,
    start_time,
    end_time,
    distance_km,
    fuel_consumed
FROM trips
WHERE start_time BETWEEN '2025-03-01 00:00:00' AND '2025-03-05 23:59:59'
ORDER BY start_time ASC;

-- ---------------------------------------------------------------------
-- 6. SUBQUERY WITH AGGREGATE COMPARISON
-- Find all vehicles whose average recorded speed exceeds the overall fleet average speed
-- ---------------------------------------------------------------------
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.model,
    ROUND(AVG(g.speed), 2) AS vehicle_avg_speed
FROM vehicles v
JOIN gps_locations g ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_id, v.registration_no, v.model
HAVING AVG(g.speed) > (
    SELECT AVG(speed) 
    FROM gps_locations 
    WHERE speed > 0
)
ORDER BY vehicle_avg_speed DESC;

-- ---------------------------------------------------------------------
-- 7. EXISTS CLAUSE (Correlated Subquery)
-- Identify vehicles that have experienced safety alerts (SPEED_ALERT or HARSH_BRAKING)
-- ---------------------------------------------------------------------
SELECT 
    v.vehicle_id,
    v.registration_no,
    v.vehicle_type,
    v.status
FROM vehicles v
WHERE EXISTS (
    SELECT 1 
    FROM trip_events te 
    WHERE te.vehicle_id = v.vehicle_id 
      AND te.event_type IN ('SPEED_ALERT', 'HARSH_BRAKING')
);

-- ---------------------------------------------------------------------
-- 8. QUERYING DATABASE VIEWS
-- Read from the virtual table vehicle_latest_status created in views.sql
-- ---------------------------------------------------------------------
SELECT 
    registration_no,
    vehicle_type,
    driver_name,
    latitude,
    longitude,
    speed,
    fuel_level,
    engine_temperature,
    last_updated
FROM vehicle_latest_status
WHERE vehicle_status = 'ACTIVE'
ORDER BY speed DESC;

-- ---------------------------------------------------------------------
-- 9. ACID TRANSACTION DEMONSTRATION: Trip Completion
-- Atomically completes a trip, records final odometer/fuel, marks vehicle,
-- and logs completion event.
-- ---------------------------------------------------------------------
START TRANSACTION;

-- Step 1: Update the trip status and mark end time
UPDATE trips
SET 
    status = 'COMPLETED',
    end_time = NOW(),
    distance_km = 45.50,
    fuel_consumed = 11.20
WHERE trip_id = 15 AND status = 'ONGOING';

-- Step 2: Update the vehicle status back to ACTIVE standby
UPDATE vehicles
SET status = 'ACTIVE'
WHERE vehicle_id = (SELECT vehicle_id FROM trips WHERE trip_id = 15);

-- Step 3: Insert destination arrival trip event
INSERT INTO trip_events (trip_id, vehicle_id, event_type, description, event_time)
VALUES (
    15, 
    1, 
    'GEOFENCE_ENTRY', 
    'Arrived at destination: Oragadam Renault-Nissan Hub. Trip successfully concluded.', 
    NOW()
);

-- If all three operations succeed without integrity violation:
COMMIT;

-- (In case of error during execution, ROLLBACK is issued):
-- ROLLBACK;
