use [ip_kuzmin_d.a._usno6_envd_2015.10.05] 
 go 
 
-- ������ ������� � �����
--WHILE EXISTS (SELECT 1 FROM (SELECT Distinct t.name AS TableName 
	--						 FROM sys.tables t 
		--					 JOIN sys.columns c ON t.object_id = c.object_id 
			--				 WHERE t.name LIKE '%_ScheduledJobs%'))
-- BEGIN
 -- ��������� ������� update_value � ������ ������� �� CTE
 -- disable_tasks (SELECT TableName as table_name FROM cte_1);

 -- ��������� � ��������� �������
-- END;

 -- ��������� ������
--  CLOSE @table_cursor;

 -- ����������� �������
 -- DEALLOCATE @table_cursor;
 go 