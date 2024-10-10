#!/bin/bash

ARCHIVO="../RTA_ARCHIVOS_Examen_20241008/Filtro_Basico.txt"

# Creo el archivo en RTA_ARCHIVOS_Examen_<fecha>
touch $ARCHIVO

echo "Se creó el archivo Filtro_Basico.txt"
echo

# Inserto la info de memoria ram
cat /proc/meminfo | grep 'MemTotal' >> $ARCHIVO

echo "Se insertó la informfación de la RAM en el archivo Filtro_Basico.txt"
echo

# Inserto la info del fabricante del chassis
sudo dmidecode -t chassis | head -7 | tail -2 >> $ARCHIVO

echo "Se insertó la información del fabricante del chassis en el archivo Filtro_Basico.txt"
echo
