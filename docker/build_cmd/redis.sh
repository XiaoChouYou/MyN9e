
# 创建redis服务相关配置文件
mkdir -p "${PROJECTHOME}"/redis/data
if [ -f "${PROJECTHOME}"/redis/data/redis.conf ]
then
   rm  "${PROJECTHOME}"/redis/data/redis.conf
fi


echo "init .. redis .. "

cat  >  "${PROJECTHOME}"/redis/data/redis.conf   <<EOF
bind 0.0.0.0
protected-mode no
port ${REDIS_PORT}
timeout 0
save 900 1 # 900s内至少一次写操作则执行bgsave进行RDB持久化
save 300 10
save 60 10000
rdbcompression yes
dbfilename dump.rdb
dir /data
appendonly yes
appendfsync everysec
requirepass ${REDIS_PASSWORD}

EOF