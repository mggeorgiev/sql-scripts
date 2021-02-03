-- CHECK USERS
-- SELECT User FROM mysql.user;
SELECT CONCAT(QUOTE(user),'@',QUOTE(host)) UserAccount FROM mysql.user;

-- SHWO FRANTS
select * from information_schema.user_privileges;

-- CREATE USERS
create user 'powerbi'@'%' identified by 'password';

CREATE USER IF NOT EXISTS
    user 'powerbi'@'%' IDENTIFIED by 'password';
    
 
 -- GRANT PRIVILEGES
 GRANT ALL PRIVILEGES ON *.* TO 'georgiem'@'%' WITH GRANT OPTION;
 GRANT SELECT PRIVILEGES ON * . * TO 'powerbi'@'%';   
 
 
 -- FLUSH PRIVILEGES
 FLUSH PRIVILEGES;
 
 -- Alter passwords
 
 ALTER USER 'powerbi' IDENTIFIED BY 'auth_string';
 ALTER USER 'python_ds' IDENTIFIED BY 'auth_string';
 ALTER USER 'splunk' IDENTIFIED BY 'auth_string';
