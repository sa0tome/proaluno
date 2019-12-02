# Pró-Aluno FFLCH

Esse repositório contém a infraestrutura como código completo dos builds das máquinas
das salas da pró-alunos da FFLCH. 

## Imagem

A imagem é construída com o arquivo preseed.cfg.

## Provisionamento

Após a instalação da imagem, a ferramenta ansible é utilizada para configuração 
do resto do ambiente:

### Autenticação

Integração com o servidor de autenticação samba da FFLCH

### Instalação das impressoras

### Instalação de softwares do repositório oficial debian:

 - r-base
 - chromium-browser
 - vlc
 - okular
 - audacity
 - terminator
 - cdo
 - nco
 - grads
 - gfortran

### Instalação de softwares que não estão nos repositórios do debian

 - opengrads
 - Rstudio

