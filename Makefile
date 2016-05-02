PWD = $(shell pwd)
HOST_IP = $(shell docker/ip.sh)

NS=mol
IMG=phpkafka
VERSION=1.0
TAG="$(NS)/$(IMG):$(VERSION)"

all: demo

clean:
	find -name '*~' -exec rm {} \;
	
image: clean
	sudo docker build -t $(TAG) .
	
run: stop image
	sudo docker run --name $(IMG) -d -p 6080:80 -e HOST_IP=$(HOST_IP) $(TAG)
                                        
bash:                                   
	sudo docker exec -ti $(IMG) bash

stop:   
	-sudo docker stop $(IMG)
	-sudo docker rm $(IMG)
	
demo:
	echo $(HOST_IP)
	cd kafka && make demo HOST_IP=$(HOST_IP)
	sleep 2
	make run
				

        
                                                                        
