# kafkaphp
docker dev testbed for kafka with php (with a dev kafka mini cluster)

- **make image**
  builds the docker phpkafka image
  
- **make run**
  runs the phpkafka image
  
- **make demo**
  runs the kafka cluster form kafka subfolder, creates topic 'test' and starts the phpkafka container on port 80
  
do __cd kafka && make consumer__ to see any messages posted to kafka.

now open your browser pointing to <http://localhost/kafka.php> to send a simple test kafka messsage from php.

see [kafka/README.md](https://github.com/littlemole/kafkaphp/blob/master/kafka/README.md) for the kafka mini cluster.

# kafkaphp, explained

connecting to kafka from php is based on [phpkafka](https://github.com/EVODelavega/phpkafka), which in turn relies on
[librdkafka](https://github.com/edenhill/librdkafka/).

for the docker image, after installing some base dependencies and pushing the whole thing to php 5.6 both librdkafka as well as the phpkafka php extension are build from source.

now you can do:

```php
<?php
$brokerlist = "<broker_ip>:9092";
$kafka = new Kafka($brokerlist);
$kafka->produce("test", "helo from php");
?>
```

#caveats

- librdkafka by defaults installs to /usr/local/lib where apache2/php won't find it. solutions are a) symlinking or b) ./configure --prefix=/usr/lib c) add /usr/local/lib to /etc/ld.so.conf and run ldconfig

- phpkafka extension is easiest loaded with full path in php.ini extension=/full/path/to/kafka.so

- for the multiple docker container setup it is necessary for the kafka broker to have its **advertised.host.name = $HOST_IP** set so that the correct ip is announced to zookeeper.
