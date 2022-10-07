# 我的N9E项目测试
自己学习并搭建的N9E测试项目

整个集群架构包括

![结构图](/resource/%E7%BB%84%E4%BB%B6%E7%BB%93%E6%9E%84%E5%9B%BE.png)

# 快速开始
```shell
git clone https://github.com/XiaoChouYou/MyN9e.git
cd MyN9e/docker
. ./init_env.sh
docker-compose up -d
```

# init_env.sh 
配置各个容器的一些常规变量
# build_cmd 
配置了容器初始化的一些脚本
# image_diy
因为官方提供的容器中进程启动用户大多是程序账号或者root账号.
在目录持久化之后物理机的用户与容器内用户不一直,管理不太方便.
所以自行修改了容器内应用归属的用户ID
目前容器的内应用的权限使用的是uid 1000 gid 1000
如有需要可自行修改相关的DockerFile构造适用个人的镜像


##  举例
数据库 使用的postgres的扩展时序数据库 timescale 
因为容器内的目录挂载到本地后用户权限不一致. 持久化目录配置文件改动不方便. 
增加修改目录用户ID与组ID,尽量保证与容器外用户一致 
```dockerfile
FROM timescaledev/promscale-extension:0.6.0-ts2.7.2-pg14
ARG PROC_GID=1000
ARG PROC_UID=1000

COPY 0021_crearte_db.sql /docker-entrypoint-initdb.d/
COPY 0022_init_n9e.sql /docker-entrypoint-initdb.d/

RUN (sed -i 's/postgres:x:70:postgres/postgres:x:'${PROC_GID}':postgres/g'  /etc/group )
RUN (sed -i 's/70:70/'${PROC_UID}':'${PROC_GID}'/g'  /etc/passwd )
RUN (chown -R postgres:postgres /var/lib/postgresql )


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["postgres"]
```
## docker hub 登录
构造了自己的镜像之后可以上传到镜像仓库以便日后使用
```shell
docker login
docker push new-repo:tagname
```

* 特别说明
* n9e默认提供的是mysql的数据库.可以集成到一个postgres库中.但是要修改大量的表结构与初始化语句.如果需要可以自行修改
* nginx服务可以替换成kong 与 konga 做为网关.所以提前在pg库中创建了对应空库.后续可以自行取舍
* drawio存在的意义是结合grafana生成flowcharing.如果感兴趣可以自行学习[bilibili学习视频](https://www.bilibili.com/video/BV1wf4y1m7vm)

# 其他工具命令等
## 查看DockerFile
```shell
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage"
dfimage -sV=1.36 timescale/promscale
```

## nginx 鉴权密码
```shell
docker run --rm -ti xmartlabs/htpasswd userapp 123456
```

