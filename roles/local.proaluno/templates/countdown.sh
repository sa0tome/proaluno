#!/bin/sh

MAX_LOGON_TIME={{proaluno_max_logon_time}}
ALERT_WHEN_REMAINING=5

# Let's be nice :)
renice 19 $$

# Bash normalmente ignora alguns sinais, pelo menos em se tratando
# de shells interativos. Vamos garantir que este script termine
# com qualquer sinal razoável. Vamos também garantir que do_logout
# seja executada até o fim sem interrupções.
exiting=no
cleanexit()
{
    # Desnecessário, mas pode evitar problemas e impede que o usuário
    # mate facilmente este script para permanecer logado por mais tempo.
    if [ $exiting = "no" ]; then
        do_logout
    fi
}

trap cleanexit TERM HUP INT QUIT


# "$$" expands to the PID of the current shell. However, in subshells
# it expands to the PID of the *parent* shell. So, we use a trick to get
# the actual PID of the subshell: start a sub-subshell and get the PID
# of its parent. If the code is not executed in a subshell, both will
# be the same, and that is ok. findmypids() and updatepidlist() are
# separate funcions to make sure we do not screw this up.
pidlist=""
findmypids()
{
    myrealpid=$(exec sh -c 'echo "$PPID"')

    pgrep -v -u `whoami` '^\(grep\|pgrep\|whoami\)' | grep -E -v "\b$$\b|\b$myrealpid\b"
}

updatepidlist()
{
    pidlist="$(findmypids)"
    # Já excluído em findmypids, mas vamos garantir
    pidlist="$(echo "$pidlist" | grep -v "\b$$\b")"
}


alert()
{
zenity --warning --no-wrap --text \
'<span size="x-large" weight="bold">
     Seu tempo está acabando, restam 5 minutos!     

     Lembre-se que seus dados     
     são apagados no logout!     
</span>'
}


do_logout()
{
    # Se recebermos um sinal enquanto do_logout é executada, ignoramos
    exiting=yes

    # Simplesmente fazer "pkill -KILL -u $(whoami)" pode fazer o pkill
    # matar a si mesmo antes de matar todos os processos. Vamos fazer
    # isso com mais cuidado.

    # Primeiro pedimos com jeitinho...
    mate-session-save --force-logout

    # Esperamos um pouco...
    local count=0
    local active=10 # Qualquer coisa, só para entrar no laço
    while [ $count -lt 15 -a $active -gt 0 ]; do
        sleep 1
        count=$(expr $count + 1)
	updatepidlist
        active=$(echo "$pidlist" | wc -l)
    done

    # Se sobrou alguém, matamos na marra
    updatepidlist
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
    # Não é boa ideia fazer algo como "sleep 120m"; se o usuário
    # encerrar a sessão antes de duas horas, este script vai
    # esperar o final de sleep antes de parar a execução. Talvez
    # isso não tenha consequências ruins, mas vamos evitar.

    local start=$(date +%s)
    local warning=$(date --date "now + $MAX_LOGON_TIME minutes - $ALERT_WHEN_REMAINING minutes" +%s)
    local finish=$(date --date "now + $MAX_LOGON_TIME minutes" +%s)

    local now=$start
    while [ $now -lt $warning ]; do
        sleep 10
	now=$(date +%s)
    done

    alert &

    while [ $now -lt $finish ]; do
        sleep 10
	now=$(date +%s)
    done

    do_logout
}

main
