SELECT name, user_access_desc, state_desc, log_reuse_wait_desc
FROM sys.databases;

EXEC dbo.sp_whoisactive;

EXEC dbo.sp_AskBrent @ExpertMode=1, @Seconds=1;

EXEC xp_readerrorlog @p1=0, @p2=1;