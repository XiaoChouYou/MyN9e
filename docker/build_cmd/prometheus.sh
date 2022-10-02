

docker run -it --rm  --name prometheus-demo  -d prom/prometheus:v2.33.4


if [  ! -d ${PROJECTHOME}/prometheus ]
then
  mkdir -p ${PROJECTHOME}/prometheus
fi
docker cp prometheus-demo:/prometheus/        ${PROJECTHOME}/prometheus/data/
docker cp prometheus-demo:/etc/prometheus/    ${PROJECTHOME}/prometheus/etc/

chmod -R 777  ${PROJECTHOME}/prometheus/data ${PROJECTHOME}/prometheus/etc
docker stop prometheus-demo
