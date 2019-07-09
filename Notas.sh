#!/bin/bash
# Notas Mnemotécnicas
# NOMBRE DE ARCHIVO: Notas.sh
# Sergio S. Juárez Rivera
# Ver 0.0.1
# Variables: 0
# PENDIENTES: 0
# Variables: 1

#Definir Editor de texto: leafpad, mousepad, gedit
EDITOR=mousepad

function edata {
							cp /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt /home/$USER/APPSCRIPTS/Notas/Data/Notas.bak
							$EDITOR /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
	}
function ekey {
							cp /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt /home/$USER/APPSCRIPTS/Notas/Data/Keywords.bak
							$EDITOR /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
	}
function new {
							echo "Define una llave mental" | iconv -f utf-8 -t iso-8859-1 | festival --tts &
							FECHA=`date +%F`
							HORA=`date +%H:%M:%S`
							KEY=`zenity --title "¿ Llave mental (KEYWORD) ?"  --entry --text="Define una llave mental para relacionar esta nota"`
							TXT=`zenity --title "Llave mental definida : : : $KEY : : : "  --entry --text="Escribir Nota :                                                                                                      "`
							echo $KEY >> /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							echo $KEY ::: $FECHA / $HORA ::: $TXT >> /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt 
							notify-send -i /home/sergiojr24/ICONOS/OK.png "$KEY" "$TXT" &
							echo "Nota salvada" | iconv -f utf-8 -t iso-8859-1 | festival --tts &
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
exit
	}
function keyword {
							cat /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt | sort | uniq > /tmp/Keywords.tmp
							cat /tmp/Keywords.tmp > /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt
							cat /home/$USER/APPSCRIPTS/Notas/Data/Keywords.txt | zenity --title "Llaves (KEYWORDS) definidas : " --width=250 --height=350 --text-info
							exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
}
#function contact{}
function help {
						cat /home/sergiojr24/APPSCRIPTS/Notas/Docs/help.txt | zenity --title "HELP!" --width=450 --height=550 --text-info
						exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
}
#function donate{}
#function about {}

BUSCAR=`zenity --title "BUSCAR EN NOTAS - HELP! para ayuda" --entry --text="N! nueva nota - BUSCAR: Palabra, texto, dato o comando :                                 "`

if [ -z "${BUSCAR}" ]; then
notify-send -i /home/sergiojr24/ICONOS/OK.png "Asumo que quiere salir . . ." "BUSCADOR DE NOTAS"
exit 0

else
case $BUSCAR in
		edata!) edata ;;
		EDATA!) edata ;;
		ekey!) ekey ;;
		EKEY!) ekey ;;
		keyword!) keyword ;;
		KEYWORD!) keyword ;;
		key!) keyword ;;
		KEY!) keyword ;;
		n!) new ;;
		N!) new ;;
		contact!) contact ;;
		CONTACT!) contact ;;
		help!) help ;;
		HELP!) help ;;
		donate!) donate ;;
		DONATE!) donate ;;
		about!) about ;;
		ABOUT!) ABOUT ;;
esac

notify-send -i /home/sergiojr24/ICONOS/gnome-mime-text-x-scheme.png "Buscando . . .  :  $BUSCAR" "Dentro de Notas"
# echo "Aqui esta la informacion" | festival --tts &
cat /home/$USER/APPSCRIPTS/Notas/Data/Notas.txt | grep -i "$BUSCAR" > /tmp/find_data.tmp
cat /tmp/find_data.tmp | zenity --title "BUSQUEDA CONCLUIDA CON : $BUSCAR" --width=1300 --height=550 --text-info
exec /home/$USER/APPSCRIPTS/Notas/Notas.sh
fi
exit
