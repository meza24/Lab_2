#!/bin/bash

# Validar la presencia de los argumentos requeridos.
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso_a_monitorear> <comando_para_iniciar_proceso>"
    exit 1
fi

nombre_proceso="$1"
comando_inicio="$2"

while true; do
    # Determinar ssi el proceso está activo
    if ! pgrep -x "$nombre_proceso" > /dev/null; then
        echo "El proceso '$nombre_proceso' no esta activo."
        
        # Lanzar el proceso utilizando el comando especificado.
        $comando_inicio &
        
        echo "Proceso '$nombre_proceso' iniciado."
    fi

    # Hacer una espera antes de la siguiente verificación
    sleep 5
done

