<?php

//$a = get_loaded_extensions (false );
//var_dump($a);

//phpinfo();

$server = getenv("HOST_IP").":9092";

$kafka = new Kafka($server);
$kafka->produce("test", "helo from php");        
?>

send "helo from php" to kafka server <?php echo $server ?>

  
  
  