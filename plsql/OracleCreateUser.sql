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

/*CREATE USER collector*/
DROP USER collector;