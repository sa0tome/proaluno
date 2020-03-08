#!/bin/sh

export LANG=C
export XAUTHORITY=/home/{{ logado }}/.Xauthority
export DISPLAY=:0


su -c "zenity --warning --no-wrap --text \
'
<span size=\"x-large\" weight=\"bold\">
    Aviso
</span>

<span>
    {{mensagem}}
</span>
'
" {{ logado }}
