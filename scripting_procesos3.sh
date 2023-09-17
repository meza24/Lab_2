#!/bin/bash

# Confirmar la presencia del nombre de un programa como argumento."
if [ $# -ne 1 ]; then
    echo "Uso: $0 <nombre_del_programa>"
    exit 1
fi

# Guardar el nombre del programa en una variable definida
programa="$1"
archivo_registro="registro.txt"
archivo_datos="datos.txt"

# Declarar una función para controlar el consumo de CPU y memoria
monitorear_programa() {
    while ps -p $pid > /dev/null; do
        tiempo_actual=$(date +%s)
        uso_cpu=$(ps -p $pid -o %cpu | tail -n 1)
        uso_memoria=$(ps -p $pid -o %mem | tail -n 1)
        echo "$tiempo_actual $uso_cpu $uso_memoria" >> "$archivo_datos"
        sleep 1
    done
}

# Correr el programa en segundo plano.
./$programa &
pid=$!

# Iniciar la observación en un proceso en segundo plano.
monitorear_programa &

# Esperar a que el programa finalice
wait $pid

# Crear una gráfica utilizando Gnuplot
echo "Generando gráfica..."
gnuplot <<EOF
set terminal pngcairo enhanced
set output 'grafica.png'
set xlabel 'Tiempo (segundos)'
set ylabel 'Porcentaje (%)'
set title 'Uso de CPU y Memoria'
plot '$archivo_datos' using 1:2 with lines title 'CPU', '$archivo_datos' using 1:3 with lines title 'Memoria'
EOF

echo "Se ha generado una gráfica que se guarda con el nombre grafica.png."

# Limpieza: Eliminar archivos temporales de datos
rm "$archivo_datos"

exit 0

