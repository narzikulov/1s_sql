use [smile_usno15_2017.11.10]
SELECT Distinct t.name AS TableName
FROM sys.tables t 
JOIN sys.columns c ON t.object_id = c.object_id 
WHERE t.name LIKE '%_ScheduledJobs%'
order by t.name