#!/bin/bash

# limpando homes
homes=$(ls /home)
for home in $(echo $homes | tr " " "\n"); 
do 
    if [ "$home" != "vagrant" ];then
        rm -rf /home/$home
    fi
done




