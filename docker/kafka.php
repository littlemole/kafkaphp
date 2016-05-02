<?php

$brokerlist = getenv("HOST_IP").":9092";

$kafka = new Kafka($brokerlist);
$kafka->produce("test", "helo from php");        
?>

send "helo from php" to kafka server <?php echo $server ?>

  
  
  
