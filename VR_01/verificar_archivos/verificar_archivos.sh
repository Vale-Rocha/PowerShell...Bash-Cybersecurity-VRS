#!/bin/bash
#Lista de archivos a verificar
archivos=("registro.txt" "config.conf" "usuarios.csv")
contador=0
for archivo in "${archivos[0]}"; do
	if [ -e "$archivo" ]; then
		echo "$archivo existe"
		cat "$archivo"
		contador=$((contador+1))
	else
		echo "$archivo no existe"
	fi
done
echo "Total encontrados: $contador"

