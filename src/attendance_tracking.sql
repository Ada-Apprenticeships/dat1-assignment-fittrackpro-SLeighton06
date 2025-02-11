-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, datetime('now'));

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
SELECT substr(check_in_time, 1, 10) AS visit_date, substr(check_in_time, 12, 8) AS check_in_time, substr(check_out_time, 12, 8) AS check_out_time
FROM attendance
WHERE member_id = 5;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
SELECT CASE CAST (strftime('%w', check_in_time) AS integer)
  WHEN 0 THEN 'Sunday'
  WHEN 1 THEN 'Monday'
  WHEN 2 THEN 'Tuesday'
  WHEN 3 THEN 'Wednesday'
  WHEN 4 THEN 'Thursday'
  WHEN 5 THEN 'Friday'
  ELSE 'Saturday' END AS day_of_week,
  COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY COUNT(*) DESC LIMIT 1

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location