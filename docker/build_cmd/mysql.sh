# 创建N9E服务相关配置文件
echo "init .. mysql .. "

if [  ! -d ${PROJECTHOME}/mysql/etc ]
then
  mkdir -p ${PROJECTHOME}/mysql/etc
fi

if [  ! -d ${PROJECTHOME}/mysql/data ]
then
  mkdir -p ${PROJECTHOME}/mysql/data
fi

if [  ! -d ${PROJECTHOME}/mysql/initsql ]
then
  mkdir -p ${PROJECTHOME}/mysql/initsql
fi


cp ${WORKHOME}/build_cmd/*sql ${PROJECTHOME}/mysql/initsql
