# Pró-Aluno FFLCH

Esse repositório contém a infraestrutura como código completo dos builds das 
máquinas das salas da pró-alunos da FFLCH. 

## Imagem

A imagem é construída com um arquivo preseed.cfg, versionado neste repositório
e disponível em:

 - http://public.fflch.usp.br/proaluno/preseed.cfg

## Provisionamento

Após a instalação da imagem, a ferramenta ansible é utilizada para configuração 
do resto do ambiente.

 - Integração com o servidor de autenticação samba da FFLCH
 - Instalação das impressoras
 - Instalação de pacotes por apt

## Informações para contribuição:

### Preparação do ambiente (testado com debian 10)

1. Instale na sua distro: ansible, vagrant

2. Instalação e configuração do libvirt para criar virtualização:

    $ sudo apt install virt-manager libvirt-dev
    $ sudo addgroup SEU-USER libvirt

3. Instalação do plugin do libvirt no ansible:

    $ vagrant plugin install vagrant-libvirt

4. Ligar as VMs:

    $ cd proaluno
    $ vagrant up

5. 
