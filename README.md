# 我的N9E项目测试
自己学习并搭建的N9E测试项目

# 查看DockerFile
```shell
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage"
dfimage -sV=1.36 timescale/promscale
```