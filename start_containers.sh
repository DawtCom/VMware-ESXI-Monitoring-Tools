# sed replace {{HOST_IP}} with $HOST_IP in promteheus configuration
sed "s/{{HOST_IP}}/$HOST_IP/g" configs/prometheus.yml.tpl > configs/prometheus.yml
sed "s/{{SMTP_HELLO}}/$SMTP_HELLO/g; s/{{SMTP_TO}}/$SMTP_TO/g; s/{{SMTP_FROM}}/$SMTP_FROM/g; s/{{SMTP_SMARTHOST}}/$SMTP_SMARTHOST/g; s/{{SMTP_USER}}/$SMTP_USER/g; s/{{SMTP_PASS}}/$SMTP_PASS/g;" configs/alertmanager.yml.tpl > configs/alertmanager.yml
sed "s/{{ESXI_HOSTNAME}}/$ESXI_HOSTNAME/g" configs/prometheus_rules.yml.tpl > configs/prometheus_rules.yml

VSPHERE_HOST=$VSPHERE_HOST VSPHERE_USER=$VSPHERE_USER VSPHERE_PASS=$VSPHERE_PASS docker-compose up
