#!/bin/bash

# Tentando desabilitar tela de descanço
# https://ubuntu-mate.community/t/stop-the-screen-from-blanking-in-ubuntu/678/3
xset s off

/proaluno/countdown.sh &

conky -d -p 5
