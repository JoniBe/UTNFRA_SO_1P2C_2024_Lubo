#!/bin/bash

# Creando estructura de directorios asimétrica

echo "Punto C - Estructuras Asimétricas"
echo

mkdir -p $HOME/Estructura_Asimetrica/{{correo,cliente}/cartas_{1..100},correo/carter_{1..10}}

echo "Se crearon los directorios en el Home del usuario"
echo

# Validar estructura
tree $HOME/Estructura_Asimetrica/ --noreport | pr -T -s'' -w 80 --column 4
