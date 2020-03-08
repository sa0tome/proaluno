#!/bin/sh
  
export LANG=C
export XAUTHORITY=/home/$TEAUSERNAME/.Xauthority
export DISPLAY=:0
su -c "xterm -title 'Quotas' -fa 'Noto Mono' -fs 16 -geometry 70x16 -e /proaluno/check_quotas.sh" $TEAUSERNAME
exit 0
