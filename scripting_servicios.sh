#!/bin/bash

# Directorio que se va a monitorear
directorio="/home/axel/Escritorio/progra/lab_2"

# Archivo de log
archivo="/home/axel/Escritorio/progra/lab_2/scripting_servicios.log"

# Iniciar el monitoreo continuo
while true; do
    inotifywait -e create,modify,delete -r "$directorio" >> "$archivo"
done

