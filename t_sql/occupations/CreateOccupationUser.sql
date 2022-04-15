/*Drop LOGIN*/
USE [occupations]
Go

DROP LOGIN [occupations_admin]
GO

/*Drop User*/
USE [occupations]
Go
DROP USER [occupations_admin]
GO

USE [occupations]
GO
/* Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  */
CREATE LOGIN [occupations_admin]
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

/* Creates a database user for the login created above.  */
USE [occupations]
GO
CREATE USER [occupations_admin] FOR LOGIN [occupations_admin]
GO
USE [occupations]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [occupations_admin]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [occupations_admin]
GO
-- ALTER SERVER ROLE [sysadmin] ADD MEMBER [ec_admin]
-- GO

USE [occupations]
GO
GRANT INSERT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT SELECT ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT UPDATE ON SCHEMA :: [dbo] TO [occupations_admin];
GO
GRANT DELETE ON SCHEMA :: [dbo] TO [occupations_admin];
GO