#!/bin/bash

value=$(cat userpass.txt)
container=sql2017

docker exec -it $container /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $value -Q "EXECUTE [dbo].[checkAllDatabases];"
docker exec -it $container /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $value -Q "EXECUTE [dbo].[sp_dbs_backup];"

docker exec -it $container bash -c "cp -u /var/opt/mssql/data/*.bak /mssql/"

bash ./mount_shared.sh

sudo cp -u /home/georgiem/mssql/*.bak /shared/mssql/