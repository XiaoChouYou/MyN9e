

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
export PROMSCALE_SERVICE=172.0.0.3
export PROMSCALE_DB_HOST=${POSTGRES_SERVICE}
export PROMSCALE_DB_PORT=5432
export PROMSCALE_DB_SSL_MODE=allow
export PROMSCALE_DB_NAME=${POSTGRES_DB}
export PROMSCALE_DB_PASSWORD=${POSTGRES_PASSWD}



#NGINX配置
export NGINX_SERVICE=172.0.0.100
export NGINX_HTTPPORT=10080
export NGINX_HTTPsPORT=10443
sh  "${WORKHOME}"/build_cmd/nginx.sh
