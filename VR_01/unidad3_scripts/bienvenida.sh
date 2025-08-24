#!/bin/bash
# Script de bienvenida con argumentos
echo "Bienvenido, $1"
echo "Tu rol asignado es: $2"
echo "Número de argumentos recibidos: $#"
echo "Lista completa de argumentos:"
for arg in "$@"; do
    echo "-> $arg"
done
