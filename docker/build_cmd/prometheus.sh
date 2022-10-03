

docker run -it --rm  --name prometheus-demo  -d prom/prometheus:v2.33.4


if [  ! -d ${PROJECTHOME}/prometheus ]
then
  mkdir -p ${PROJECTHOME}/prometheus
fi
if [  ! -d ${PROJECTHOME}/prometheus/data/ ]
then
  docker cp prometheus-demo:/prometheus/        ${PROJECTHOME}/prometheus/data/
fi

if [  ! -d ${PROJECTHOME}/prometheus/etc/ ]
then
  docker cp prometheus-demo:/etc/prometheus/    ${PROJECTHOME}/prometheus/etc/
fi

chmod -R 777  ${PROJECTHOME}/prometheus/data ${PROJECTHOME}/prometheus/etc
docker stop prometheus-demo


cat  >  "${PROJECTHOME}"/prometheus/etc/prometheus.yml <<EOF

# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      # 监听本地采集器
      - targets: ["localhost:9090"]

  # 监听n9e
  - job_name: 'n9e'
    file_sd_configs:
    - files:
      - targets.json

remote_write:
   - url: "http://promscale:9201/write"
     write_relabel_configs:
     - source_labels: [__name__]
       regex: '.*:.*'
       action: drop
     remote_timeout: 100s
     queue_config:
       capacity: 500000
       max_samples_per_send: 50000
       batch_send_deadline: 30s
       min_backoff: 100ms
       max_backoff: 10s
       min_shards: 16
       max_shards: 16
remote_read:
  - url: "http://promscale:9201/read"
    read_recent: true

EOF

cat  >  "${PROJECTHOME}"/prometheus/etc/targets.json <<EOF
[
  {
    "targets": [
      "nwebapi:18000","nserver:19000"
    ]
  }
]
EOF