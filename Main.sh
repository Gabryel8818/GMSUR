#!/bin/bash





#Dependences
Dependences(){
echo -e "\e[91m \e[5m Instalação das dependências \e[25m";
echo ' _______ .___  ___.      _______. __    __  .______      	';
echo '/  _____||   \/   |     /       ||  |  |  | |   _  \    	' ;
echo '|  |  __  |  \  /  |    |   (----`|  |  |  | |  |_)  |   	' ;
echo '|  | |_ | |  |\/|  |     \   \    |  |  |  | |      / 	';
echo "|  |__| | |  |  |  | .----)   |   |  |__|  | |  |\  \___ 	";
echo ' \______| |__|  |__| |_______/     \______/  | _| ._____|' ;
                                                          

echo -e '\nEscolha seu sistema Operacional'
echo ''
echo '1 - Debian Ubuntu e derivados'
echo '2 - Arch Linux e derivados'
echo '3 - Red Hat'
echo '4 - Open Suse e Suse'
echo '5 - Gentoo e derivados'
echo '6 - Fedora e derivados '
echo '7 - já contem as dependências'
read rest
    case $rest in 
	    1) 	echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;

				 		sudo apt-get update ; wait ;sudo apt-get install dialog ; wait; \
						sudo apt-get install zenity ; wait  apt-get install rdesktop;
						echo -e"\n Seu Sistema Operacional servirá como Servidor (Acessa a máquina) (s/n)" ;
						read serv
						test "$serv" == "n" && sudo apt-get install openssh-server; wait ;
						sudo apt-get install openssh-client; 
					
				
	    ;;

	    2) echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;
		 				sudo pacman -Syu ; wait ; sudo pacman -S dialog ; wait ;\
						sudo pacman -S install zenity ; wait sudo pacman -S install rdesktop;
				echo ''
				echo " Seu Sistema Operacional servira como Servidor (faz o acesso remoto?) (s/n)" ;
					read serv
					test "$serv" == "n" && sudo pacman -S install openssh-server; wait;
					sudo pacman -S install openssh-client;
		;;

	    3)  echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;
		 				sudo yum update ; wait;  sudo yum install dialog ; wait ;\
						sudo yum install zenity ;wait ; yum install rdesktop;
				echo ''
				echo " Seu Sistema Operacional servira como Servidor (faz o acesso remoto?) (s/n)" ;
					read serv
					test "$serv" = "n" && sudo yum install openssh-server; wait;
					sudo yum install openssh-client;
		
		
		
		
		;;
	    4) echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;
		 				sudo zypper update ; wait  sudo zypper install dialog ; wait \
						sudo zypper install zenity ; wait ; sudo zypper install rdesktop; wait;
				echo ''
				echo " Seu Sistema Operacional servira como Servidor (faz o acesso remoto?) (s/n)" ;
					read serv
					test "$serv" = "n" && sudo zypper install openssh-server; wait;
					sudo zypper install openssh-client;
		;;
	    5) echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;
		 				sudo equo update ; wait ; sudo equo install dialog ; wait ; \
						sudo equo install zenity ;wait ; sudo equo install rdesktop; wait ;
				echo ''
				echo " Seu Sistema Operacional servira como Servidor (faz o acesso remoto?) (s/n)" ;
					read serv
					test "$serv" = "n" && sudo equo install openssh-server;
					sudo equo install openssh-client;
		;;
		6) echo 'Deseja realmente continuar ? (s/n)'
		 			read question
		 			test $question != 's' && exit;
		 				sudo dnf update ; wait;  sudo dnf install dialog ; wait; \
						sudo dnf install zenity ; wait; sudo dnf install rdesktop; wait
				echo ''
				echo " Seu Sistema Operacional servira como Servidor (faz o acesso remoto?) (s/n)" ;
					read serv
					test "$serv" = "n" && sudo dnf install openssh-server; wait;
					sudo dnf install openssh-client;
		;;
		7)  clear;
			echo "Utilizar o script para Desktop (1)"
		   	echo "Utilizar o script para servidor (2)"
		   	read -p ":" script
		   	if [ $script -eq 1 ]
		   		then
		   			source Desktop.sh
		   			Menu_Gerenciador; #Chamando a função do arquivo principal Desktop
		   		else 
		   			./Server.sh; #Chmando o script Server
		   	fi



			  
		
		;;
		*) exit;

	esac 

}

Dependences;