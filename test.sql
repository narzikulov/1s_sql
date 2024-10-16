use [ip_kuzmin_d.a._usno6_envd_2015.10.05] 
 go 
 
-- Запуск функции в цикле
--WHILE EXISTS (SELECT 1 FROM (SELECT Distinct t.name AS TableName 
	--						 FROM sys.tables t 
		--					 JOIN sys.columns c ON t.object_id = c.object_id 
			--				 WHERE t.name LIKE '%_ScheduledJobs%'))
-- BEGIN
 -- Запускаем функцию update_value с именем таблицы из CTE
 -- disable_tasks (SELECT TableName as table_name FROM cte_1);

 -- Переходим к следующей таблице
-- END;

 -- Закрываем курсор
--  CLOSE @table_cursor;

 -- Освобождаем ресурсы
 -- DEALLOCATE @table_cursor;
 go 