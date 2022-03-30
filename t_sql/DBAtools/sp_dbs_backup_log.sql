SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create the stored procedure in the specified schema
ALTER PROCEDURE [dbo].[sp_dbs_backup_log]
AS
    DECLARE @name VARCHAR(50) -- database name 
    DECLARE @path VARCHAR(256) -- path for backup files
    DECLARE @fileName VARCHAR(256) -- filename for backup 
    DECLARE @fileDate VARCHAR(20) -- used for file name 

    SET @path = '/var/opt/mssql/data/' 

    SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

    DECLARE db_cursor CURSOR FOR 
    SELECT name 
    FROM master.sys.databases 
    WHERE name NOT IN ('model','msdb','tempdb', 'master') --'master'
    AND recovery_model_desc <> 'SIMPLE'

    OPEN db_cursor 
    FETCH NEXT FROM db_cursor INTO @name 

    WHILE @@FETCH_STATUS = 0 
    BEGIN 
    SET @fileName = @path +'/' + @name +'/' + @name + '_log_' + @fileDate + '.bak' 
    BACKUP LOG @name TO DISK = @fileName
    with COMPRESSION

    FETCH NEXT FROM db_cursor INTO @name 
    END 

    CLOSE db_cursor 
    DEALLOCATE db_cursor



GO
