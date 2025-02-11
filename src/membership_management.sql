-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT m.member_id, m.first_name, m.last_name, ms.type, m.join_date
FROM memberships ms
INNER JOIN members m ON ms.member_id = m.member_id
WHERE status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
SELECT type, AVG(JULIANDAY(check_out_time) - JULIANDAY(check_in_time)) * 1440 AS avg_visit_duration_minutes
FROM memberships ms
INNER JOIN attendance a ON ms.member_id = a.member_id
GROUP BY type;

-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT ms.member_id, first_name, last_name, email, end_date
FROM memberships ms
INNER JOIN members m ON ms.member_id = m.member_id
WHERE JULIANDAY(end_date) - JULIANDAY('now') < 365