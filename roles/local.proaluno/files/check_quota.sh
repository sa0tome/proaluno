#!/bin/sh

# Cor da msg
GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Processando..."

while true; do
	QUOTAS=$(expr 30 - $(wget -q -O- https://quotas.fflch.usp.br/pages/today/$(whoami)))
	clear
	echo "Impressões restantes de hoje: ${GREEN}$QUOTAS ${NC}"
	echo ""
	echo "${RED}Documentos ainda não processados: ${NC}"
	lpq -a
done
