Instructions
Your internal security team has requested the centralization of system message and authorization logs (/var/log/message and /var/log/secure) for one of your public facing CentOS 7 production systems for their security information and event management (SIEM) requirements. To faciliate this request, you are being asked to install:
Filebeat
Elasticsearch
Kibana
The security team will access Kibana over an SSH tunnel and expects to have system logs available for both searching and visualizing via dashboards. Once all the services are installed, working together, and configured to startup after a system reboot, you should access Kibana over an SSH tunnel and make sure the system dashboards are ready for the security team to analyze.
Objectives
help
Install Elasticsearch
Install Elasticsearch with default settings:
Install Java:
 yum install java-1.8.0-openjdk -y
Import Elastic's GPG key:
 rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
Download the Elasticsearch RPM:
 curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.3.rpm
Install Elasticsearch:
 rpm --install elasticsearch-6.2.3.rpm
Enable and start Elasticsearch:
 systemctl daemon-reload
 systemctl enable elasticsearch
 systemctl start elasticsearch
help
Install Kibana
Install Kibana with default settings:
Download Kibana:
 curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.3-x86_64.rpm
Install Kibana:
 rpm --install kibana-6.2.3-x86_64.rpm
Enable and start Kibana:
 systemctl enable kibana
 systemctl start kibana
help
Install Filebeat and use the System Module
Install Filebeat with default settings and use the system module:
Download Filebeat:
 curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.3-x86_64.rpm
Install Filebeat:
 rpm --install filebeat-6.2.3-x86_64.rpm
Edit the system module to convert timestamp timezones to UTC:
In /etc/filebeat/modules.d/system.yml.disabled, change:
 # Convert the timestamp to UTC. Requires Elasticsearch >= 6.1.
 #var.convert_timezone: false
To:
 # Convert the timestamp to UTC. Requires Elasticsearch >= 6.1.
 var.convert_timezone: true
For both the syslog and auth sections.
Enable the system Filebeat module:
 filebeat modules enable system
Install the ingest-geoip filter plugin for Elasticsearch ingest node:
 /usr/share/elasticsearch/bin/elasticsearch-plugin install ingest-geoip
Restart Elasticsearch so it can use the new ingest-geoip plugin:
 systemctl restart elasticsearch
Once Elasticsearch starts up, push module assets to Elasticsearch and Kibana:
 filebeat setup
Enable and start Filebeat:
 systemctl enable filebeat
 systemctl start filebeat
help
Connect to Kibana and explore the data
Connect to Kibana and explore your system log data:
From your local machine, SSH with port forwarding to your cloud server's public IP:
 ssh user_name@public_ip -L 5601:localhost:5601
Navigate to localhost:5601 in your web browser.
Go to the Dashboard plugin via the side navigation bar.
Search for system to filter to your system dashboards.
Explore your system log data with the supplied dashboards.