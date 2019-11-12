# Pró-Aluno FFLCH

Esse repositório contém o código com procedimento completo de build das máquinas
das salas da pró-alunos da FFLCH. 

## Imagem

A imagem é construída com [Preseed](https://wiki.debian.org/DebianInstaller/Preseed)
e executam os seguintes procedimentos:

 - Escolha do mate como ambiente gráfico
 - Carregamento de um script para configurar o hostname da máquina a partir do dhcp
 - 

## Provisionamento

Após a instalação da imagem, a ferramenta ansible é utilizada para configuração 
do resto do ambiente, na ordem:

### Autenticação

Integração com o servidor de autenticação principal da FFLCH

### Instalação das impressoras

### Instalação de softwares do repositório oficial debian

 - r-base
 - chromium-browser
 - vlc
 - audacity
 - terminator

### Instalação de softwares que não estão nos repositórios do debian

 - google chrome
 - Rstudio

