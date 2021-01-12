#!/bin/bash
#exec java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5000 -Djava.util.logging.config.file=/etc/jitsi/jibri/logging.properties -jar /opt/jitsi/jibri/jibri.jar --config "/etc/jitsi/jibri/config.json"
exec java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5000  -Djava.util.logging.config.file=/etc/jitsi/jibri/logging.properties -jar /opt/jitsi/jibri/jibri.jar --config "/etc/jitsi/jibri/config.json" --internal-http-port 3333 --http-api-port 2222

#exec java -Djava.util.logging.config.file=/etc/jitsi/jibri/logging.properties -jar /opt/jitsi/jibri/jibri.jar --config "/etc/jitsi/jibri/config.json"
