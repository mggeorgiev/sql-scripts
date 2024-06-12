set oracle_sid=DATABASE NAME
sqlplus /nolog
conn sys/sys as sysdba
shutdown abort
startup

--listener start