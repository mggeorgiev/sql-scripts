#!/bin/bash

container=sql2017

docker exec -it $container /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $(cat /home/georgiem/userpass.txt) -Q "EXECUTE [dbo].[sp_powerbi_log];"