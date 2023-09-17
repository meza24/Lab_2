#!/bin/bash

# Verificamos que se haya proporcionado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 pid"
    exit 1
fi

# Obtener el PID del proceso
pid=$1

# Comprobar si el proceso existe
if ! ps -p $pid > /dev/null; then
    echo "El proceso $pid no existe en el sistema."
    exit 1
fi

# Obtener la información solicitada
nombre_del_proceso=$(ps -o comm= -p $pid)
id_del_proceso=$(ps -o ppid= -p $pid)
usuario_propietario=$(ps -o user= -p $pid)
porcentaje_del_cpu=$(ps -o %cpu= -p $pid)
consumo_de_memoria=$(ps -o %mem= -p $pid)
estado=$(ps -o stat= -p $pid)
path_del_ejecutable=$(readlink /proc/$pid/exe)

# Salida
echo "Nombre del proceso: $nombre_del_proceso"
echo "ID del proceso: $pid"
echo "ID del proceso padre: $id_del_proceso"
echo "Usuario propietario: $usuario_propietario"
echo "Porcentaje de CPU: $porcentaje_del_cpu"
echo "Consumo de memoria: $consumo_de_memoria"
echo "Estado: $estado"
echo "Ruta del ejecutable: $path_del_ejecutable"

exit 0

