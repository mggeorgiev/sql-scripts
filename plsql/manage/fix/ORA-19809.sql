sqlplus / as sysdba

show parameter db_recovery;

-- ncrease the value of  db_recovery_file_dest_size parameter.

show parameter db_recovery_file_dest_size;

-- increase the size of the db_recovery_file_dest_size parameter to a value greater than the value that u got from show parameter.

alter system set db_recovery_file_dest_size=10g;-- assume that we had a value of 8g