


echo "init .. nginx .. "
docker run -it --rm  --name nginx-demo  -d xiaochouyou/nginx:1.23.1-alpine


if [  ! -d ${PROJECTHOME}/nginx/ ]
then
  mkdir -p ${PROJECTHOME}/nginx/
fi
if [  ! -d ${PROJECTHOME}/nginx/etc/ ]
then
  docker cp nginx-demo:/etc/nginx/        ${PROJECTHOME}/nginx/etc/
fi


docker stop nginx-demo

