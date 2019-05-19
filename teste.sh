#!/bin/bash
		file=$(zenity --text 'Digite o nome do arquivo contendo os usuarios' --entry)
    		while read line
    		do
      	sudo useradd "$line"
      	done < "$file"
			zenity --notification \
			--window-icon='info'\
			--text  'Usuarios criados com sucesso'
