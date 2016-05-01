#!/bin/bash

echo -e "\nexport HOST_IP=$HOST_IP\n" >> /etc/apache2/envvars

source /etc/apache2/envvars && /usr/sbin/apache2 -DFOREGROUND



