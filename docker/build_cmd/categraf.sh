


# 创建N9E服务相关配置文件
echo "init .. categraf  .. "

if [  ! -d ${PROJECTHOME}/categraf/conf/ ]
then
  mkdir -p ${PROJECTHOME}/categraf/conf/
fi

cp -r ${WORKHOME}/build_cmd/categraf_conf/*   ${PROJECTHOME}/categraf/conf/
chmod -R 777  ${PROJECTHOME}/categraf/conf/

cat  >  "${PROJECTHOME}"/categraf/conf/config.toml  <<EOF

[global]
# whether print configs
print_configs = false

# add label(agent_hostname) to series
# "" -> auto detect hostname
# "xx" -> use specified string xx
# "$hostname" -> auto detect hostname
# "$ip" -> auto detect ip
# "$hostname-$ip" -> auto detect hostname and ip to replace the vars
hostname = "\$HOSTNAME"

# will not add label(agent_hostname) if true
omit_hostname = false

# s | ms
precision = "ms"

# global collect interval
interval = 15

[global.labels]
source="categraf"
# region = "shanghai"
# env = "localhost"

[writer_opt]
# default: 2000
batch = 2000
# channel(as queue) size
chan_size = 10000

[[writers]]
url = "http://nserver:${N9E_SERV_HTTP_PORT}/prometheus/v1/write"

# Basic auth username
basic_auth_user = ""

# Basic auth password
basic_auth_pass = ""

# timeout settings, unit: ms
timeout = 5000
dial_timeout = 2500
max_idle_conns_per_host = 100

[http]
enable = false
address = ":9100"
print_access = false
run_mode = "release"


EOF
