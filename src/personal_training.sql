-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
SELECT session_id, (m.first_name || ' ' || m.last_name) AS member_name, session_date, start_time, end_time
FROM personal_training_sessions pt
INNER JOIN staff s ON pt.staff_id = s.staff_id
INNER JOIN members m ON pt.member_id = m.member_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin'