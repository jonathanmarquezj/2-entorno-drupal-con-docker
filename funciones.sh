#! /usr/bin/env bash

function comprobar_carpetas_requeridas {
    # Carpetas requeridas para iniciar el entorno
	usuario=$(whoami)
	carpeta_principal="./volumen"

	if [[ ! -d $carpeta_principal ]]
	then
        echo -e "\x1b[1;31m ERROR: \x1b[0m NO EXISTEN LAS CARPETAS PARA QUE EL PROGRAMA FUNCIONE CORRECTAMENTE."
        echo " - Se crearan las carpetas ./valumen/{mysql,files}"

        read -p "¿DESEA CREARLAS? [Y / n] " permiso
        if [[ $permiso == "n" || $permiso == "N" ]]
        then
            echo -e "\x1b[1;31m LO SIENTO PERO EL PROGRAMA NO FUNCIONARA SIN LAS CARPETAS CORRESPONDIENTES. \x1b[0m"
            read -p "Pulse intro para salir"
            exit 0
        fi

        mkdir -p $carpeta_principal/{files,mysql}
	fi
}

function comprobar_carpetas_copias {
    # Comprobamos si existe la carpeta donde se realizaran las copias de la DB
	usuario=$(whoami)
	carpeta_principal="./backup/mysql"

	if [[ ! -d $carpeta_principal ]]
	then
        echo -e "\x1b[1;31m ERROR: \x1b[0m NO EXISTEN LAS CARPETAS PARA QUE EL PROGRAMA FUNCIONE CORRECTAMENTE."
        echo " - Se crearan las carpetas ./backup/mysql"

        read -p "¿DESEA CREARLAS? [Y / n] " permiso
        if [[ $permiso == "n" || $permiso == "N" ]]
        then
            echo -e "\x1b[1;31m LO SIENTO PERO NO SE PUEDE REALIZAR LAS COPIAS SIN LA CARPETA CORRESPONDIENTE. \x1b[0m"
            read -p "Pulse intro para salir"
            exit 0
        fi

        mkdir -p $carpeta_principal
	fi
}

function comprobar_archivo {
	#METODO DE EJECUCION
	#comprobar_archivo $archivo
    if [[ ! -f $1 ]]
	then
        echo -e "\x1b[1;31m EL ARCHIVO NO EXISTE. \x1b[0m"
        exit 0
	fi
}