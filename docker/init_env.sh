

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
#

# DNS配置文件初始化
sh -x "${WORKHOME}"/build_cmd/dns.sh


