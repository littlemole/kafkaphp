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

# kafkaphp, explained

connecting to kafka from php is based on <https://github.com/EVODelavega/phpkafka>, which in turn relies on
([librdkafka](https://github.com/edenhill/librdkafka/)).

for the docker image, after installing some base dependencies and pushing the whole thing to php 5.6 both librdkafka as well as the phpkafka php extension are build from source.

now you can do:

```php
<?php
$brokerlist = "<broker_ip>:9092";
$kafka = new Kafka($brokerlist);
$kafka->produce("test", "helo from php");
?>
```
