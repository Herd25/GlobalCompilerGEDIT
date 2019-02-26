#!/bin/sh

######################################
######################################
######                       #########
####### UNIVERSAL COMPILER ###########
######### FOR GEDIT BY ###############
#### CREATED DESIGN&PROGRAMING #######
######                       #########
######################################
######################################


######################################
######################################
######                       #########
### ESTE COMPILADOR FUE DISEÑADO #####
##### EL PROPOSITO DE HACER A   ######
##### GEDIT UN GRAN IDE QUE   ########
##### COMPILE CODIGO DE SERIE ########
######                       #########
######################################
######################################

clear

bash

dir=$GEDIT_CURRENT_DOCUMENT_DIR

type=$GEDIT_CURRENT_DOCUMENT_TYPE

name=$GEDIT_CURRENT_DOCUMENT_NAME

path=$GEDIT_CURRENT_DOCUMENT_PATH

out="out"

cd "$dir"

# echo "${type}"
# echo "$name"
# echo "${path}"
# echo "${dir}"

# MANAGER FUNCTIONS

execute_terminal_C() {
	cd $1

	case $5 in
		/usr/bin/gnome-session*)
			gnome-terminal --title="Run Code C" --working-directory="$1" --command="bash"
			--tab --command="cc -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
		/usr/bin/xfce4-session*)
			xfce4-terminal --title="Run Code C" --working-directory="$1"
			--command="bash" --tab --command="cc -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
		/usr/bin/mate-session*)
			mate-terminal --title="Run Code C" --working-directory="$1"
			--command="bash" --tab --command="cc -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
	esac
}


execute_code_c() {
	cd $1
	cc -c $2
	cc -o $3 $2
	echo "Run C Code"
	./$3
	$SHELL
	echo " "
	echo "Termino la ejecucion"
	rm -rf *.o
}

execute_terminal_CPP() {
	cd $1

	case $5 in
		/usr/bin/gnome-session*)
			gnome-terminal --title="Run Code CPP" --working-directory="$1" --command="bash"
			--tab --command="g++ -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
		/usr/bin/xfce4-session*)
			xfce4-terminal --title="Run Code CPP" --working-directory="$1"
			--command="bash" --tab --command="g++ -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
		/usr/bin/mate-session*)
			mate-terminal --title="Run Code CPP" --working-directory="$1"
			--command="bash" --tab --command="g++ -o $2 $3 $4" --tab --command="./$2" --tab --command="Termino.. la ejecucion"
		;;
	esac
}

execute_code_CPP() {
	cd $1
	g++ -c $2
	g++ -o $3 $2
	echo "Run CPP Code"
	./$3
	$SHELL
	echo " "
	echo "Termino la ejecucion"
	rm -rf *.o
}


# RUNNING MODULES

case ${type} in
	text/x-java)
		zenity --question --window-icon="icon/compiler_icon.png" --title="Compilacion de JAVA" --text="Desea correr el programa $name" --ok-label="SI" --cancel-label="NO"
		if [ $? == 0 ]; then
			echo "RUN JAVA CODE"
			cd "$dir"
			java $name
			$SHELL
			echo "\n"
			echo "terminado..."
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --title="SALIENDO" --text="SALIDA"
			break
		fi
	;;
	text/x-c++src)
		cd "$dir"
		zenity --question --window-icon="icon/compiler_icon.png" --title="Compilar archivo C++" --text="Desea introducir nombre a su ejecutable?" --ok-label="Continuar" --default-cancel
		if [ $? == 0 ]; then
			file=$(zenity --entry --text="Introduce el nombre")
			if [ -z $file ]; then
				zenity --warning --window-icon="icon/compiler_icon.png" --text="No se ha seleccionado llenado el campo se pondra $out por defecto"
				zenity --question --window-icon="icon/compiler_icon.png" --title="Añadir Flags al compilador" --text="SU FICHERO NECESITA ALGUN ADICIONAL" --ok-label="SI" --cancel-label="NO"
				if [ $? == 0 ]; then
					flags=$(zenity --entry --title="Añadiendo flags al compilador" --text="introduce los flasgs necesarios para compilar")
					if [ -z $flags ]; then
						zenity --warning --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="No hay flags"
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name " --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							execute_code_CPP $dir $name $out
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					else
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name  con los $flags ?" --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							session=$(ls /usr/bin/*session*)
							execute_terminal_CPP  $dir $out $name $flags $session
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					fi
				else
					zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name ?" --ok-label="SI" --cancel-label="NO"
					if [ $? == 0 ]; then
						execute_code_CPP $dir $name $out
						
					else
						zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
						rm -rf *.o
						break
					fi
				fi
			else
				zenity --question --window-icon="icon/compiler_icon.png" --title="Confirmacion" --text="ESTA SEGURO DEL NOMBRE $file" --ok-label="OK" --cancel-label="NO"
				if [ $? == 0 ]; then
					zenity --question --window-icon="icon/compiler_icon.png" --title="Añadir Flags al compilador" --text="SU FICHERO NECESITA ALGUN ADICIONAL" --ok-label="SI" --cancel-label="NO"
					if [ $? == 0 ]; then
						flags=$(zenity --entry --title="Añadiendo flags al compilador" --text="introduce los flasgs necesarios para compilar")
						if [ -z $flags ]; then
							zenity --warning --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="No hay flags"
							zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file " --ok-label="SI" --cancel-label="NO"
								if [ $? == 0 ]; then
									execute_code_CPP $dir $name $file
									
								else
									zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
									rm -rf *.o
									break
								fi
						else
							zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file con los $flags ?" --ok-label="SI" --cancel-label="NO"
							if [ $? == 0 ]; then
								session=$(ls /usr/bin/*session*)
								execute_terminal_CPP $dir $file $name $flags $session
								
							else
								zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
								rm -rf *.o
								break
							fi
						fi
					else
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file ?" --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							execute_code_CPP $dir $name $file
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					fi
				else
					zenity --warning --window-icon="icon/compiler_icon.png" --title="ERROR SALIDA" --text="NO DESEA COMPILAR"
					rm -rf *.o
					break
				fi
			fi
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --text="Cerrando"
			break
		fi
	;;
	text/x-csrc)
		cd "$dir"
		zenity --question --window-icon="icon/compiler_icon.png" --title="Compilar archivo C" --text="Desea introducir nombre a su ejecutable?" --ok-label="Continuar" --default-cancel
		if [ $? == 0 ]; then
			file=$(zenity --entry --text="Introduce el nombre")
			if [ -z $file ]; then
				zenity --warning --window-icon="icon/compiler_icon.png" --text="No se ha seleccionado llenado el campo se pondra $out por defecto"
				zenity --question --window-icon="icon/compiler_icon.png" --title="Añadir Flags al compilador" --text="SU FICHERO NECESITA ALGUN ADICIONAL" --ok-label="SI" --cancel-label="NO"
				if [ $? == 0 ]; then
					flags=$(zenity --entry --title="Añadiendo flags al compilador" --text="introduce los flasgs necesarios para compilar")
					if [ -z $flags ]; then
						zenity --warning --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="No hay flags"
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name " --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							execute_code_c $dir $name $out
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					else
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name  con los $flags ?" --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							session=$(ls /usr/bin/*session*)
							echo ${session}
							execute_terminal_C  $dir $out $name $flags $session
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					fi
				else
					zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $name ?" --ok-label="SI" --cancel-label="NO"
					if [ $? == 0 ]; then
						execute_code_c $dir $name $out
						
					else
						zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
						rm -rf *.o
						break
					fi
				fi
			else
				zenity --question --window-icon="icon/compiler_icon.png" --title="Confirmacion" --text="ESTA SEGURO DEL NOMBRE $file" --ok-label="OK" --cancel-label="NO"
				if [ $? == 0 ]; then
					zenity --question --window-icon="icon/compiler_icon.png" --title="Añadir Flags al compilador" --text="SU FICHERO NECESITA ALGUN ADICIONAL" --ok-label="SI" --cancel-label="NO"
					if [ $? == 0 ]; then
						flags=$(zenity --entry --title="Añadiendo flags al compilador" --text="introduce los flasgs necesarios para compilar")
						if [ -z $flags ]; then
							zenity --warning --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="No hay flags"
							zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file " --ok-label="SI" --cancel-label="NO"
							if [ $? == 0 ]; then
								execute_code_c $dir $name $file
								
							else
								zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
								rm -rf *.o
								break
							fi
						else
							zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file  con los $flags ?" --ok-label="SI" --cancel-label="NO"
							if [ $? == 0 ]; then
								session=$(ls /usr/bin/*session*)
								echo ${session}
								execute_terminal_C $dir $file $name $flags $session
								
							else
								zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
								rm -rf *.o
								break
							fi
						fi
					else
						zenity --question --window-icon="icon/compiler_icon.png" --title="CONFIRMACION" --text="Desea Compilar $file ?" --ok-label="SI" --cancel-label="NO"
						if [ $? == 0 ]; then
							execute_code_c $dir $name $file
							
						else
							zenity --warning --window-icon="icon/compiler_icon.png" --title="ADIOS" --text="Saliendo"
							rm -rf *.o
							break
						fi
					fi
				else
					zenity --warning --window-icon="icon/compiler_icon.png" --title="ERROR SALIDA" --text="NO DESEA COMPILAR"
					break
				fi
			fi
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --text="Cerrando"
			break
		fi
	;;
	text/x-python)
		zenity --question --window-icon="icon/compiler_icon.png" --title="Ejecucion de Python 2" --text="Deseas ejecutar el script $name" --ok-label="SI" --cancel-label="NO"
		if [ $? == 0 ]; then
			echo "RUN PYTHON SCRIPT"
			cd "$dir"
			python2 $name
			echo "\n"
			echo "terminado"
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --title="SALIDA" --text="SALIENDO"
			break
		fi
	;;
	text/x-python3)
		zenity --question --window-icon="icon/compiler_icon.png" --title="Ejecucion de Python 3" --text="Deseas ejecutar el script $name" --ok-label="SI" --cancel-label="NO"
		if [ $? == 0 ]; then
			echo "RUN PYTHON3 SCRIPT"
			cd "$dir"
			python $name
			echo "\n"
			echo "terminado"
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --title="SALIDA" --text="SALIENDO"
			break
		fi
	;;
	application/x-shellscript)
		zenity --question --window-icon="icon/compiler_icon.png" --title="Ejecucion de SHELLSCRIPT" --text="DESEA CORRER EL SCRIPT" --ok-label="SI" --cancel-label="NO"
		if [ $? == 0 ]; then
			echo "Running Shell script Code"
			chmod +x $name
			./$name
			$SHELL
		else
			zenity --warning --window-icon="icon/compiler_icon.png" --title="SALIENDO" --text="SALIENDO"
			break
		fi
	;;
	text/html)
		zenity --question --window-icon="icon/compiler_icon.png" --title="Ejecucion de HTML" --text="Que Navegador desea usar?" --ok-label="Firefox" --cancel-label="Chromium"
		if [ $? == 0 ]; then
			firefox $name
		else
			chromium $name
		fi
		break
	;;
	text/plain)
		zenity --warning --window-icon="icon/compiler_icon.png" --title="ALERTA" --text="DOCUMENTO NO SOPORTADO"
	;;
esac

