use [abrikos_ooo_usno15_2023-03-09]
go

declare @count int
with cte_1 (TableName) as (
	SELECT Distinct t.name AS TableName
	FROM sys.tables t 
	JOIN sys.columns c ON t.object_id = c.object_id 
	WHERE t.name LIKE '%_ScheduledJobs%'
)
select @count = count(TableName) from cte_1 where TableName = '_ScheduledJobs38403'
if @count > 0 update dbo._ScheduledJobs38403 set _Use = 0x01
go