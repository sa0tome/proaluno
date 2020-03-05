#!/bin/sh

MAX_LOGON_TIME=120
ALERT_WHEN_REMAINING=5

ME=`basename "$0"`

pidlist=""

# "$$" expands to the PID of the current shell. However, in subshells
# it expands to the PID of the *parent* shell. This is a trick to get
# the actual PID of the subshell: start a sub-subshell and get the PID
# of its parent. If the code is not executed in a subshell, both will
# be the same, and that is ok.
dopidlist()
{
    myrealpid=$(exec sh -c 'echo "$PPID"')

    pgrep -v -u `whoami` '^\(grep\|pgrep\|whoami\)' | grep -E -v "\b$$\b|\b$myrealpid\b"
}

mypids()
{
    # Não dá para excluir o próprio pgrep/pkill da lista de programas
    # encontrados por pgrep/pkill; vamos fazer manualmente.

    pidlist="$(dopidlist)"
    # Já excluído em dopitlist, mas vamos garantir
    pidlist="$(echo "$pidlist" | grep -v "\b$$\b")"
}

# Este script pode não ser morto no fim da sessão; no começo
# da próxima, tentamos matar o sobrevivente anterior
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
    # Simplesmente fazer "pkill -KILL -u $(whoami)" pode fazer o pkill
    # matar a si mesmo antes de matar todos os processos. Vamos fazer
    # isso com mais cuidado.

    # Primeiro pedimos com jeitinho...
    mate-session-save --force-logout

    # Esperamos um pouco...
    local count=0
    local active=10 # Qualquer coisa, só para entrar no laço
    while [ $count -lt 10 -a $active -gt 0 ]; do
        sleep 1
        count=$(expr $count + 1)
	mypids
        active=$(echo "$pidlist" | wc -l)
    done

    # Se sobrou alguém, matamos na marra
    mypids
    active=$(echo "$pidlist" | wc -l)
    if [ $active -ne 0 ]; then
        kill -KILL $pidlist
    fi

    # Não pode ter sobrado ninguém além deste
    # script, mas não custa garantir
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
