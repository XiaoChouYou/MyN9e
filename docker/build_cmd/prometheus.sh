

docker run -it --rm  --name prometheus-demo  -d prom/prometheus:v2.33.4
mkdir -p ${PROJECTHOME}/prometheus
docker cp prometheus-demo:/prometheus        ${PROJECTHOME}/prometheus/data
docker cp prometheus-demo:/etc/prometheus    ${PROJECTHOME}/prometheus/etc
chmod -R 777  ${PROJECTHOME}/prometheus/data ${PROJECTHOME}/prometheus/etc
docker stop prometheus-demo
