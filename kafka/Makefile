PWD = $(shell pwd)
HOST_IP = $(shell docker/ip.sh)

NS = mol
IMG = kafka
VERSION = 1.0
TAG = "$(NS)/$(IMG):$(VERSION)"

PORTS = -p 2181:2181 -p 9092:9092
ENV = -e HOST_IP=$(HOST_IP)

DOCKER_EXEC = sudo docker exec -ti $(IMG) sh -c 

ZK = --zookeeper localhost:2181
BROKER = --broker-list $(HOST_IP):9092 
KAFKA = cd /opt/kafka* && 
KAFKA_LIST = bin/kafka-topics.sh --list
KAFKA_TOPIC = bin/kafka-topics.sh --create --replication-factor 1 --partitions 1 --topic
KAFKA_PRODUCER = bin/kafka-console-producer.sh --topic
KAFKA_CONSUMER = bin/kafka-console-consumer.sh --from-beginning --topic

all: run

clean:
	find -name '*~' -exec rm {} \;
	
image: clean
	sudo docker build -t $(TAG) .
	
run: stop image
	sudo docker run --name $(IMG) -d $(PORTS) $(ENV) $(TAG)
                                        
bash:                                   
	sudo docker exec -ti $(IMG) bash

stop:   
	-sudo docker stop $(IMG)
	-sudo docker rm $(IMG)

list:
	$(DOCKER_EXEC) '$(KAFKA) $(KAFKA_LIST) $(ZK)'
#	sudo docker exec -ti $(IMG) sh -c 'cd /opt/kafka* && bin/kafka-topics.sh --list --zookeeper localhost:2181'
	
topic:  
	$(DOCKER_EXEC) '$(KAFKA) $(KAFKA_TOPIC) test $(ZK) '
#	sudo docker exec -ti $(IMG) sh -c 'cd /opt/kafka* && bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test'
	
producer:
	$(DOCKER_EXEC) '$(KAFKA) $(KAFKA_PRODUCER) test $(BROKER) '
#	sudo docker exec -ti $(IMG) sh -c 'cd /opt/kafka* && bin/kafka-console-producer.sh --broker-list 172.17.42.1:9092 --topic test'

consumer:
	$(DOCKER_EXEC) '$(KAFKA) $(KAFKA_CONSUMER) test $(ZK) '
#	sudo docker exec -ti $(IMG) sh -c 'cd /opt/kafka* && bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning'
		

demo: run 
	echo "kafka started ... $(HOST_IP)"
	sleep 10
	make topic
	make list
	
	        
                                  
test :
	echo $(IMGNAME)           
	                           