#!/bin/bash

# Define la URL base
urlBase="https://transparenciachc.blob.core.windows.net/lic-da/"

# Bucle para recorrer los años y meses
for ano in {2007..2023}; do
    for mes in {1..12}; do
        # Formatea la URL con el año y el mes
        url="$urlBase$ano-$mes.zip"
        # Nombre del archivo zip
        nombreArchivo="$ano-$mes.zip"
        # Ruta de descarga
        rutaDescarga="$(pwd)/$nombreArchivo"

        # Intenta descargar el archivo
        if curl -o "$rutaDescarga" "$url"; then
            echo "Descargado: $nombreArchivo"
            
            # Descomprime el archivo ZIP
            if unzip -qq "$rutaDescarga" -d "$(pwd)/lic"; then
                echo "Descomprimido: $nombreArchivo"
                # Elimina el archivo ZIP después de la descompresión exitosa
                rm -f "$rutaDescarga"
                echo "Archivo ZIP eliminado: $nombreArchivo"
            else
                echo "Error al descomprimir $nombreArchivo"
            fi
        else
            echo "Error al descargar $nombreArchivo"
        fi
    done
done
