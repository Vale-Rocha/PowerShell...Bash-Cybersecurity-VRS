#!/bin/bash
: '
Script: escaneo_red.sh
Descripción: Realiza un escaneo de red con nmap, guarda el resultado y alerta si se detectan puertos abiertos no autorizados.
Autor: Valeria R.S.
Fecha: 31 de agosto de 2025
'
ip=$1
fecha=$(date +"%Y-%m-%d_%H-%M")
reporte="reporte_nmap_$fecha.txt"
alertas="alertas_$fecha.txt"

# Lista de puertos autorizados

puertos_autorizados=("22" "80" "443")
#El script recibirá la IP como argumento y usará la fecha para nombrar los archivos.

echo "Escaneando $ip..."
nmap -p- --open $ip > "$reporte"
echo "Reporte guardado como $reporte"
#-p- escanea todos los puertos, --open muestra solo los abiertos.

echo "Analizando puertos abiertos..."

# Extraer puertos abiertos del reporte
puertos_detectados=$(grep -Eo '^[0-9]+/tcp' "$reporte" | cut -d '/' -f1)

for puerto in $puertos_detectados; do
	autorizado=false
	for permitido in "${puertos_autorizados[@]}"; do
		if [ "$puerto" -eq "$permitido" ]; then
			autorizado=true
			break
		fi
	done

	if [ "$autorizado" = false ]; then
		echo "Puerto no autorizado detectado: $puerto" | tee -a "$alertas"
	fi
done

echo " Escaneo completado."
if [ -f "$alertas" ]; then
	echo " Se detectaron puertos no autorizados. Revisa $alertas"
else
	echo " Todos los puertos abiertos están autorizados."
fi
