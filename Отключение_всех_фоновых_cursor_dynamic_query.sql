-- Надо оставить включенными фоновое задание "Бухгалтерское Дело"
-- поле _Description like '%Бухгалтерское Дело%'

DECLARE @name VARCHAR(100) -- имя базы данных
DECLARE @number INT -- count
set @number = 1
-- временная таблица для вывода имени базы и имени таблицы фонового задания
create table db_names_and_jobs_names (db_name nvarchar(128), job_name nvarchar(128))


DECLARE db_cursor CURSOR FOR 
SELECT name 
	FROM MASTER.dbo.sysdatabases 
	WHERE name NOT IN ('master','model','msdb','tempdb', '1s_updates_iztisi') -- исключенные базы
	order by 1
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  
WHILE @@FETCH_STATUS = 0  
BEGIN  
	  DECLARE @job_name VARCHAR(50) -- имя задачи
	  declare @job_descr varchar(200) -- описание задачи
	  declare @sql_use varchar(300)
	  declare @sql_bd_and_job_name varchar(500)
	  set @sql_use = 'use [' + @name + ']'
	  --set @sql_use = 'SELECT Distinct t.name AS job_name FROM [' + @name + '].[sys].[tables] t JOIN [' + @name + '].[sys].[columns] c ON t.object_id = c.object_id WHERE t.name LIKE ''%_ScheduledJobs%'' order by t.name '
	  -- print @sql_use
	  exec (@sql_use)
	  set @sql_bd_and_job_name = 'insert into dbo.db_names_and_jobs_names (db_name, job_name) ' +
						'SELECT Distinct ''' + @name + ''' as dn_name, t.name AS job_name ' +
						-- 'into db_names_and_jobs_names ' +
						'FROM [' + @name + '].[sys].[tables] t ' + 
						'JOIN [' + @name + '].[sys].[columns] c ON t.object_id = c.object_id ' +
						'WHERE t.name LIKE ''%_ScheduledJobs%'' ' +
						'order by t.name'
	   exec (@sql_bd_and_job_name)
	   FETCH NEXT FROM db_cursor INTO @name 
END 
CLOSE db_cursor  
DEALLOCATE db_cursor

declare @db_name nvarchar(128)
declare @task_name nvarchar(128)
declare @sql_update_cmd nvarchar(256)
DECLARE db_and_jobs_cursor CURSOR FOR 
	SELECT db_name, job_name FROM dbo.db_names_and_jobs_names
open db_and_jobs_cursor
FETCH NEXT FROM db_and_jobs_cursor INTO @db_name, @task_name
WHILE @@FETCH_STATUS = 0  
BEGIN 
	set @sql_update_cmd = 'use [' + @db_name + '] update ' + @task_name + ' set _Use = 0x00 where _Description not like ''%Бухгалтерское Дело%'''
	-- set @sql_update_cmd = 'use [' + @db_name + '] select _Description from ' + @task_name 
	-- print (@sql_update_cmd)
	exec (@sql_update_cmd)
	FETCH NEXT FROM db_and_jobs_cursor INTO @db_name, @task_name
END
CLOSE db_and_jobs_cursor  
DEALLOCATE db_and_jobs_cursor

drop table db_names_and_jobs_names
