USE [master]
GO

-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN agent_job   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [master]
GO
CREATE USER [agent_job] FOR LOGIN [agent_job];

USE [master]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [agent_job]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [agent_job]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [agent_job]
GO

/*covid_user*/

USE [master]
GO
-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN agent_job   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [master]
GO
CREATE USER [agent_job] FOR LOGIN [agent_job]
    WITH DEFAULT_SCHEMA = [covid19];  

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
WHERE login_name = 'agent_job'

-- Kill Active Users
kill 66;

-- Drop LOGIN
DROP LOGIN [agent_job]
GO

USE [master]
Go

DROP USER [agent_job]
GO

-- Drop covid_user
use [master] 
go

DROP LOGIN [agent_job]
GO

USE [master]
Go

DROP USER [agent_job]
GO