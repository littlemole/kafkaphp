#!/bin/bash

cd /opt/kafka*
echo "advertised.host.name = $HOST_IP" >> config/server.properties 


bin/zookeeper-server-start.sh config/zookeeper.properties &

sleep 5

bin/kafka-server-start.sh config/server.properties #&

#bash -i

