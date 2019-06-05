#!/bin/bash

#Name: Gerencimento e Manutenção de Softwares e Usuários Remotamente
#Date: 16/04/2019
#Faça as leituras do Código antes de iniciá-lo

#<aqui o programa se inicia\>
#sudo apt-get update & sudo apt-get install dialog
#Looping do Menu o que faz a saida sempre retornar a ele

#A function (bye) nos serve de economia de codigo para uma parte que sera utilizada muitas vezes
bye()
{
   dialog --title 'Equipe Remoli'   \
			 --infobox 'A equipe Remolinu agradece a sua colaboração!' 5 35 ; sleep 3;
}
while : ; do
   #Aqui a variavel ($receba) literalmente recebe o dado digitado pelo usuario
   receba=$(dialog --stdout  --title 'Gerenciamento de Softwares e Usuários' --radiolist '' 0 0 0                                      \
    1 'Atualizar o software (linux)' off  2 'Criar grupo ' off  3 'Apagar o grupo' off   4 'Definir grupos para usuários'  off \
    5 'Criar usuários' off  6 'Fazer Backups'  on     7 'Modificar permissões de pasta'    off  8 'Modificar permissões de usuario a pasta'  off  \
    9 'Monitorar mensagens do sistema' off  10 'controle remoto' off 11 'Verificar placas de rede e IP' off  12 'Criação de usuários em massa' off   13 'Sair' off ;)
   #aqui o comando case irá criar a situaçao de acordo com a opção escolhida acima
   case $receba in 

		1) system=$(dialog --stdout --title 'Gerenciamento de Software' \
            --radiolist 'Escolha seu sistema' 0 0 0 \
            1  'Debian Ubuntu e derivados' on \
            2 'Arch Linux e derivados' off\
            3 'Red Hat'  off\
            4 'Open Suse e Suse'  off\
            5 'Gentoo e derivados' off ;)
               case $system in 
                  1)sudo apt-get update ;;
                  2)sudo pacman -Syu ;;
                  3)yum install update;;
                  4)sudo zypper up;;
                  5)sudo equo update ;;
               esac		

      ;;

      2) dialog --stdout --title 'Gerenciamento de Grupo' --yesno 'Criando  grupo' 16 65 ;	                                          \
			if [ $? -eq 0 ]; 
         then
			   #a variável grupo recebe o nome do grupo
			   grupo=$(dialog --stdout  --inputbox 'Nome do grupo' 0 0 ;)
			  	if [ $ -eq 0 ];
				then
				   #comando que atribuiu o nome da string ao grupo
				   sudo addgroup "$grupo" ;
			   else
              bye ;
            fi
         fi
      ;;

      3) w; sleep 4
         dialog --stdout --title 'Gerenciamento de Grupo'                                                                              \
    	          --yesno 'apagando Grupo' 16 65
         if [ $? -eq 1 ]; 
         then 
            #Efeito reverso inicia-se com um valor negativo para saída (nada que influêncie no código em si)
            exit  
         else
            #A variável grupo recebe o nome do grupo
            grupo=$(dialog --stdout --inputbox 'Digite o nome do Grupo' 0 0 ; )
            #Comando que delete o grupo
            sudo delgroup "$grupo" ;
         fi
      ;;

      4) dialog --yesno   'O Grupo e o usuário já existem? caso não, Retorne ao menu pressionando a opção "Não"!' 0 0 ;
         if [ $? -eq 0 ]; 
         then
            #Variável user recebe o nome do usuário
               user=$(dialog --stdout --title 'Digite o nome do Usuário'  \
                             --inputbox 'digite:  ' 0 0 ; )
            if [ $? -eq 0 ]; then
               #Variavel group recebe o nome do grupo
               group=$(dialog --stdout --title 'Digite o nome do Grupo' \
                              --inputbox 'Digite:' 0 0 ; )
               #Comando que adiciona um usuário a um grupo
               sudo gpasswd -a "$user" "$group" ; sleep 3 ;
            else
               exit ;
            fi
         fi
      ;;
    	# User recebe o nome do usuário
    	#Backtitle só esta sendo utilizado por estetica para o titulo ficar ao fundo da Caixa de Diálogo
      5) user=$(dialog --stdout --backtitle 'Criação de usuário' --inputbox 'Digite o nome do novo usuário' 0 0 ; )
         if [ $? -eq 0 ]; 
         then
            sudo adduser $user ; sleep 02  ;
         else
	         dialog --title 'Equipe Remoli'                                                                                        \
			          --infobox 'A equipe Remolinu agradece a sua colaboração!' 5 35 ; sleep 3; 
         fi    
      ;;

         #ip recebe um número simbolizando o IP a ser acessado para Backup
      6) ip=$(dialog --stdout --title 'Backup' --inputbox 'Digite o seu  IP para ser conectado o Backup na rede' 0 0 ;) 
            if [ $? -eq 0 ]; 
            then 
               #arq recebe um valor atribuido pelo comando fselect dentro do dialog uma caixa de busca é aberta
               arq=$(dialog --stdout --title 'Arquivo que será feito a cópia (Backup)' --fselect /home 20 100;)
               if  [ $? -eq 0 ];
               then
                 user=$(dialog --stdout --title 'Digite o nome do usuário a ser acessado' --inputbox '' 0 0 ;) 
                  if [ $? -eq 0 ]; 
                  then
                  #Comando que faz a cópia de arquivos na rede de uma máquina local para remota 
                  #a sitaxe é : scp caminho user@IP:Caminho de destino
                      sudo scp -r "$arq"  "$user"@"$ip":/home/"$user" ; sleep 2
                  else
                     dialog --title 'Equipe Remoli' \
			                   --infobox 'A equipe Remolinu agradece a sua colaboração!' 5 35 ; sleep 3;
                  fi
               fi
            fi
         ;;
		 #arquiv recebe o arquivo vindo de dselect comando para buscar diretórios  
       #/ OK-LABEL OU CANCEL Renomeiam oq contem nas caixas Ok e Cancel do Dialog
         7) arquiv=$(dialog --cancel-label 'Retirar' --ok-label 'Conceder' \
                          --stdout --title \
                          'Cace o diretorio Cuidado os botões indicam retirada e acrescimo de permissões  (Única saída será apertando CTRL C' \
                          --dselect /home/melo 20 100 ; )
            if [ $? -eq 0 ]; 
            then
            #Variável perm recebe as permissões digitadas pelo usuário sendo r w ou x
               perm=$(dialog --stdout --title 'Conceda as Permissões' \
               --inputbox 'digite r para leitura w para escrita e x para execução escreva sem espaços' 0 0 ;)
                  sudo chmod -vf +"$perm" "$arquiv" ;
            else
            #Como o botão foi renomeado este caso recebe a retirada das permissões na variável perma
               perma=$(dialog --stdout --title 'Tire as Permissões' \
                              --inputbox 'Digite r para leitura w para escrita e x para execuçao escreva sem espaços' 0 0 ;)
                  sudo chmod +rwx "$arq" ; sudo chmod  -vf -"$perma" "$arquiv" ;
            fi
         ;;
         8) dialog \
            --infobox 'Preste atenção nos próximos dados abaixo!!! (onde a primeira linha são os usuários do sistema e a  segunda os grupos )' 0 0 ;
                                 w; sleep 2; groups; sleep 3;
            #Recepção de uma estrutura de se|então|senão
            dialog --stdout --title 'Grupo' --yesno 'O usuário e o grupo já existe? Caso não, crie eles com a opção já existente no menu' 0 0 ;
               if [ $? -eq 0 ]; 
               then
                  #Temos estruturas de IFs aninhados onde mais de um caso é verdadeiro para o prosseguimento
                  #A variável user recebe o nome do usuário
                  user=$(dialog --stdout --inputbox 'Digite o nome do usuário' 0 0 ;) 
                  if [ $? -eq 0 ];
                  then
                     #A variável arq rece o caminho do arquivo
                     #Fselect seleciona os diretório e tambem arquivos contidos
                     arq=$(dialog --stdout --title 'Escolha o arquivo ou diretório' --fselect /home 20 100 ;)
                     if [ $? -eq 0 ]; 
                     then
                        #Permi recebe as permissões ao arquivo
                        permi=$(dialog --stdout --title 'DE AS PERMISSOES' \
                        --inputbox 'digite r para leitura w para escrita e x para execução escreva sem espaços' 0 0 ;)
                           sudo setfacl -m u:"$user":"$permi" "$arq" ; sleep 2
                           getfacl "$arq" ; sleep 5;
                     else 
                        dialog --stdout --msgbox 'saindo' 0 0  ;
                     fi
                  fi
               fi
         ;;
           #Comando Tailbox recebe em uma box ou seja caixa tudo que o comando tail nos trás nete caso os arquivos de log
           #Cada arquivo de log cria um novo arquivo como por exemplo out out1 out2 etc..
        9) tail -f /var/log/Xorg.0.log > out & dialog --backtitle 'Monitorando mensagens do Sistema' --tailbox out 0 0 ;
           tail -f /var/log/auth.log > out1 & dialog --backtitle 'Monitorando mensagens do Sistema' --tailbox out1 0 0 ;
           tail -f /var/log/fontconfig.log > out2 & dialog --backtitle 'Monitorando mensagens do Sistema' --tailbox out2 0 0 ;
           tail -f /var/log/gpu-manager.log > out3 & dialog --backtitle 'Monitorando mensagens do Sistema' --tailbox out3 0 0 ;
           tail -f /var/log/syslog > out4 & dialog --backtitle 'Monitorando mensagens do Sistema' --tailbox out4 0 0 ;

         ;;
            #A variável nome recebe o nome do usuário
        10) nome=$(dialog --stdout --title 'nome' --inputbox 'Digite o nome do usuário a ser acessado' 0 0 ;)
                     if [ $? -eq 0 ]; 
                     then 
                        #A variável ipe recebe o IP da máquina para o acesso remoto
                        ipe=$(dialog --stdout --title 'IP' --inputbox 'Digite o IP da máquina a ser acessada' 0 0 ;) 
                           ssh-copy-id "$nome"@"$ip" & ssh "$nome"@"$ipe" ; 
                     fi
         ;;
            #Neste caso são comandos do sistema para mostrar as configurações da placa de rede
         11) ifconfig ; sleep 5; 
         ;;
            #A variável lista recebe o arquivo com o nome dos usuários para a criação em massa dos mesmos
         12) lista=$(dialog --stdout --title 'Criaçao em massa' --inputbox 'Digite o nome do arquivo contendo os usuarios' 0 0 ;)
               if [ $? -eq 0 ] ;
               then
                  while read line
                  do
                  sudo useradd "$line"
                  done < "$lista"
                  dialog --msgbox 'Usuarios adicionados com sucesso!'
               else
               dialog --stdout \
                      --infobox 'A equipe Remolinu agradece a sua colaboração!' 5 35 ;
               fi

         ;;
            #Break é um comando que como o próprio nome diz faz parada no script
        13) break
         ;;

esac
done
