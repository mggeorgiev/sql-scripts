select * from dba_profiles
ORDER BY profile;

/*The value in PASSWORD_LIFE_TIME has changed to 'Unlimited' so the password will never expire.*/
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
/*The value in PASSWORD_LIFE_TIME has changed to 'Unlimited' so the password will never expire.*/

/*Now reset the password of the locked user using the following command. [user_name] and [password]*/
alter user ORDS_PUBLIC_USER identified by [password];
/*Unlock user account using following command*/
alter user ORDS_PUBLIC_USER account unlock;
/* Cross check by the value of accout_status field in dba_users view.*/
select username,account_status from dba_users;
/*The value of account_status filed should by "OPEN" for the corresponding user.*/