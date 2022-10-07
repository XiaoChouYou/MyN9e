
echo "init .. grafana9 .. "
docker run -it --rm  --name grafana9-demo  -d xiaochouyou/grafana:9.1.7


if [  ! -d ${PROJECTHOME}/grafana9 ]
then
  mkdir -p ${PROJECTHOME}/grafana9
fi
if [  ! -d ${PROJECTHOME}/grafana9/etc/ ]
then
  docker cp grafana9-demo:/etc/grafana/        ${PROJECTHOME}/grafana9/etc/
fi

if [  ! -d ${PROJECTHOME}/grafana9/lib/ ]
then
  docker cp grafana9-demo:/var/lib/grafana/        ${PROJECTHOME}/grafana9/lib/
fi

docker stop grafana9-demo


echo "init .. grafana8 .. "
docker run -it --rm  --name grafana8-demo  -d xiaochouyou/grafana:8.5.13


if [  ! -d ${PROJECTHOME}/grafana8 ]
then
  mkdir -p ${PROJECTHOME}/grafana8
fi
if [  ! -d ${PROJECTHOME}/grafana8/etc/ ]
then
  docker cp grafana8-demo:/etc/grafana/        ${PROJECTHOME}/grafana8/etc/
fi

if [  ! -d ${PROJECTHOME}/grafana8/lib/ ]
then
  docker cp grafana8-demo:/var/lib/grafana/        ${PROJECTHOME}/grafana8/lib/
fi

docker stop grafana8-demo
