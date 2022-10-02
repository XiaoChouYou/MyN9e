# 我的N9E项目测试
自己学习并搭建的N9E测试项目

# 查看DockerFile
```shell
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage"
dfimage -sV=1.36 timescale/promscale
```

# 数据库 使用的postgres的扩展时序数据库 
因为容器内的目录挂载到本地后用户权限不一致. 持久化目录配置文件改动不方便. 
增加修改目录用户ID与组ID,尽量保证与容器外用户一致 
```dockerfile
FROM timescaledev/promscale-extension:0.6.0-ts2.7.2-pg14
ENV PROC_GID=5000
ENV PROC_UID=5000
RUN (sed -i 's/postgres:x:70:postgres/postgres:x:'${PROC_GID}':postgres/g'  /etc/group )
RUN (sed -i 's/70:70/'${PROC_UID}':'${PROC_GID}'/g'  /etc/passwd )
RUN (chown -R postgres:postgres /var/lib/postgresql )

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["postgres"]
```

# docker hub 登录
```shell
docker login
docker push new-repo:tagname

```

# 提前下载镜像,并提前准备一些docker本地持久化配置文件
```shell
. ./init_env.sh

```