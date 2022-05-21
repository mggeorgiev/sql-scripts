USE [master]
GO
-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN [powerbi]   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [master]
GO
CREATE USER [powerbi] FOR LOGIN [powerbi]
    WITH DEFAULT_SCHEMA = [master];  

USE [master]
GO
GRANT INSERT ON SCHEMA :: [dbo] TO [agent_job];
GO
GRANT SELECT ON SCHEMA :: [dbo] TO [agent_job];
GO
GRANT UPDATE ON SCHEMA :: [dbo] TO [agent_job];
GO
GRANT DELETE ON SCHEMA :: [dbo] TO [agent_job];
GO


-- Select Server Principals
SELECT sys.server_role_members.role_principal_id, role.name AS RoleName,   
    sys.server_role_members.member_principal_id, member.name AS MemberName  
FROM sys.server_role_members  
JOIN sys.server_principals AS role  
    ON sys.server_role_members.role_principal_id = role.principal_id  
JOIN sys.server_principals AS member  
    ON sys.server_role_members.member_principal_id = member.principal_id;

-- Active Users
SELECT session_id
FROM sys.dm_exec_sessions
WHERE login_name = 'powerbi'

-- Kill Active Users
kill 66;

-- Drop LOGIN
DROP LOGIN [powerbi]
GO

USE [master]
Go

DROP USER [powerbi]
GO

-- Drop covid_user
use [master] 
go

DROP LOGIN [powerbi]
GO

USE [master]
Go

DROP USER [powerbi]
GO