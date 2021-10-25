#!/bin/bash

echo "Rick Recon DNS...."

if [ "$1" == "" ]
then
	echo "Informe o dominio alvo!"	
	echo "Ex.:"
	echo "./rick_recon_dns.sh alvo.com"
	exit 0
fi

#pesquisa de Name Servers
echo "########################"
echo "Encontrando Name Servers"
name_server=$(host -t ns $1 | cut -d " " -f4)
echo $name_server
echo "########################"


echo "########################"
echo "Encontrando Mail Servers"
mail_server=$(host -t mx $1 | cut -d " " -f7)
echo $mail_server
echo "########################"


echo "Brute force para achar subdominios DNS"
for string in $(cat rick_recon_dns_list.txt)
do
	host $string.$1 | grep "has address"
done
echo "########################"
	
echo "Tentando Transferencia de Zona DNS"
for server in $(host -t ns $1 | cut -d " " -f4);
do
	host -l $1 $server | grep "has address";
done
echo "########################"

