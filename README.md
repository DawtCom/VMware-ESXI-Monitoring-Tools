
# ESXI Monitoring Tools - Kickstart

**Description:** This project is an example of how to quickly set up a monitoring environment for VMWare ESXi using Prometheus and Grafana for your metrics gathering, alerting, and visuals.   This project utilizes a simple docker-compose.yml to create 4 containers that compose of the entire environment.  To set it up quickly you must set or pass the required environment variables when running the start_containers.sh

Prometheus / Grafana / VMWare ESXi Metrics for Prometheus

**Containers deployed with this project**

 - Prometheus Service (Metrics gathering service)
 - Grafana Service (Visual Dashboard Tool)
 - Prometheus Alert Manager Service (Alerts delivery and management)
 - VMWare Exporter (Service gathering metrics from VMWare and exposing for Prometheus)


  
  ## Instructions to run
  
  First clone this repository onto a host that has docker installed on it.  This page does not go over docker installation and assumes you already know how or have it already set up on the target machine.  Installing docker can be found here: 
  
https://docs.docker.com/get-docker/

To start the container environment which will monitor your ESXI, Prometheus, Prometheus alerts manager and Grafana hosts run this simple command in the linux shell.  Replacing the values indicated by brackets below with your specific details.  Do not include brackets in replaced value.  This command line assumes you are using gmail as your email provider.

    SMTP_HELLO=[yourdomain.com] SMTP_TO=[first.last@gmail.com] SMTP_FROM=[prometheus@yourdomain.com] SMTP_SMARTHOST=smtp.gmail.com:587 SMTP_USER=[your_gmail_user@gmail.com] SMTP_PASS=[your_google_app_password] HOST_IP=[host_ip_running_docker_compose] ESXI_HOSTNAME=[esxi.yourdomain.com] VSPHERE_HOST=[esxi_host_ip_or_hostname] VSPHERE_USER=[vsphere_user] VSPHERE_PASS=[vsphere_pass] ./start_containers.sh

If you want to start the containers in daemon mode change the docker-compose up command in the start_containers.sh to include the -d option.  For example:

    VSPHERE_HOST=$VSPHERE_HOST VSPHERE_USER=$VSPHERE_USER VSPHERE_PASS=$VSPHERE_PASS docker-compose up -d

To kill or stop the containers you can issue the '*docker-compose down*' in the directory that the docker-compose.yml file resides. If you started the containers in non daemon mode which is the default simply press CTRL-C.


### Environment variables used in the start_containers.sh mentioned above:
|Environment Variable| Example| Notes |
|--|--|--|
| SMTP_HELLO |  yourdomain.com | This value is used in the HELO message to the email provider. Replaces token {{SMTP_HELLO}} in alertmanager.yml.tpl. |
| SMTP_TO | first.last@gmail.com | This is the email address you want the alerts sent to when they are triggered.  Replaces token {{SMTP_TO}} in alertmanager.yml.tpl |
| SMTP_FROM | prometheus@yourdomain.com | This is what the from line will be in the received email from the alerts manager. Replaces token {{SMTP_FROM}} in alertmanager.yml.tpl |
| SMTP_SMARTHOST | smtp.gmail.com:587 | This should be the server and port number that receives the SMTP email from the alerts manager.  Replaces token {{SMTP_SMARTHOST}} in alertmanager.yml.tpl |
| SMTP_USER | smtp.user@gmail.com | The user that will authenticate with the SMTP(email) server when sending an email from the alerts manager. Replaces token {{SMTP_USER}} in alertmanager.yml.tpl |
| SMTP_PASS | your_smtp_secret_password | The password to use when authenticating with the SMTP(email) server when sending an email from the alerts manager. Replaces token {{SMTP_PASS}} in alertmanager.yml.tpl |
| HOST_IP | 192.168.1.150 | This normally will be the host IP that you are running these docker containers on. Replaces token {{HOST_IP}} in prometheus.yml.tpl  |
| ESXI_HOSTNAME | esxi.yourdomain.com | The hostname or IP of the server hosting the esxi VSphere virtual machine OS. Replaces token {{ESXI_HOSTNAME}} in prometheus_rules.yml.tpl which defines a custom_rule for CPU usage on the esxi host.|
| VSPHERE_HOST | 192.168.1.100 or esxi.yourdomain.com | The hostname or ip that will be queried for VMware metrics. This value is used by docker to replace instances of $VSPHERE_HOST in the docker-compose.yml configuration |
| VSPHERE_USER | yourvsphereusername | The username used to authenticate to VSphere API or GUI. This value is used by docker to replace instances of $VSPHERE_USER in the docker-compose.yml configuration.  |
| VSPHERE_PASS | yourvspherepassword | The password for the VSPHERE_USER account. This value is used by docker to replace instances of $VSPHERE_PASS in the docker-compose.yml configuration and is passed to the docker-compose up command.  |

## Accessing your servers after they are started up

#### Prometheus
    http://[HOST_IP]:9090

#### Grafana 

Initial username and password is admin/admin

    http://[HOST_IP]:3000

#### Prometheus AlertManager

    http://[HOST_IP]:9093

## Importing default dashboards to Grafana

There is a folder in this repository that contains the initial dashboards that will need to be imported to Grafana to get the default visuals of the metrics being provided by this setup.  Under the grafana_dashboards folder you will find alertmanager.json and VMware ESXi-1620275779057.json.  To import the dashboards once you are on Grafana dashboard click the + sign in the left navigation panel.   

 - Choose import
 - Either upload the json files using the 'upload JSON' button or paste the json contents into the JSON input window and click load

Once imported you can navigate to the imported panels by clicking on the General text at the top of the Grafana landing page and choosing the imported dashboard.

## Credits / References
VMware Exporter
     https://github.com/pryorda/vmware_exporter

Most expressions(expr) used in the rules for prometheus alerts as well as the basics for prometheus query language can be found here:
     https://prometheus.io/docs/prometheus/latest/querying/basics

## Maintainer
  Steve Stevenson [DawtCom](https://github.com/DawtCom)