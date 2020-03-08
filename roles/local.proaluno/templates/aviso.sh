#!/bin/sh

su 5385361

DISPLAY=:0 zenity --warning --no-wrap --text \
'
<span size="x-large" weight="bold">
    Aviso
</span>

<span>
    {{mensagem}}
</span>
'
&
