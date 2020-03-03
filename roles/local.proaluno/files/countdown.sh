#!/bin/sh

MAX_LOGON_TIME=120
ALERT_WHEN_REMAINING=5

ME=`basename "$0"`

cleanup()
{
    for pid in `pgrep $ME`; do
        if [ $pid -ne $$ ]; then
            kill $pid
        fi
    done
}

alert()
{
    gdialog --print-maxsize --msgbox \
    "Seu tempo está acabando, lembre-se que seus dados são apagados no logout!"
}

do_logout()
{
    pkill -KILL -u $(whoami)
}

main()
{
    local sleep_until=$(expr $MAX_LOGON_TIME - $ALERT_WHEN_REMAINING)

    cleanup
    sleep "${sleep_until}m"
    alert &
    sleep "${ALERT_WHEN_REMAINING}m"
    do_logout
}

main
