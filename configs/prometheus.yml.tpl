global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - {{HOST_IP}}:9093

rule_files:
  - "/etc/prometheus/prometheus_rules.yml"

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'vmware_vcenter'
    metrics_path: '/metrics'
    scrape_timeout: 15s
    static_configs:
      - targets:
        - '{{HOST_IP}}:9272'

  - job_name: 'grafana'
    metrics_path: '/metrics'
    scrape_timeout: 15s
    static_configs:
      - targets:
        - '{{HOST_IP}}:3000'
        
  - job_name: 'alertmanager'
    metrics_path: '/metrics'
    scrape_timeout: 15s
    static_configs:
      - targets:
        - '{{HOST_IP}}:9093'

