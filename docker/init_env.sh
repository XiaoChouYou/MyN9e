

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
export DNSSERVICE=172.0.0.250
export DNSUSER=admin
export DNSPASSWD=123123
sh  "${WORKHOME}"/build_cmd/dns.sh

# POSTGRES数据库
export POSTGRESPASSWD=123123
export PROC_GID=1000
export PROC_UID=1000
sh  "${WORKHOME}"/build_cmd/timescaledb.sh


#NGINX配置
export NGINXSERVICE=172.0.0.100
export NGINXHTTPPORT=10080
export NGINXHTTPsPORT=10443
sh  "${WORKHOME}"/build_cmd/nginx.sh

