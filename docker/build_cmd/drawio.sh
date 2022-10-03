
echo "init .. drawio .. "
docker run -it --rm  --name drawio-demo  -d jgraph/drawio:20.4.0


if [  ! -d ${PROJECTHOME}/drawio ]
then
  mkdir -p ${PROJECTHOME}/drawio
fi
if [  ! -d ${PROJECTHOME}/drawio/tomcat/ ]
then
  docker cp drawio-demo:/usr/local/tomcat/        ${PROJECTHOME}/drawio/tomcat/
fi

chmod -R 777  ${PROJECTHOME}/drawio/tomcat/
docker stop drawio-demo

