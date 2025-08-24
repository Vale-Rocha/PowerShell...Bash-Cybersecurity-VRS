#!/bin/bash
set -e  # Detener el script si ocurre un error
set -x  # Mostrar comandos antes de ejecutarlos
: '
Script: verificador.sh
Descripción: Valida si un usuario existe, verifica si un servicio está activo y muestra resultados.
Autor: Valeria R.S.
Fecha: 23 de agosto de 2025
'

validar_usuario() {
    local usuario=$1
    if id "$usuario" &>/dev/null; then
        echo "El usuario '$usuario' existe en el sistema."
    else
        echo "El usuario '$usuario' no existe."
    fi
}

verificar_servicio() {
    local servicio=$1
    if systemctl is-active --quiet "$servicio"; then
        echo "El servicio '$servicio' está activo."
    else
        echo "El servicio '$servicio' no está activo."
    fi
}

mostrar_resumen() {
    echo "Resumen de verificación completado."

}

# Validar usuario
validar_usuario "$1"
# Verificar servicio
verificar_servicio "$2"
# Mostrar resumen
mostrar_resumen

