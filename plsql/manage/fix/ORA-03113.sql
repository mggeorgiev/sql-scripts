sqlplus / as sysdba
startup nomount
alter database mount;
--Clear an unarchived redo logs
alter database clear unarchived logfile group 1;
alter database clear unarchived logfile group 2;
alter database clear unarchived logfile group 3;