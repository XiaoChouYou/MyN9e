# 创建N9E服务相关配置文件
echo "init .. n9e server .. "
docker run -it --rm  --name nserver-demo  -d flashcatcloud/nightingale:5.12.1

if [  ! -d ${PROJECTHOME}/n9e ]
then
  mkdir -p ${PROJECTHOME}/n9e
fi

if [  ! -d ${PROJECTHOME}/n9e/etc/ ]
then
  docker cp nserver-demo:/app/etc/        ${PROJECTHOME}/n9e/etc/
fi

chmod -R 777  ${PROJECTHOME}/n9e/etc/
docker stop nserver-demo


cat  >  "${PROJECTHOME}"/n9e/etc/server.conf  <<EOF
# debug, release
RunMode = "release"

# my cluster name
ClusterName = "Default"

# Default busigroup Key name
# do not change
BusiGroupLabelKey = "busigroup"

# sleep x seconds, then start judge engine
EngineDelay = 60

DisableUsageReport = false

# config | database
ReaderFrom = "config"

ForceUseServerTS = true

[Log]
# log write dir
Dir = "logs"
# log level: DEBUG INFO WARNING ERROR
Level = "INFO"
# stdout, stderr, file
Output = "stdout"
# # rotate by time
# KeepHours: 4
# # rotate by size
# RotateNum = 3
# # unit: MB
# RotateSize = 256

[HTTP]
# http listening address
Host = "0.0.0.0"
# http listening port
Port = ${N9E_HTTP_PORT}
# https cert file path
CertFile = ""
# https key file path
KeyFile = ""
# whether print access log
PrintAccessLog = false
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

# [BasicAuth]
# user002 = "ccc26da7b9aba533cbb263a36c07dcc9"

[Heartbeat]
# auto detect if blank
IP = ""
# unit ms
Interval = 1000

[SMTP]
Host = "smtp.163.com"
Port = 994
User = "username"
Pass = "password"
From = "username@163.com"
InsecureSkipVerify = true
Batch = 5

[Alerting]
TemplatesDir = "./etc/template"
NotifyConcurrency = 10
# use builtin go code notify
NotifyBuiltinChannels = ["email", "dingtalk", "wecom", "feishu", "mm"]

[Alerting.CallScript]
# built in sending capability in go code
# so, no need enable script sender
Enable = false
ScriptPath = "./etc/script/notify.py"

[Alerting.CallPlugin]
Enable = false
# use a plugin via `go build -buildmode=plugin -o notify.so`
PluginPath = "./etc/script/notify.so"
# The first letter must be capitalized to be exported
Caller = "N9eCaller"

[Alerting.RedisPub]
Enable = false
# complete redis key: ${ChannelPrefix} + ${Cluster}
ChannelPrefix = "/alerts/"

[Alerting.Webhook]
Enable = false
Url = "http://a.com/n9e/callback"
BasicAuthUser = ""
BasicAuthPass = ""
Timeout = "5s"
Headers = ["Content-Type", "application/json", "X-From", "N9E"]

[NoData]
Metric = "target_up"
# unit: second
Interval = 120

[Ibex]
# callback: ${ibex}/${tplid}/${host}
Address = "${N9E_IBEX_HOST}:${N9E_IBEX_PORT}"
# basic auth
BasicAuthUser = "${N9E_IBEX_BASICAUTHUSER}"
BasicAuthPass = "${N9E_IBEX_BASICAUTHPASS}"
# unit: ms
Timeout = 3000

[Redis]
# address, ip:port
Address = "${N9E_REDIS_SERVICE}:${N9E_REDIS_PORT}"
# requirepass
Password = "${REDIS_PASSWORD}"
# # db
# DB = 0

[DB]
# postgres: host=%s port=%s user=%s dbname=%s password=%s sslmode=%s
# DSN="root:1234@tcp(mysql:3306)/n9e_v5?charset=utf8mb4&parseTime=True&loc=Local&allowNativePasswords=true"
postgres: host=${N9E_PGDB_HOST} port=${N9E_PGDB_PORT} user=${N9E_PGDB_USER} dbname=${N9E_PGDB_NAME} password=${N9E_PGDB_PASSWORD} sslmode=${N9E_PGDB_SSL_MODE}
# enable debug mode or not
Debug = false
# mysql postgres
DBType = "${N9E_DB_TYPE}"
# unit: s
MaxLifetime = 7200
# max open connections
MaxOpenConns = 150
# max idle connections
MaxIdleConns = 50
# table prefix
TablePrefix = ""
# enable auto migrate or not
# EnableAutoMigrate = false

[Reader]
# prometheus base url
Url = "http://prometheus:9090"
# Basic auth username
BasicAuthUser = ""
# Basic auth password
BasicAuthPass = ""
# timeout settings, unit: ms
Timeout = 30000
DialTimeout = 3000
MaxIdleConnsPerHost = 100

[WriterOpt]
# queue channel count
QueueCount = 100
# queue max size
QueueMaxSize = 200000
# once pop samples number from queue
QueuePopSize = 2000

[[Writers]]
Url = "http://prometheus:9090/api/v1/write"
# Basic auth username
BasicAuthUser = ""
# Basic auth password
BasicAuthPass = ""
# timeout settings, unit: ms
Timeout = 10000
DialTimeout = 3000
TLSHandshakeTimeout = 30000
ExpectContinueTimeout = 1000
IdleConnTimeout = 90000
# time duration, unit: ms
KeepAlive = 30000
MaxConnsPerHost = 0
MaxIdleConns = 100
MaxIdleConnsPerHost = 100
# [[Writers.WriteRelabels]]
# Action = "replace"
# SourceLabels = ["__address__"]
# Regex = "([^:]+)(?::\\d+)?"
# Replacement = "$1:80"
# TargetLabel = "__address__"

# [[Writers]]
# Url = "http://m3db:7201/api/v1/prom/remote/write"
# # Basic auth username
# BasicAuthUser = ""
# # Basic auth password
# BasicAuthPass = ""
# # timeout settings, unit: ms
# Timeout = 30000
# DialTimeout = 10000
# TLSHandshakeTimeout = 30000
# ExpectContinueTimeout = 1000
# IdleConnTimeout = 90000
# # time duration, unit: ms
# KeepAlive = 30000
# MaxConnsPerHost = 0
# MaxIdleConns = 100
# MaxIdleConnsPerHost = 100


EOF