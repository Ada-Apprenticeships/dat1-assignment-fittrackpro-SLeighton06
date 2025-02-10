-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT member_id, first_name, last_name, email, join_date
FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
UPDATE members
SET email = 'emily.jones.updated@email.com', phone_number = '555-9876'
WHERE (member_id = 5);

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) AS total_members
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
WITH registered_counts AS (
    SELECT m.member_id, m.first_name, COUNT(ca.member_id) AS registered_count
    FROM members m
    LEFT JOIN class_attendance ca ON m.member_id = ca.member_id AND attendance_status = 'Registered'
    GROUP BY m.member_id, m.first_name
)
SELECT member_id, first_name, registered_count
FROM registered_counts
WHERE registered_count = (SELECT MAX(registered_count) FROM registered_counts);

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations
WITH registered_counts AS (
    SELECT m.member_id, m.first_name, COUNT(ca.member_id) AS registered_count
    FROM members m
    LEFT JOIN class_attendance ca ON m.member_id = ca.member_id AND attendance_status = 'Registered'
    GROUP BY m.member_id, m.first_name
)
SELECT member_id, first_name, registered_count
FROM registered_counts
WHERE registered_count = (SELECT MIN(registered_count) FROM registered_counts);

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class