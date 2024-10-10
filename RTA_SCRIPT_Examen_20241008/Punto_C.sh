#!/bin/bash

echo
echo "Para ejecutar: ./Punto_B.sh  Listado_Punto_B.txt"
echo

LISTA=$1

if [[ $LISTA = '' ]] 
then
	echo "ERROR: Por favor, ingrese el listado de usuarios y grupos."
	exit
fi

MI_USUARIO=$(whoami)
MI_HASH=$(sudo cat /etc/shadow | grep $MI_USUARIO | awk -F ':' '{print $2}')

ANT_IFS=$IFS
IFS=$'\n'

for LINEA in `cat $LISTA |  grep -v ^#`
do
	# Guardo variables
	GRUPO=$(echo $LINEA | awk -F ',' '{print $2}')
	USUARIO=$(echo  $LINEA | awk -F ',' '{print $1}')
	DIRECTORIO=$(echo $LINEA | awk -F ',' '{print $3}')

	# Creo grupo
	echo "Creando grupo: $GRUPO"
	sudo groupadd $GRUPO

	# Creo usuario
	echo "Creando usuario: $USUARIO"
	sudo useradd -m -s /bin/bash -G $GRUPO -p $MI_HASH $USUARIO
	
	# Asignar owner y permisos segun corresponda
	echo "Asignando persmisos y propiedad"
	if [[ $USUARIO = 'p1c2_2024_A1' ]]
	then
		# Permisos p1c2_2024_A1
		sudo chmod 750 -R $DIRECTORIO
		sudo chown -R $USUARIO:$USUARIO $DIRECTORIO
		
		# Validar permisos y escribir archivo
		sudo su -c "whoami > /Examenes-UTN/alumno_1/validar.txt" $USUARIO
	elif [[ $USUARIO = 'p1c2_2024_A2' ]]
	then
		# Permisos p1c2_2024_A2
		sudo chmod 760 -R $DIRECTORIO
		sudo chown -R $USUARIO:$USUARIO $DIRECTORIO

		# Validar permisos y escribir archivo
		sudo su -c "whoami > /Examenes-UTN/alumno_2/validar.txt" $USUARIO
	elif [[ $USUARIO = 'p1c2_2024_A3' ]]
	then
		# Permisos p1c2_2024_A3
		sudo chmod 700 -R $DIRECTORIO
		sudo chown -R $USUARIO:$USUARIO $DIRECTORIO

		# Validar permisos y escribir archivo
		sudo su -c "whoami > /Examenes-UTN/alumno_3/validar.txt" $USUARIO
	elif [[ $USUARIO = 'p1c2_2024_P1' ]]
	then
		# Permisos p1c2_2024_P1
		sudo chmod 775 -R $DIRECTORIO
		sudo chown -R $USUARIO:$GRUPO $DIRECTORIO
		
		# Validar permisos y escribir archivo
		sudo su -c "whoami > /Examenes-UTN/profesores/validar.txt" $USUARIO
	fi
done

IFS=$ANT_IFS
