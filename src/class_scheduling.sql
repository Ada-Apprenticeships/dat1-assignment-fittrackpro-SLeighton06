-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT cs.class_id, c.name, (s.first_name || ' ' || s.last_name) AS instructor_name
FROM class_schedule cs
INNER JOIN classes c ON cs.class_id = c.class_id
INNER JOIN staff s ON cs.staff_id = s.staff_id;

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT cs.class_id, c.name, start_time, end_time, capacity - COUNT(ca.schedule_id) AS available_spots
FROM class_schedule cs
INNER JOIN classes c ON cs.class_id = c.class_id
INNER JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE SUBSTR(start_time, 1, 10) = '2025-02-01'
GROUP BY cs.schedule_id;

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (7, 11, 'Registered');

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_attendance
WHERE schedule_id = 7 AND member_id = 2;

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT cs.class_id, c.name, COUNT(ca.schedule_id) AS registration_count
FROM class_schedule cs
INNER JOIN classes c ON cs.class_id = c.class_id
INNER JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY cs.schedule_id
ORDER BY registration_count DESC
LIMIT 3;

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member