

if  [ X"${WORKHOME}" = X ]
then
  WORKHOME=$(pwd)
  export WORKHOME
  PROJECTHOME=${WORKHOME}/project
  export PROJECTHOME
fi

# docker环境子网
export SUBNETWORK=172.0.0.0/24


# DNS服务器IP
export DNS_SERVICE=172.0.0.250
export DNS_USER=admin
export DNS_PASSWD=123123
sh  "${WORKHOME}"/build_cmd/dns.sh

# timescaledb数据库
export POSTGRES_SERVICE=172.0.0.2
export POSTGRES_PASSWD=123123
export POSTGRES_USER=postgres
export POSTGRES_DB=postgres
export PROC_GID=1000
export PROC_UID=1000
sh  "${WORKHOME}"/build_cmd/timescaledb.sh


# PROMSCALE 数据库
export PROMSCALE_SERVICE=172.0.0.2
export PROMSCALE_DB_HOST=${POSTGRES_SERVICE}
export PROMSCALE_DB_PORT=5432
export PROMSCALE_DB_SSL_MODE=allow
export PROMSCALE_DB_NAME=${POSTGRES_DB}
export PROMSCALE_DB_PASSWORD=${POSTGRES_PASSWD}


# prometheus 配置初始化
export PROMETHEUS_SERVICE=172.0.0.2
sh  "${WORKHOME}"/build_cmd/prometheus.sh


# redis 配置初始化
export REDIS_SERVICE=172.0.0.3
export REDIS_PORT=6379
export REDIS_PASSWORD=123456
sh  "${WORKHOME}"/build_cmd/redis.sh

# Ibex




# n9e server初始化
export N9E_IBEX_HOST=ibex
export N9E_IBEX_PORT=10090
export N9E_IBEX_BASICAUTHUSER=ibex
export N9E_IBEX_BASICAUTHPASS=ibex
export N9E_REDIS_SERVICE=redis
export N9E_REDIS_PORT=6379
export N9E_SERVICE=172.0.0.4
export N9E_HTTP_PORT=19000
export N9E_DBType=postgres
export N9E_PGDB_HOST=timescaledb
export N9E_PGDB_PORT=5432
export N9E_PGDB_USER=n9e
export N9E_PGDB_PASSWORD=123456
export N9E_PGDB_NAME=n9e
export N9E_PGDB_SSL_MODE=allow
sh  "${WORKHOME}"/build_cmd/n9e.sh




#NGINX配置
export NGINX_SERVICE=172.0.0.100
export NGINX_HTTPPORT=10080
export NGINX_HTTPsPORT=10443
sh  "${WORKHOME}"/build_cmd/nginx.sh


