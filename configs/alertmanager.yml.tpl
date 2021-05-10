global:
  resolve_timeout: 5m
  smtp_hello: {{SMTP_HELLO}}
route:
  group_by: ['alertname']
  group_wait: 10s
# Check the alerts in this group every 10 seconds
  group_interval: 10s
# Only send a repeat of the same alert every 24 hours
  repeat_interval: 24h
  receiver: 'email'
receivers:
- name: 'email'
  email_configs:
  - to: '{{SMTP_TO}}'
    from: '{{SMTP_FROM}}'
    smarthost: {{SMTP_SMARTHOST}}
    auth_username: '{{SMTP_USER}}'
    auth_identity: '{{SMTP_USER}}'
    auth_password: '{{SMTP_PASS}}'
# Send resolved messages when an alert clears
    send_resolved: true