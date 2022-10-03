# 创建N9E服务相关配置文件
echo "init .. ibex server .. "
docker run -it --rm  --name ibex-demo  -d ulric2019/ibex:0.3

if [  ! -d ${PROJECTHOME}/ibex ]
then
  mkdir -p ${PROJECTHOME}/ibex
fi

if [  ! -d ${PROJECTHOME}/ibex/etc/ ]
then
  docker cp ibex-demo:/app/etc/        ${PROJECTHOME}/ibex/etc/
fi

chmod -R 777  ${PROJECTHOME}/n9e/etc/
docker stop ibex-demo


cat  >  "${PROJECTHOME}"/ibex/etc/server.conf  <<EOF
# debug, release
RunMode = "release"

[Log]
# log write dir
Dir = "logs-server"
# log level: DEBUG INFO WARNING ERROR
Level = "DEBUG"
# stdout, stderr, file
Output = "stdout"
# # rotate by time
# KeepHours: 4
# # rotate by size
# RotateNum = 3
# # unit: MB
# RotateSize = 256

[HTTP]
Enable = true
# http listening address
Host = "0.0.0.0"
# http listening port
Port = ${IBEX_PORT}
# https cert file path
CertFile = ""
# https key file path
KeyFile = ""
# whether print access log
PrintAccessLog = true
# whether enable pprof
PProf = false
# http graceful shutdown timeout, unit: s
ShutdownTimeout = 30
# max content length: 64M
MaxContentLength = 67108864
# http server read timeout, unit: s
ReadTimeout = 20
# http server write timeout, unit: s
WriteTimeout = 40
# http server idle timeout, unit: s
IdleTimeout = 120

[BasicAuth]
# using when call apis
${IBEX_BASICAUTHUSER} = "${IBEX_BASICAUTHPASS}"

[RPC]
Listen = "0.0.0.0:${IBEX_RPC_PORT}"

[Heartbeat]
# auto detect if blank
IP = ""
# unit: ms
Interval = 1000

[Output]
# database | remote
ComeFrom = "database"
AgtdPort = 2090

[Gorm]
# enable debug mode or not
Debug = false
# mysql postgres
DBType = "${IBEX_DBType}"
# unit: s
MaxLifetime = 7200
# max open connections
MaxOpenConns = 150
# max idle connections
MaxIdleConns = 50
# table prefix
TablePrefix = ""

[MySQL]
# mysql address host:port
Address = "mysql:3306"
# mysql username
User = "root"
# mysql password
Password = "1234"
# database name
DBName = "ibex"
# connection params
Parameters = "charset=utf8mb4&parseTime=True&loc=Local&allowNativePasswords=true"

[Postgres]
# pg address host:port
Address = "${IBEX_PGDB_HOST}:${IBEX_PGDB_PORT}"
# pg user
User = "${IBEX_PGDB_USER}"
# pg password
Password = "${IBEX_PGDB_PASSWORD}"
# database name
DBName = "${IBEX_PGDB_NAME}"
# ssl mode : disable allow
SSLMode = "${IBEX_PGDB_SSL_MODE}"


EOF
