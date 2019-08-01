SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_powerbi_log]
AS
BEGIN
	EXEC sp_BlitzFirst 
	  @OutputDatabaseName = 'DBAtools', 
	  @OutputSchemaName = 'dbo', 
	  @OutputTableName = 'BlitzFirst',
	  @OutputTableNameFileStats = 'BlitzFirst_FileStats',
	  @OutputTableNamePerfmonStats = 'BlitzFirst_PerfmonStats',
	  @OutputTableNameWaitStats = 'BlitzFirst_WaitStats',
	  @OutputTableNameBlitzCache = 'BlitzCache';
END
GO
