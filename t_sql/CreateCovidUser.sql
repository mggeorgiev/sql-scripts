USE [covid19]
GO

-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN covid_admin   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [covid19]
GO
CREATE USER [covid_admin] FOR LOGIN [covid_admin];

USE [covid19]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [covid_admin]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [covid_admin]
GO
-- ALTER SERVER ROLE [sysadmin] ADD MEMBER [covid_admin]
-- GO

/*covid_user*/

USE [covid19]
GO
-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN covid_user   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
USE [covid19]
GO
CREATE USER [covid_user] FOR LOGIN [covid_user]
    WITH DEFAULT_SCHEMA = [covid19];  

USE [covid19]
GO
GRANT INSERT ON SCHEMA :: [dbo] TO [covid_user];
GO
GRANT SELECT ON SCHEMA :: [dbo] TO [covid_user];
GO
GRANT UPDATE ON SCHEMA :: [dbo] TO [covid_user];
GO
GRANT DELETE ON SCHEMA :: [dbo] TO [covid_user];
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
WHERE login_name = 'covid_admin'

-- Kill Active Users
kill 66;

-- Drop LOGIN
DROP LOGIN [covid_admin]
GO

USE [covid19]
Go

DROP USER [covid_admin]
GO

-- Drop covid_user
use master 
go

DROP LOGIN [covid_user]
GO

USE [covid19]
Go

DROP USER [covid_user]
GO