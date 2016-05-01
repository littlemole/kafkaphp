
mini dev kafka with zk

usage:

- make image
  builds the image

- make run
  runs the image as a docker container
  zookeeper is on port 2181
  kafka on port 9092

- make topic
  creates topic 'test'

- make consumer
  runs a simple console kafka consumer listening on topic 'test'

- make producer
  runs a simple console kafka producer pushing each line of input to topic test

- make demo
  build and run image, then create topic test

