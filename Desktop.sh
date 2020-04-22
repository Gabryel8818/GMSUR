#!/bin/bash
#  zenity --info --text '<span foreground="blue" font="32">Some\nbig text</span>\n\n<i>(it is also blue)</i>'


Exit(){
	zenity --notification --window-icon='info' --text 'Voce encerrou o programa, obrigado pela utilizaçao' 
	exit;
}
Cancel(){
	zenity --notification --window-icon='info' --text 'Voce cancelou a operaçao';
}



#Option 1
Atualizar(){
   actu=$(zenity --list  --text 'Selecione a distribuiçao' --width=400 --height=380 \
   --column "Escolha"   \
   --column "Opçao"     \
   1 'Debian Ubuntu e derivados'\
   2 'Arch Linux e derivados'\
   3 'Red Hat' \
   4 'Open Suse e Suse'\
   5 'Gentoo e derivados');
   case $actu in
		1)sudo apt-get update;;
		2)sudo pacman -Syu ;;
		3)yum install update;;
		4)sudo zypper up;;
		5)sudo equo update ;;
	esac					
}

#Option 2
Create_user(){
	create=$(zenity --text 'Digite o nome do novo usuario' --entry ;)
	if [ $? -eq 0 ]
	then
		sudo adduser "$create";  
	else
		Cancel
  fi
}

#Option 3
Remote_control(){
	control=$(zenity --list --text 'Selecione o sistema' --width=400 --height=380\
	--column "Escolha"\
	--column "Opçao" \
	1 'MS Windows'\
	2 'Linux')
	case $control in
    1)user=$(zenity --text 'Digite o nome do usuario' --entry ;)
		if [ $? -eq 0 ]
		then
			IP=$(zenity --text 'Digite o numero do IP' --entry ;)
			if [ $? -eq 0 ]
			then
			rdesktop "$IP" -f -u"$user" ; 
				wait ; zenity --notification --window-icon='info' --text 'Controle remoto executado'
		else
			Cancel
			fi
		fi
    ;;

	2)user=$(zenity --text 'Digite o nome do usuario' --entry;)
		if [ $? -eq 0 ]
		then
				IP=$(zenity --text 'Digite o numero do IP' --entry;)
			if [ $? -eq 0 ]
			then
				sudo ssh-copy-id "$user"@"$IP"; wait ;
				sudo ssh "$user"@"$IP";
		else
			Cancel;
			fi
		fi
  ;;
	esac
}

#Option 4
Create_group(){
	group=$(zenity --text 'Digite  o nome do grupo a ser criado' --entry; )
	if [ $? -eq 0 ]
	then
		sudo addgroup "$group"
	else
		Cancel
	fi
}
  #Option 5
Del_group(){
	delgroup=$(zenity --text 'Digite o nome do grupo a ser deletado' --entry;)
	if [ $? -eq 0 ]
	then
		sudo delgroup "$delgroup"
	else
		Cancel
	fi
  }

  #Option 6
Def_perm(){
	permissions=$(zenity --list  --text 'Selecione ' --width=300 --height=180 \
   --column "Escolha"   \
   --column "Opçao"     \
   1 'Conceder'\
   2 'Retirar');
	case $permissions in
		1)file=`zenity --file-selection --directory --title="Selecione a pasta"`;
			conced=`zenity --text 'Digite as permissoes r w x para conceder' --entry`;
      	sudo chmod +"$conced" "$file"
     
		;;
		2)file=`zenity --file-selection --directory --title="Selecione a pasta"`;
			conced=`zenity --text 'Digite as permissoes r w x para retirar' --entry`;
      	sudo chmod -"$conced" "$file"
    ;;
	esac				
  }

#Option 7
Def_userpast(){
	confirmr=`zenity --title='Confirmaçao' --text 'O usuario ja existe? caso nao retorne ao menu (s/n)' --entry`
   	if [ $? -eq 0 ]
		then
			user=`zenity --title='Usuario' --text 'Digite o nome do usuario' --entry`
			if [ $? -eq 0 ]
			then
      		pasta=`zenity  --file-selection --directory --title='Pasta'`;
				if [ $? -eq 0 ]
				then
      			perm=`zenity --text 'Digite as permissoes r w x para conceder' --entry`;
					if [ $? -eq 0 ]
					then
						setfacl -m u:"$user":"$perm" "$pasta";
						getfacl "$pasta"; sleep 3 
					else
						Cancel    
					fi
				fi
			fi
		fi

  }
#Option 8
User_Mass(){
	zenity --notification\
	--window-icon='info' \
	--text 'Usuarios'
	file=$(zenity --question  --title='Lista de usuarios presente no arquivo' )
		if [ $? -eq 0 ]
	  	then
	  		file=$(zenity --text 'Digite o nome do arquivo contendo os usuarios' --entry)
			if [ $? -eq 0 ]
			then
				zenity --notification --window-icon='info' --text 'O processo pode demorar dependendo da quantidade de usuarios, aguarde :D'
				while read line
				do
				sudo useradd "$line"
				done < "$file"
				zenity --notification \
				--window-icon='info'\
				--text  'Usuarios criados com sucesso'

		else
			Cancel
		fi
		fi
  }

#Option 9
Backup(){
    user=`zenity --text 'Digite o nome do usuario do computador onde o backup sera feito' --entry`
    if [ $? -eq 0  ]
    then
	    IP=`zenity --text 'Digite o numero do IP da maquina que sera acessada para o Backup' --entry`
	    if [ $? -eq 0 ]
	    then 
		    zenity --notification --window-icon='warning' --text 'Pesquise pelo arquivo'
		    FIle=`zenity --file-selection --title='Backup'`
		      sudo scp -r "$file" "$user"@"$IP":/home/"$user"; 
		        if [ "$user" -eq 0 ];
		        then
		        	zenity --notification --windows-icon='info' --text 'Backup executado com sucesso'
		        else
		        	zenity --notification --windows-icon='info' --text 'O backup nao foi executado '
		        fi
		else
			Cancel;
		fi

	else
		Cancel;
	fi

  }
  Menu_Gerenciador(){
  	

     selection=$(zenity --list  --text 'Selecione a opçao' --width=400 --height=400 \
     --column "Escolha"   \
     --column "Opçao"     \
      1 'Atualizar os repositorios do sistema'\
      2 'Criar usuario'    \
      3 'Controle Remoto (WINDOWS & LINUX)'  \
      4 'Criar grupo'      \
      5 'Apagar grupo'     \
      6 'Definir permissoes de pasta'\
      7 'Definir permissoes de usuario a pasta'\
      8 'Criaçao de usuarios em massa'\
	  9 'Backup' \
      10 'Sair');
      case $selection in
      1)Atualizar;;
      2)Create_user;;
      3)Remote_control;;
      4)Create_group;;
      5)Del_group;;
      6)Def_perm;;
      7)Def_userpast;;
      8)User_Mass;;
      9)Backup;;
      10)Exit ;;
      esac
      
  }

  

  while :
  do
  Menu_Gerenciador;
  done
