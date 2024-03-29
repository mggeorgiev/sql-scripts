-- DROP USER GEORGIEM_DBA;

/*CREATE DBA*/
CREATE USER GEORGIEM_DBA IDENTIFIED BY MyPassword;

/*The Grant Statement*/
GRANT CONNECT, RESOURCE, DBA TO GEORGIEM_DBA;
GRANT CREATE SESSION TO GEORGIEM_DBA WITH ADMIN OPTION;
GRANT GRANT ANY OBJECT privilege to GEORGIEM_DBA;
GRANT UNLIMITED TABLESPACE TO GEORGIEM_DBA;

/*CREATE USER collector*/
DROP USER collector;

/*Creating a User*/
CREATE USER collector IDENTIFIED BY MyPassword;

/*The Grant Statement*/
/*GRANT CONNECT, RESOURCE, DBA TO collector;*/
GRANT CONNECT TO collector;

/*The Grant Statement*/
/*GRANT CONNECT, RESOURCE, DBA TO collector;*/
/*GRANT CREATE SESSION GRANT ANY PRIVILEGE TO collector;*/
GRANT CREATE SESSION TO collector;
GRANT UNLIMITED TABLESPACE TO collector;
/*GRANT SELECT, INSERT, UPDATE, DELETE ON schema.books TO collector;*/
GRANT SELECT ON finance.CNS_FACTURE TO collector;
GRANT SELECT ON finance.CNS_PAYMENT TO collector;
GRANT SELECT ON finance.DKV_PAYMENT TO collector;