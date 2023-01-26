#!/bin/bash
#Referência: https://daemoniolabs.wordpress.com/2013/08/14/cores-em-shell-scripts-sem-caracteres-escapes-com-tput/
#https://daemoniolabs.files.wordpress.com/2013/08/tabelinha_cores.png
#arraycores['vermelho']=1
#arraycores['verde']=2
#arraycores['amarelo']=3
#arraycores['azul']=4
#arraycores['rosa']=5
#arraycores['azulclaro']=6
#arraycores['cinzaclaro']=7

#txtrst=$(tput sgr0) # Texto original
#txtred=$(tput setab 1) # Fundo Vermelho
#txtblue=$(tput setab 4) #Fundo azul
#txtgreen=$(tput bold ; tput setaf 2) # Verde em Negrito
#txtyellow=$(tput bold ; tput setaf 3) # Amarelo em Negrito

#Ex: echo "${txtgreen}Timezone configurado para America/Sao_Paulo ${txtrst}"

ARG01="${1}"

txtrst=$(tput sgr0) # Texto original
txtred=$(tput setaf 1) # Vermelho
txtgreen=$(tput setaf 2) # Verde
txtrosa=$(tput setaf 5) # Rosa
txtblue=$(tput setaf 6) # Azul Claro

 if [ "$ARG01" == "" ]
then
        echo "${txtred}---------------------------------------------------------"
        echo "É NECESSÁRIO INFORMAR A URL"
        echo "MODO DE USO: $0 site.com"
        echo "---------------------------------------------------------${txtrst}"
else


LINHA=`seq -s '=' 100 | tr -d [:digit:]`
NOME_ARQUIVO=$1.ip.txt
NLINHA=0

wget -qO index.html $1
rm $1.txt > /dev/null
grep href index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > $1.txt
rm -rf index.html

echo "${txtrosa} $LINHA ${txtrst}"
echo ""
echo "${txtgreen}[+] Resolvendo URLs em: ${txtrst} ${txtblue} $1 ${txtrst}"
echo ""
echo "${txtrosa} $LINHA ${txtrst}"
echo ""

echo "${txtred}[+] Concluido: Salvando os resultados em: ${txtgreen} $NOME_ARQUIVO ${txtrst}"
echo ""
echo "${txtrosa} $LINHA ${txtrst}"
echo ""
echo -e "\t LINHA \t\t\t IP \t\t\t ENDERECO"
echo  "${txtrosa} $LINHA ${txtrst}"

for url in $(cat $1.txt);
do
IP=`host $url | grep "has address" | cut -d " " -f 4`
URL=`host $url | grep "has address" | cut -d " " -f 1`
NCarac=${#IP}

if [ "$NCarac" -gt "7" ]
then
        NLINHA=$((NLINHA+1))

        if [ "$NCarac" -gt "13" ]
        then
                echo -e "\t $NLINHA \t\t$IP \t $URL " >> $NOME_ARQUIVO
                echo -e "\t $NLINHA \t\t$IP \t $URL"
        else
                echo -e "\t $NLINHA \t\t$IP \t\t $URL " >> $NOME_ARQUIVO
                echo -e "\t $NLINHA \t\t$IP \t\t $URL";
        fi
        #echo "\t $NLINHA \t\t $IP \t\t $URL";
fi
done

echo "${txtrosa} $LINHA ${txtrst}"

fi
