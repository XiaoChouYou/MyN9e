# 创建mysql服务相关配置文件
echo "init .. mysql .. "


if [  ! -d ${PROJECTHOME}/mysql/data ]
then
  mkdir -p ${PROJECTHOME}/mysql/data
fi

if [  ! -d ${PROJECTHOME}/mysql/initsql ]
then
  mkdir -p ${PROJECTHOME}/mysql/initsql
fi


docker run -it --rm  --name mysql-demo  -d xiaochouyou/mysql:5.7
if [  ! -d ${PROJECTHOME}/mysql/etc/ ]
then
  docker cp prometheus-demo:/etc/mysql        ${PROJECTHOME}/mysql/etc
fi
chmod -R 777  ${PROJECTHOME}/mysql/etc/
docker stop mysql-demo


cp ${WORKHOME}/build_cmd/initsql_for_mysql/*sql ${PROJECTHOME}/mysql/initsql
