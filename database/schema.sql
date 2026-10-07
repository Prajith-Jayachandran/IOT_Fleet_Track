CREATE DATABASE IF NOT EXISTS iot_fleet_tracking
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE iot_fleet_tracking;

-- Disable foreign key checks during schema re-creation if needed
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS trip_events;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS maintenance;
DROP TABLE IF EXISTS sensor_data;
DROP TABLE IF EXISTS gps_locations;
DROP TABLE IF EXISTS vehicle_assignments;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS vehicles;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_no VARCHAR(20) NOT NULL UNIQUE,
    vehicle_type VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE', 'MAINTENANCE') NOT NULL DEFAULT 'ACTIVE',
    fuel_capacity DECIMAL(6,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_fuel_capacity CHECK (fuel_capacity > 0)
) ENGINE=InnoDB;

CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    license_no VARCHAR(50) NOT NULL UNIQUE,
    license_expiry DATE NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE', 'ON_LEAVE') NOT NULL DEFAULT 'ACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE vehicle_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    assigned_from DATETIME NOT NULL,
    assigned_to DATETIME NULL,
    CONSTRAINT fk_va_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_va_driver FOREIGN KEY (driver_id)
        REFERENCES drivers (driver_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE gps_locations (
    location_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    speed DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    heading DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    recorded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_gps_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_latitude CHECK (latitude BETWEEN -90.0 AND 90.0),
    CONSTRAINT chk_longitude CHECK (longitude BETWEEN -180.0 AND 180.0),
    CONSTRAINT chk_speed CHECK (speed >= 0.0)
) ENGINE=InnoDB;

CREATE TABLE sensor_data (
    sensor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    fuel_level DECIMAL(5,2) NOT NULL,
    engine_temperature DECIMAL(5,2) NOT NULL,
    engine_rpm INT NOT NULL DEFAULT 0,
    battery_voltage DECIMAL(4,2) NOT NULL DEFAULT 12.60,
    recorded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sensor_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_fuel_level CHECK (fuel_level BETWEEN 0.0 AND 100.0),
    CONSTRAINT chk_engine_rpm CHECK (engine_rpm >= 0)
) ENGINE=InnoDB;

CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    start_location VARCHAR(150) NOT NULL,
    end_location VARCHAR(150) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    distance_km DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    fuel_consumed DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    status ENUM('PLANNED', 'ONGOING', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PLANNED',
    CONSTRAINT fk_trip_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_trip_driver FOREIGN KEY (driver_id)
        REFERENCES drivers (driver_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE trip_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NULL,
    vehicle_id INT NOT NULL,
    event_type ENUM('SPEED_ALERT', 'HARSH_BRAKING', 'GEOFENCE_ENTRY', 'GEOFENCE_EXIT', 'LOW_FUEL', 'ENGINE_OVERHEAT') NOT NULL,
    description VARCHAR(255) NOT NULL,
    event_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_event_trip FOREIGN KEY (trip_id)
        REFERENCES trips (trip_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_event_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    maintenance_type VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    maintenance_date DATE NOT NULL,
    next_service_date DATE NOT NULL,
    cost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status ENUM('SCHEDULED', 'COMPLETED', 'PENDING') NOT NULL DEFAULT 'SCHEDULED',
    CONSTRAINT fk_maint_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES vehicles (vehicle_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_maint_cost CHECK (cost >= 0.0)
) ENGINE=InnoDB;
