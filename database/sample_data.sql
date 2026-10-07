USE iot_fleet_tracking;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE trip_events;
TRUNCATE TABLE trips;
TRUNCATE TABLE maintenance;
TRUNCATE TABLE sensor_data;
TRUNCATE TABLE gps_locations;
TRUNCATE TABLE vehicle_assignments;
TRUNCATE TABLE drivers;
TRUNCATE TABLE vehicles;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO vehicles (vehicle_id, registration_no, vehicle_type, model, manufacturer, status, fuel_capacity, created_at) VALUES
(1,  'TN01AB1234', 'Heavy Truck',       'Prima 5530.S',        'Tata Motors',    'ACTIVE',      300.00, '2025-01-10 08:00:00'),
(2,  'TN02CD5678', 'Container Carrier', 'Captain 40i',         'Ashok Leyland',  'ACTIVE',      350.00, '2025-01-12 09:30:00'),
(3,  'TN03EF9012', 'Delivery Van',      'Bolero Maxi Truck',   'Mahindra',       'ACTIVE',       60.00, '2025-01-15 10:15:00'),
(4,  'TN04GH3456', 'Heavy Truck',       'Signa 4825.TK',       'Tata Motors',    'ACTIVE',      280.00, '2025-01-20 11:00:00'),
(5,  'TN05IJ7890', 'Electric Bus',      'Switch EiV 12',       'Ashok Leyland',  'ACTIVE',      200.00, '2025-01-22 14:00:00'),
(6,  'TN07KL2345', 'Light Commercial',  'Pro 2049',            'Eicher Motors',  'ACTIVE',       80.00, '2025-01-25 09:00:00'),
(7,  'TN09MN6789', 'Heavy Truck',       '3528C Tipper',        'BharatBenz',     'ACTIVE',      260.00, '2025-02-01 08:30:00'),
(8,  'TN10OP0123', 'Refrigerated Van',  'Furio 7 HD',          'Mahindra',       'ACTIVE',      120.00, '2025-02-03 12:45:00'),
(9,  'TN11QR4567', 'Long Haul Truck',   'FM 420 8x4',          'Volvo Trucks',   'ACTIVE',      400.00, '2025-02-05 15:20:00'),
(10, 'TN14ST8901', 'Delivery Van',      'Tata Ace Gold',       'Tata Motors',    'ACTIVE',       45.00, '2025-02-08 10:00:00'),
(11, 'TN18UV2345', 'Heavy Truck',       'AVTR 4220',           'Ashok Leyland',  'ACTIVE',      320.00, '2025-02-10 11:30:00'),
(12, 'TN22WX6789', 'Electric Van',      'Supro Profit Truck',  'Mahindra',       'ACTIVE',       75.00, '2025-02-12 16:00:00'),
(13, 'TN04YZ0123', 'Light Commercial',  'Pro 3015',            'Eicher Motors',  'ACTIVE',      150.00, '2025-02-15 09:10:00'),
(14, 'TN05AB4321', 'Heavy Truck',       '2823R',               'BharatBenz',     'ACTIVE',      280.00, '2025-02-18 13:00:00'),
(15, 'TN09CD8765', 'Container Carrier', 'Prima 4028.S',        'Tata Motors',    'ACTIVE',      330.00, '2025-02-20 14:15:00'),
(16, 'TN10EF2109', 'Heavy Truck',       'Boss 1914',           'Ashok Leyland',  'MAINTENANCE', 220.00, '2025-02-22 08:45:00'),
(17, 'TN11GH6543', 'Delivery Van',      'Bada Dost i4',        'Ashok Leyland',  'MAINTENANCE',  70.00, '2025-02-25 11:00:00'),
(18, 'TN14IJ0987', 'Light Commercial',  'Pro 2059XP',          'Eicher Motors',  'MAINTENANCE',  90.00, '2025-02-28 10:30:00'),
(19, 'TN18KL5432', 'Utility Van',       'Bolero Camper',       'Mahindra',       'INACTIVE',     65.00, '2025-03-01 12:00:00'),
(20, 'TN22MN9876', 'Heavy Truck',       '1618C',               'BharatBenz',     'INACTIVE',    250.00, '2025-03-05 09:00:00');

INSERT INTO drivers (driver_id, name, phone, license_no, license_expiry, status, created_at) VALUES
(1,  'Rajesh Kumar',       '+91 98401 23456', 'TN01-20150001234', '2028-05-15', 'ACTIVE',   '2025-01-05 09:00:00'),
(2,  'Suresh Raina',       '+91 98402 34567', 'TN02-20160002345', '2027-11-20', 'ACTIVE',   '2025-01-05 09:30:00'),
(3,  'Ramesh Chandran',    '+91 98403 45678', 'TN03-20170003456', '2029-01-10', 'ACTIVE',   '2025-01-06 10:00:00'),
(4,  'Anbu Selvan',        '+91 98404 56789', 'TN04-20140004567', '2026-12-05', 'ACTIVE',   '2025-01-06 10:30:00'),
(5,  'Karthik Sundar',     '+91 98405 67890', 'TN05-20180005678', '2030-03-25', 'ACTIVE',   '2025-01-07 11:00:00'),
(6,  'Dinesh Karthik',     '+91 98406 78901', 'TN07-20190006789', '2028-08-14', 'ACTIVE',   '2025-01-08 14:00:00'),
(7,  'Vijay Anand',        '+91 98407 89012', 'TN09-20160007890', '2027-04-18', 'ACTIVE',   '2025-01-09 15:00:00'),
(8,  'Arvind Swamy',       '+91 98408 90123', 'TN10-20150008901', '2026-10-30', 'ACTIVE',   '2025-01-10 09:00:00'),
(9,  'Vignesh Shivan',     '+91 98409 01234', 'TN11-20200009012', '2031-07-09', 'ACTIVE',   '2025-01-11 10:00:00'),
(10, 'Prakash Raj',        '+91 98410 12345', 'TN14-20170010123', '2029-09-12', 'ACTIVE',   '2025-01-12 11:30:00'),
(11, 'Murugan Velu',       '+91 98411 23456', 'TN18-20180011234', '2028-02-28', 'ACTIVE',   '2025-01-13 13:00:00'),
(12, 'Selva Kumar',        '+91 98412 34567', 'TN22-20190012345', '2030-06-19', 'ACTIVE',   '2025-01-14 14:30:00'),
(13, 'Anand Babu',         '+91 98413 45678', 'TN01-20130013456', '2026-08-11', 'ACTIVE',   '2025-01-15 15:00:00'),
(14, 'Saravanan Govind',   '+91 98414 56789', 'TN02-20140014567', '2027-01-22', 'ON_LEAVE', '2025-01-16 09:30:00'),
(15, 'Balaji Natarajan',   '+91 98415 67890', 'TN03-20160015678', '2026-06-30', 'INACTIVE', '2025-01-17 10:15:00');

INSERT INTO vehicle_assignments (assignment_id, vehicle_id, driver_id, assigned_from, assigned_to) VALUES
-- Historical assignments
(1,  1,  1, '2025-01-11 00:00:00', '2025-01-31 23:59:59'),
(2,  2,  2, '2025-01-13 00:00:00', '2025-01-31 23:59:59'),
(3,  3,  3, '2025-01-16 00:00:00', '2025-01-31 23:59:59'),
(4,  4,  4, '2025-01-21 00:00:00', '2025-01-31 23:59:59'),
(5,  5,  5, '2025-01-23 00:00:00', '2025-01-31 23:59:59'),
(6,  6,  6, '2025-01-26 00:00:00', '2025-01-31 23:59:59'),
(7,  1,  2, '2025-02-01 00:00:00', '2025-02-28 23:59:59'),
-- Current active assignments (assigned_to IS NULL)
(8,  1,  1,  '2025-03-01 00:00:00', NULL),
(9,  2,  2,  '2025-03-01 00:00:00', NULL),
(10, 3,  3,  '2025-03-01 00:00:00', NULL),
(11, 4,  4,  '2025-03-01 00:00:00', NULL),
(12, 5,  5,  '2025-03-01 00:00:00', NULL),
(13, 6,  6,  '2025-03-01 00:00:00', NULL),
(14, 7,  7,  '2025-03-01 00:00:00', NULL),
(15, 8,  8,  '2025-03-01 00:00:00', NULL),
(16, 9,  9,  '2025-03-01 00:00:00', NULL),
(17, 10, 10, '2025-03-01 00:00:00', NULL),
(18, 11, 11, '2025-03-01 00:00:00', NULL),
(19, 12, 12, '2025-03-01 00:00:00', NULL),
(20, 13, 13, '2025-03-01 00:00:00', NULL),
(21, 14, 1,  '2025-03-01 00:00:00', NULL),
(22, 15, 7,  '2025-03-01 00:00:00', NULL);

INSERT INTO trips (trip_id, vehicle_id, driver_id, start_location, end_location, start_time, end_time, distance_km, fuel_consumed, status) VALUES
-- Completed trips
(1,  1,  1,  'Chennai Port Terminal',       'Sriperumbudur Auto Hub',  '2025-03-01 06:00:00', '2025-03-01 08:30:00',  54.20, 16.50, 'COMPLETED'),
(2,  2,  2,  'Koyambedu Logistics Park',    'Mahindra World City',     '2025-03-01 07:15:00', '2025-03-01 09:45:00',  48.60, 14.80, 'COMPLETED'),
(3,  3,  3,  'Guindy Industrial Estate',    'OMR Sholinganallur',      '2025-03-01 08:30:00', '2025-03-01 09:50:00',  22.40,  4.20, 'COMPLETED'),
(4,  4,  4,  'Ennore Port Freight Gate',    'Oragadam Industrial Area','2025-03-02 05:00:00', '2025-03-02 08:00:00',  68.50, 22.00, 'COMPLETED'),
(5,  5,  5,  'Chennai Central Station',     'Tambaram Bus Terminal',   '2025-03-02 09:00:00', '2025-03-02 10:45:00',  29.80,  0.00, 'COMPLETED'),
(6,  6,  6,  'Ambattur Industrial Estate',  'Kelambakkam Depot',       '2025-03-02 11:00:00', '2025-03-02 13:10:00',  42.00,  8.50, 'COMPLETED'),
(7,  7,  7,  'Madhavaram Truck Terminal',   'Chengalpattu Logistics',  '2025-03-03 06:30:00', '2025-03-03 09:30:00',  72.10, 24.30, 'COMPLETED'),
(8,  8,  8,  'Koyambedu Cold Storage',      'Thiruvanmiyur Hub',       '2025-03-03 08:00:00', '2025-03-03 09:20:00',  19.50,  3.90, 'COMPLETED'),
(9,  9,  9,  'Ennore Thermal Depot',        'Tiruvallur Rail Freight', '2025-03-03 10:00:00', '2025-03-03 12:40:00',  55.40, 26.50, 'COMPLETED'),
(10, 10, 10, 'T. Nagar Retail Hub',         'Velachery Express Center','2025-03-04 07:00:00', '2025-03-04 08:15:00',  14.20,  2.10, 'COMPLETED'),
(11, 11, 11, 'Chennai Port Gate 1',         'Gummidipoondi SIPCOT',    '2025-03-04 08:30:00', '2025-03-04 11:15:00',  58.90, 20.40, 'COMPLETED'),
(12, 12, 12, 'Adyar Distribution Node',    'ECR Kovalam Hub',         '2025-03-04 12:00:00', '2025-03-04 13:30:00',  28.00,  0.00, 'COMPLETED'),
(13, 13, 13, 'Red Hills Godown',            'Poonamallee Warehouses',  '2025-03-05 06:00:00', '2025-03-05 07:45:00',  31.50,  6.80, 'COMPLETED'),
(14, 14, 1,  'Manali Petrochem Gate',       'Sriperumbudur SEZ',       '2025-03-05 09:00:00', '2025-03-05 12:00:00',  64.20, 21.00, 'COMPLETED'),
-- Ongoing trips (Actively tracked)
(15, 1,  1,  'Chennai Port Container Yard', 'Oragadam Renault-Nissan', '2025-03-06 07:30:00', NULL,                  38.00, 12.00, 'ONGOING'),
(16, 2,  2,  'Koyambedu Wholesale Depot',   'Chengalpattu Food Park',  '2025-03-06 08:00:00', NULL,                  29.50,  9.50, 'ONGOING'),
(17, 3,  3,  'Guindy Electronics Complex',  'Siruseri SIPCOT IT Park', '2025-03-06 08:45:00', NULL,                  18.20,  3.60, 'ONGOING'),
(18, 4,  4,  'Ennore Port Berth 2',         'Sriperumbudur Hyundai Hub','2025-03-06 09:15:00', NULL,                  42.00, 13.50, 'ONGOING'),
(19, 7,  7,  'Madhavaram Terminal',         'Tambaram Airbase Node',   '2025-03-06 09:30:00', NULL,                  25.10,  8.20, 'ONGOING'),
(20, 9,  9,  'Chennai International Airport','Mahindra World City',    '2025-03-06 10:00:00', NULL,                  15.40,  6.80, 'ONGOING'),
-- Planned trips
(21, 5,  5,  'Chennai Central Metro',       'Mahabalipuram Tourist Hub','2025-03-07 06:00:00', NULL,                   0.00,  0.00, 'PLANNED'),
(22, 6,  6,  'Ambattur Industrial Area',    'Kattupalli Port Terminal','2025-03-07 07:30:00', NULL,                   0.00,  0.00, 'PLANNED');

INSERT INTO maintenance (maintenance_id, vehicle_id, maintenance_type, description, maintenance_date, next_service_date, cost, status) VALUES
(1,  1,  'Brake System Overhaul',    'Replaced front and rear air brake liners, inspected drums', '2025-01-20', '2025-04-20',  18500.00, 'COMPLETED'),
(2,  2,  'Engine Oil & Filters',     'Full synthetic engine oil replacement with lube filters',   '2025-02-05', '2025-05-05',  12200.00, 'COMPLETED'),
(3,  3,  'Scheduled 20,000km Service','General inspection, wheel alignment, tire rotation',       '2025-02-15', '2025-05-15',   6500.00, 'COMPLETED'),
(4,  4,  'Transmission Inspection',  'Clutch plate replacement, gearbox oil replenishment',       '2025-02-25', '2025-05-25',  24000.00, 'COMPLETED'),
(5,  7,  'Suspension Bushing Tuning','Heavy leaf spring retorquing, shock absorber overhaul',     '2025-01-10', '2025-04-10',  15400.00, 'COMPLETED'),
-- Overdue maintenance records (next_service_date < Current Date)
(6,  16, 'Turbocharger Calibration', 'Exhaust manifold inspection and turbo blade clearance test', '2024-11-10', '2025-02-10',  32000.00, 'PENDING'),
(7,  17, 'Cooling System Flush',     'Radiator core descaling, coolant replacement, water pump test','2024-11-25','2025-02-25',   8500.00, 'PENDING'),
(8,  18, 'Electrical Rewiring',      'Alternator overhaul, diagnostic battery pack balance test', '2024-12-01', '2025-03-01',   9200.00, 'PENDING'),
-- Upcoming / Due Soon (Within March 2025 / near future)
(9,  5,  'High-Voltage Battery Pack','Thermal management fluid inspection & motor firmware update','2025-03-12', '2025-03-20',  28000.00, 'SCHEDULED'),
(10, 8,  'Reefer Compressor Service','Refrigerant leak detection and thermostat sensor calibration','2025-03-15', '2025-03-25',  14000.00, 'SCHEDULED'),
(11, 10, 'Brake Shoe & Cable Tuning','Handbrake cable tensioning, front disc inspection',         '2025-03-18', '2025-03-28',   4500.00, 'SCHEDULED'),
(12, 11, 'Steering Column Greasing', 'Hydraulic power steering pump flush and kingpin greasing',   '2025-03-20', '2025-04-05',  11000.00, 'SCHEDULED');

INSERT INTO trip_events (event_id, trip_id, vehicle_id, event_type, description, event_time) VALUES
(1,  1,  1,  'GEOFENCE_EXIT',   'Exited Chennai Port Customs Zone towards NH48',             '2025-03-01 06:18:22'),
(2,  1,  1,  'SPEED_ALERT',     'Speed registered at 88.4 km/h on Chennai Outer Ring Road',   '2025-03-01 07:12:10'),
(3,  1,  1,  'GEOFENCE_ENTRY',  'Entered Sriperumbudur Industrial Estate Geofence',          '2025-03-01 08:15:40'),
(4,  2,  2,  'HARSH_BRAKING',   'Sudden deceleration detected (-4.2 m/s²) near Tambaram bypass','2025-03-01 08:35:12'),
(5,  4,  4,  'SPEED_ALERT',     'Speed registered at 84.1 km/h on Minjur-Vandalur highway',  '2025-03-02 06:22:04'),
(6,  4,  4,  'HARSH_BRAKING',   'Emergency brake trigger near Sriperumbudur junction',        '2025-03-02 07:41:19'),
(7,  9,  9,  'ENGINE_OVERHEAT', 'Coolant temperature reached 104.2°C during high load ascent','2025-03-03 11:18:50'),
(8,  11, 11, 'SPEED_ALERT',     'Speed registered at 86.8 km/h on NH16 North bypass',        '2025-03-04 09:40:15'),
(9,  15, 1,  'GEOFENCE_EXIT',   'Departed Chennai Port Yard for Oragadam Auto Cluster',      '2025-03-06 07:45:00'),
(10, 16, 2,  'LOW_FUEL',        'Fuel reserve dropped below 15% threshold (14.2% remaining)','2025-03-06 09:12:44'),
(11, 17, 3,  'HARSH_BRAKING',   'Abrupt braking event recorded at OMR Sholinganallur junction','2025-03-06 09:20:18'),
(12, 18, 4,  'SPEED_ALERT',     'Speed registered at 87.2 km/h on Thiruvallur highway',      '2025-03-06 10:05:32');

INSERT INTO gps_locations (location_id, vehicle_id, latitude, longitude, speed, heading, recorded_at) VALUES
-- Vehicle 1: Chennai Port -> Sriperumbudur (Active ongoing trip on NH48)
(1,  1, 13.0900000, 80.2900000, 42.50,  85.00, '2025-03-06 08:00:00'),
(2,  1, 13.0780000, 80.2400000, 56.20, 260.00, '2025-03-06 08:30:00'),
(3,  1, 13.0520000, 80.1500000, 68.40, 255.00, '2025-03-06 09:00:00'),
(4,  1, 13.0110000, 80.0500000, 74.10, 248.00, '2025-03-06 09:30:00'),
(5,  1, 12.9754000, 79.9721000, 62.50, 245.00, '2025-03-06 10:00:00'),

-- Vehicle 2: Koyambedu -> Chengalpattu (GST Road Corridor)
(6,  2, 13.0694000, 80.1948000, 35.00, 180.00, '2025-03-06 08:15:00'),
(7,  2, 13.0120000, 80.1700000, 48.00, 195.00, '2025-03-06 08:45:00'),
(8,  2, 12.9550000, 80.1380000, 58.50, 205.00, '2025-03-06 09:15:00'),
(9,  2, 12.9125000, 80.1110000, 61.20, 210.00, '2025-03-06 09:45:00'),
(10, 2, 12.8710000, 80.0820000, 55.40, 208.00, '2025-03-06 10:00:00'),

-- Vehicle 3: Guindy -> Siruseri IT Corridor (OMR Rajiv Gandhi Salai)
(11, 3, 13.0067000, 80.2025000, 28.00, 140.00, '2025-03-06 08:50:00'),
(12, 3, 12.9750000, 80.2450000, 44.00, 175.00, '2025-03-06 09:15:00'),
(13, 3, 12.9210000, 80.2310000, 52.00, 182.00, '2025-03-06 09:40:00'),
(14, 3, 12.8680000, 80.2220000, 48.20, 180.00, '2025-03-06 10:00:00'),

-- Vehicle 4: Ennore -> Sriperumbudur
(15, 4, 13.2350000, 80.3300000, 45.00, 220.00, '2025-03-06 09:20:00'),
(16, 4, 13.1600000, 80.2400000, 62.00, 230.00, '2025-03-06 09:45:00'),
(17, 4, 13.0950000, 80.1000000, 71.50, 240.00, '2025-03-06 10:00:00'),

-- Vehicle 5: Chennai Metro Electric Bus (Anna Salai Route)
(18, 5, 13.0827000, 80.2707000, 32.00, 210.00, '2025-03-06 09:30:00'),
(19, 5, 13.0450000, 80.2480000, 28.50, 215.00, '2025-03-06 09:50:00'),
(20, 5, 13.0180000, 80.2210000, 36.00, 220.00, '2025-03-06 10:00:00'),

-- Vehicles 6 to 15 (Active Fleet Coordinates)
(21, 6,  13.0850000, 80.1600000, 41.00, 120.00, '2025-03-06 10:00:00'),
(22, 7,  13.1500000, 80.1900000, 59.50, 190.00, '2025-03-06 10:00:00'),
(23, 8,  12.9800000, 80.2500000, 38.20, 160.00, '2025-03-06 10:00:00'),
(24, 9,  12.9900000, 80.1650000, 66.80, 205.00, '2025-03-06 10:00:00'),
(25, 10, 13.0400000, 80.2300000, 22.00, 110.00, '2025-03-06 10:00:00'),
(26, 11, 13.1800000, 80.2800000, 52.40,  40.00, '2025-03-06 10:00:00'),
(27, 12, 12.9200000, 80.2500000, 35.00, 170.00, '2025-03-06 10:00:00'),
(28, 13, 13.1200000, 80.1800000, 48.00, 230.00, '2025-03-06 10:00:00'),
(29, 14, 13.1400000, 80.2700000, 60.50, 250.00, '2025-03-06 10:00:00'),
(30, 15, 13.0800000, 80.2900000, 15.00,  80.00, '2025-03-06 10:00:00'),

-- Vehicles 16 to 18 (Maintenance Depot - Guindy / Ambattur Workshop)
(31, 16, 13.0100000, 80.2100000,  0.00,   0.00, '2025-03-06 10:00:00'),
(32, 17, 13.0850000, 80.1550000,  0.00,   0.00, '2025-03-06 10:00:00'),
(33, 18, 13.0080000, 80.2080000,  0.00,   0.00, '2025-03-06 10:00:00'),

-- Vehicles 19 to 20 (Inactive Fleet Depot - Madhavaram Yards)
(34, 19, 13.1480000, 80.2050000,  0.00,   0.00, '2025-03-06 10:00:00'),
(35, 20, 13.1490000, 80.2070000,  0.00,   0.00, '2025-03-06 10:00:00');

INSERT INTO sensor_data (sensor_id, vehicle_id, fuel_level, engine_temperature, engine_rpm, battery_voltage, recorded_at) VALUES
-- Vehicle 1
(1,  1, 88.50, 82.50, 1450, 13.80, '2025-03-06 08:00:00'),
(2,  1, 84.20, 86.00, 1850, 14.10, '2025-03-06 08:30:00'),
(3,  1, 80.10, 88.40, 2100, 14.20, '2025-03-06 09:00:00'),
(4,  1, 75.80, 89.20, 2250, 14.10, '2025-03-06 09:30:00'),
(5,  1, 71.50, 87.50, 1950, 13.90, '2025-03-06 10:00:00'),

-- Vehicle 2
(6,  2, 62.00, 84.00, 1200, 13.80, '2025-03-06 08:15:00'),
(7,  2, 58.40, 87.20, 1600, 14.00, '2025-03-06 08:45:00'),
(8,  2, 54.00, 89.50, 1900, 14.10, '2025-03-06 09:15:00'),
(9,  2, 49.50, 90.10, 1950, 14.00, '2025-03-06 09:45:00'),
(10, 2, 45.20, 88.00, 1750, 13.90, '2025-03-06 10:00:00'),

-- Vehicle 3
(11, 3, 78.00, 80.50, 1100, 13.90, '2025-03-06 08:50:00'),
(12, 3, 75.20, 83.00, 1500, 14.00, '2025-03-06 09:15:00'),
(13, 3, 72.00, 85.50, 1750, 14.10, '2025-03-06 09:40:00'),
(14, 3, 68.80, 84.20, 1600, 14.00, '2025-03-06 10:00:00'),

-- Vehicle 4
(15, 4, 55.00, 85.00, 1600, 13.90, '2025-03-06 09:20:00'),
(16, 4, 50.80, 89.80, 2050, 14.20, '2025-03-06 09:45:00'),
(17, 4, 46.20, 91.50, 2300, 14.10, '2025-03-06 10:00:00'),

-- Vehicle 5 (Electric Bus: battery state simulated in fuel_level)
(18, 5, 92.00, 65.00,  950, 13.80, '2025-03-06 09:30:00'),
(19, 5, 87.50, 67.50,  900, 13.80, '2025-03-06 09:50:00'),
(20, 5, 83.00, 68.00, 1100, 13.90, '2025-03-06 10:00:00'),

-- Vehicles 6 to 15 (Active Telemetry)
(21, 6,  79.20, 83.10, 1480, 14.00, '2025-03-06 10:00:00'),
(22, 7,  58.00, 88.50, 2020, 14.10, '2025-03-06 10:00:00'),
(23, 8,  66.50, 82.00, 1350, 13.90, '2025-03-06 10:00:00'),
(24, 9,  42.00, 92.40, 2200, 14.20, '2025-03-06 10:00:00'),
(25, 10, 85.00, 79.50,  920, 13.70, '2025-03-06 10:00:00'),
(26, 11, 64.80, 86.20, 1800, 14.00, '2025-03-06 10:00:00'),
(27, 12, 91.00, 68.50, 1050, 13.80, '2025-03-06 10:00:00'),
(28, 13, 73.20, 84.70, 1680, 13.90, '2025-03-06 10:00:00'),
(29, 14, 52.40, 89.00, 2150, 14.10, '2025-03-06 10:00:00'),
(30, 15, 80.00, 81.20,  850, 13.60, '2025-03-06 10:00:00'),

-- Vehicles 16 to 18 (Maintenance: engine off)
(31, 16, 35.00, 32.00,    0, 12.30, '2025-03-06 10:00:00'),
(32, 17, 22.50, 34.00,    0, 12.20, '2025-03-06 10:00:00'),
(33, 18, 48.00, 31.50,    0, 12.40, '2025-03-06 10:00:00'),

-- Vehicles 19 to 20 (Inactive: parked)
(34, 19, 60.00, 30.00,    0, 12.50, '2025-03-06 10:00:00'),
(35, 20, 18.00, 29.50,    0, 12.10, '2025-03-06 10:00:00');
