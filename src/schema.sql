-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Create your tables here
-- Example:
-- CREATE TABLE table_name (
--     column1 datatype,
--     column2 datatype,
--     ...
-- );

-- TODO: Create the following tables:
-- 1. locations
-- 2. members
-- 3. staff
-- 4. equipment
-- 5. classes
-- 6. class_schedule
-- 7. memberships
-- 8. attendance
-- 9. class_attendance
-- 10. payments
-- 11. personal_training_sessions
-- 12. member_health_metrics
-- 13. equipment_maintenance_log

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    name VARCHAR(32),
    address VARCHAR(32),
    phone_number VARCHAR(32),
    email VARCHAR(32),
    opening_hours VARCHAR(11)
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    email VARCHAR(32),
    phone_number VARCHAR(32),
    date_of_birth DATE,
    join_date DATE
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    email VARCHAR(32),
    phone_number VARCHAR(32),
    position VARCHAR(16),
    hire_date DATE,
    location_id INTEGER
);

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY,
    name VARCHAR(32),
    type VARCHAR(32),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INTEGER
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name VARCHAR(32),
    description VARCHAR(32),
    capacity INTEGER,
    duration INTEGER,
    location_id INTEGER
);

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATE,
    end_time DATE
);

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    type VARCHAR(32),
    start_date DATE,
    end_date DATE,
    status VARCHAR(32)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    location_id INTEGER,
    check_in_time DATE,
    check_out_time DATE
);

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY,
    schedule_id INTEGER,
    member_id INTEGER,
    attendance_status VARCHAR(32)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    amount INTEGER,
    payment_date DATE,
    payment_method VARCHAR(32),
    payment_type VARCHAR(32)
);

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    staff_id INTEGER,
    session_date DATE,
    start_time DATE,
    end_time DATE,
    notes VARCHAR(32)
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    measurement_date DATE,
    weight INTEGER,
    body_fat_percentage INTEGER,
    muscle_mass INTEGER,
    bmi INTEGER
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY,
    equipment_id INTEGER,
    maintenance_date DATE,
    description VARCHAR(32),
    staff_id INTEGER
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal