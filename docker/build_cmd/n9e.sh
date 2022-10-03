# 创建N9E服务相关配置文件
echo "init .. n9e server .. "

if [  ! -d ${PROJECTHOME}/n9e/etc/ ]
then
  mkdir -p ${PROJECTHOME}/n9e/etc/
fi

cp -r ${WORKHOME}/build_cmd/n9e_etc/*   ${PROJECTHOME}/n9e/etc/
chmod -R 777  ${PROJECTHOME}/n9e/etc/

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
Port = ${N9E_SERV_HTTP_PORT}
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
# use a plugin via \`go build -buildmode=plugin -o notify.so\`
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
Password = "${N9E_REDIS_PASSWORD}"
# # db
# DB = 0

[DB]
# postgres: host=%s port=%s user=%s dbname=%s password=%s sslmode=%s
DSN="${N9E_MYSQL_USER}:${N9E_MYSQL_PASSWORD}@tcp(${N9E_MYSQL_HOST}:${N9E_MYSQL_PORT})/${N9E_MYSQL_NAME}?charset=utf8mb4&parseTime=True&loc=Local&allowNativePasswords=true"
# enable true debug mode or not false
Debug = false
# mysql postgres
DBType = "${N9E_DBType}"
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







cat  >  "${PROJECTHOME}"/n9e/etc/webapi.conf  <<EOF

# debug, release
RunMode = "release"

# # custom i18n dict config
# I18N = "./etc/i18n.json"

# # custom i18n request header key
# I18NHeaderKey = "X-Language"

# metrics descriptions
MetricsYamlFile = "./etc/metrics.yaml"

BuiltinAlertsDir = "./etc/alerts"
BuiltinDashboardsDir = "./etc/dashboards"

# config | api
ClustersFrom = "config"

# using when ClustersFrom = "api"
ClustersFromAPIs = []

[[NotifyChannels]]
Label = "邮箱"
# do not change Key
Key = "email"

[[NotifyChannels]]
Label = "钉钉机器人"
# do not change Key
Key = "dingtalk"

[[NotifyChannels]]
Label = "企微机器人"
# do not change Key
Key = "wecom"

[[NotifyChannels]]
Label = "飞书机器人"
# do not change Key
Key = "feishu"

[[NotifyChannels]]
Label = "mm bot"
# do not change Key
Key = "mm"

[[ContactKeys]]
Label = "Wecom Robot Token"
# do not change Key
Key = "wecom_robot_token"

[[ContactKeys]]
Label = "Dingtalk Robot Token"
# do not change Key
Key = "dingtalk_robot_token"

[[ContactKeys]]
Label = "Feishu Robot Token"
# do not change Key
Key = "feishu_robot_token"

[[ContactKeys]]
Label = "MatterMost Webhook URL"
# do not change Key
Key = "mm_webhook_url"

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
Port = ${N9E_WEB_HTTP_PORT}
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

[JWTAuth]
# signing key
SigningKey = "5b94a0fd640fe2765af826acfe42d152"
# unit: min
AccessExpired = 1500
# unit: min
RefreshExpired = 10080
RedisKeyPrefix = "/jwt/"

[ProxyAuth]
# if proxy auth enabled, jwt auth is disabled
Enable = false
# username key in http proxy header
HeaderUserNameKey = "X-User-Name"
DefaultRoles = ["Standard"]

[BasicAuth]
user001 = "ccc26da7b9aba533cbb263a36c07dcc4"

[AnonymousAccess]
PromQuerier = false
AlertDetail = false

[LDAP]
Enable = false
Host = "ldap.example.org"
Port = 389
BaseDn = "dc=example,dc=org"
# AD: manange@example.org
BindUser = "cn=manager,dc=example,dc=org"
BindPass = "*******"
# openldap format e.g. (&(uid=%s))
# AD format e.g. (&(sAMAccountName=%s))
AuthFilter = "(&(uid=%s))"
CoverAttributes = true
TLS = false
StartTLS = true
# ldap user default roles
DefaultRoles = ["Standard"]

[LDAP.Attributes]
Nickname = "cn"
Phone = "mobile"
Email = "mail"

[OIDC]
Enable = false
RedirectURL = "http://n9e.com/callback"
SsoAddr = "http://sso.example.org"
ClientId = ""
ClientSecret = ""
CoverAttributes = true
DefaultRoles = ["Standard"]

[OIDC.Attributes]
Nickname = "nickname"
Phone = "phone_number"
Email = "email"

[Redis]
# address, ip:port
Address = "${N9E_REDIS_SERVICE}:${N9E_REDIS_PORT}"
# requirepass
Password = "${N9E_REDIS_PASSWORD}"
# # db
# DB = 0

[DB]
# postgres: host=%s port=%s user=%s dbname=%s password=%s sslmode=%s
DSN="${N9E_MYSQL_USER}:${N9E_MYSQL_PASSWORD}@tcp(${N9E_MYSQL_HOST}:${N9E_MYSQL_PORT})/${N9E_MYSQL_NAME}?charset=utf8mb4&parseTime=True&loc=Local&allowNativePasswords=true"
Debug = true
# mysql postgres
DBType = "mysql"
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

[[Clusters]]
# Prometheus cluster name
Name = "NgBilling"
# Prometheus APIs base url
Prom = "http://prometheus:9090"
# Basic auth username
BasicAuthUser = ""
# Basic auth password
BasicAuthPass = ""
# timeout settings, unit: ms
Timeout = 30000
DialTimeout = 3000
MaxIdleConnsPerHost = 100

[Ibex]
Address = "${N9E_IBEX_HOST}:${N9E_IBEX_PORT}"
# basic auth
BasicAuthUser = "${N9E_IBEX_BASICAUTHUSER}"
BasicAuthPass = "${N9E_IBEX_BASICAUTHPASS}"
# unit: ms
Timeout = 3000

[TargetMetrics]
TargetUp = '''max(max_over_time(target_up{ident=~"(%s)"}[%dm])) by (ident)'''
LoadPerCore = '''max(max_over_time(system_load_norm_1{ident=~"(%s)"}[%dm])) by (ident)'''
MemUtil = '''100-max(max_over_time(mem_available_percent{ident=~"(%s)"}[%dm])) by (ident)'''
DiskUtil = '''max(max_over_time(disk_used_percent{ident=~"(%s)", path="/"}[%dm])) by (ident)'''


EOF