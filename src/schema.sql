-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
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
    name VARCHAR(32) NOT NULL,
    address VARCHAR(32) NOT NULL,
    phone_number VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,
    opening_hours VARCHAR(11) NOT NULL
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,
    phone_number VARCHAR(32) NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL,
    emergency_contact_name VARCHAR(32) NOT NULL,
    emergency_contact_phone VARCHAR(32) NOT NULL
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,
    phone_number VARCHAR(32) NOT NULL,
    position VARCHAR(16) NOT NULL CHECK(position IN ('Trainer','Manager','Receptionist','Maintenance')),
    hire_date DATE NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    type VARCHAR(32) NOT NULL CHECK(type IN ('Cardio','Strength')),
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE NOT NULL,
    next_maintenance_date DATE NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    description VARCHAR(32) NOT NULL,
    capacity INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    type VARCHAR(32) NOT NULL CHECK(type IN ('Basic', 'Premium')),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(32) NOT NULL CHECK(status IN ('Active','Inactive')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY,
    schedule_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    attendance_status VARCHAR(32) NOT NULL CHECK(attendance_status IN ('Registered','Attended','Unattended')),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    amount INTEGER NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_method VARCHAR(32) NOT NULL CHECK(payment_method IN ('Credit Card','Bank Transfer','PayPal','Cash')),
    payment_type VARCHAR(32) NOT NULL CHECK(payment_type IN ('Monthly membership fee','Day pass')),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    start_time INTEGER NOT NULL,
    end_time INTEGER NOT NULL,
    notes VARCHAR(32) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INTEGER NOT NULL,
    measurement_date DATE NOT NULL,
    weight INTEGER NOT NULL,
    body_fat_percentage INTEGER NOT NULL,
    muscle_mass INTEGER NOT NULL,
    bmi INTEGER NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY,
    equipment_id INTEGER NOT NULL,
    maintenance_date DATE NOT NULL,
    description VARCHAR(32) NOT NULL,
    staff_id INTEGER NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal