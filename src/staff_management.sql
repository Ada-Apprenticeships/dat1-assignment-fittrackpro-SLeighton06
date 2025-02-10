-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT staff_id, first_name, last_name, position
FROM staff
ORDER BY position;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
SELECT s.staff_id, (first_name || ' ' || last_name) AS trainer_name, pt.session_date
FROM staff s
LEFT JOIN personal_training_sessions pt ON s.staff_id = pt.staff_id
WHERE pt.session_date BETWEEN DATE('now') AND DATE('now','30 days')