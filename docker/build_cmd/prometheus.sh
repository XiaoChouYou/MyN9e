

docker run -it --rm  --name prometheus-demo  -d prom/prometheus:v2.33.4


if [  ! -d ${PROJECTHOME}/prometheus ]
then
  mkdir -p ${PROJECTHOME}/prometheus
fi
if [  ! -d ${PROJECTHOME}/prometheus/data/ ]
then
  docker cp prometheus-demo:/prometheus/        ${PROJECTHOME}/prometheus/data/
fi

if [  ! -d ${PROJECTHOME}/prometheus/etc/ ]
then
  docker cp prometheus-demo:/etc/prometheus/    ${PROJECTHOME}/prometheus/etc/
fi

chmod -R 777  ${PROJECTHOME}/prometheus/data ${PROJECTHOME}/prometheus/etc
docker stop prometheus-demo
