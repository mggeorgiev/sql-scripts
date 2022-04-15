USE [master]
GO

-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN occupations_admin   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

GRANT INSERT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT SELECT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT UPDATE ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT DELETE ON SCHEMA :: [dbo] TO [occupations_admin];
GO

-- Creates a database user for the login created above.  
USE [master]
GO
CREATE USER [occupations_admin] FOR LOGIN [occupations_admin];

USE [master]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [occupations_admin]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [occupations_admin]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [occupations_admin]
GO

/*covid_user*/

USE [master]
GO
-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN occupations_admin   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [master]
GO
CREATE USER [occupations_admin] FOR LOGIN [occupations_admin]
    WITH DEFAULT_SCHEMA = [master];  

USE [master]
GO
GRANT INSERT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT SELECT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT UPDATE ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT DELETE ON SCHEMA :: [dbo] TO [occupations_admin];
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
WHERE login_name = 'occupations_admin'

-- Kill Active Users
kill 66;

-- Drop LOGIN
DROP LOGIN [occupations_admin]
GO

USE [master]
Go

DROP USER [occupations_admin]
GO

-- Drop covid_user
use [master] 
go

DROP LOGIN [occupations_admin]
GO

USE [master]
Go

DROP USER [occupations_admin]
GO