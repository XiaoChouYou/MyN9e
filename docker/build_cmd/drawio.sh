
echo "init .. drawio .. "
docker run -it --rm  --name drawio-demo  -d jgraph/drawio:20.4.0


if [  ! -d ${PROJECTHOME}/drawio/ ]
then
  mkdir -p ${PROJECTHOME}/drawio/
fi
if [  ! -d ${PROJECTHOME}/drawio/conf/ ]
then
  docker cp drawio-demo:/usr/local/tomcat/conf/        ${PROJECTHOME}/drawio/conf/
fi

if [  ! -d ${PROJECTHOME}/drawio/webapps/ ]
then
  docker cp drawio-demo:/usr/local/tomcat/webapps/        ${PROJECTHOME}/drawio/webapps/
fi

chmod -R 777  ${PROJECTHOME}/drawio/
docker stop drawio-demo

