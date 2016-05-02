# kafkaphp
docker dev testbed for kafka with php (with a dev kafka mini cluster)

- **make image**
  builds the docker phpkafka image
  
- **make run**
  runs the phpkafka image
  
- **demo**
  runs the kafka cluster form kafka subfolder, creates topic 'test' and starts the phpkafka container on port 80
  
do __cd kafka && make consumer__ to see any messages posted to kafka

open your browser pointing to http://localhost:80 to send a simple test kafka messsage from php
