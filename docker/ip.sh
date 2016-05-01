#!/bin/bash

HOST_IP=$(sudo ifconfig docker0 | grep -oh "inet addr:[0-9.]*" | sed  's/inet addr://' | sed 's/[\s]*//') 

echo -n $HOST_IP
