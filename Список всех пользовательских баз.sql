select
	name from sys.databases
where
	name <> 'master' and 
	name <> 'model' and 
	name <> 'msdb' and 
	name <> 'tempdb' and
	name <> '1s_updates_iztisi'
	order by name