groups:
  - name: custom_rules
    rules:
# These are the queries for your data store free percent change the ds_name as per your virtual host datastore setup
      - record: vmware_datastore1_free_percent
        expr: (100 * vmware_datastore_freespace_size{ds_name=~"datastore1"} / vmware_datastore_capacity_size{ds_name=~"datastore1"})
# Modify the domain below to be the FQDN of your esxi host
      - record: vmware_cpu_usage
        expr: avg((vmware_host_cpu_usage{host_name=~"{{ESXI_HOSTNAME}}"}) * 100 / (vmware_host_cpu_max{host_name=~"{{ESXI_HOSTNAME}}"}))
      - record: vmware_memory_usage
        expr: avg((vmware_host_memory_usage * 100) / (vmware_host_memory_max))
  - name: alert_rules
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Instance [{{ $labels.instance }}] down"
          description: "[{{ $labels.instance }}] of job [{{ $labels.job }}] has been down for more than 1 minute."
      - alert: vmware_datastore1_free
        expr: vmware_datastore1_free_percent <= 20
        labels:
          severity: warning
        annotations:
          summary: "Instance [{{ $labels.ds_name }}] has 20% or less Free disk space"
          description: "[{{ $labels.ds_name }}] has only {{ $value }}% or less free."
      - alert: vmware_cpu_usage
        expr: vmware_cpu_usage > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "VMWare host esxi is showing > 80% of CPU usage"
          description: "VMWare host esxi is using {{ $value }}% CPU."
      - alert: vmware_host_memory_usage
        expr: vmware_memory_usage > 85
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "VMWare host esxi is showing > 85% memory usage"
          description: "VMWare host esxi is using {{ $value }}% of total memory."