sed -i 's/N9E_USER_NAME/'${N9E_USER_NAME}'/g'  /docker-entrypoint-initdb.d/0022_init_n9e.sql
sed -i 's/N9E_DB_NAME/'${N9E_DB_NAME}'/g'  /docker-entrypoint-initdb.d/0022_init_n9e.sql
sed -i 's/N9E_DB_PASSWD/'${N9E_DB_PASSWD}'/g'  /docker-entrypoint-initdb.d/0022_init_n9e.sql