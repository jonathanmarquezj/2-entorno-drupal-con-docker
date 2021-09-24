#! /usr/bin/env bash
. funciones.sh

comprobar_carpetas_requeridas

echo "-----------------------------------------"
echo "1: Iniciar entorno."
echo ""
echo "- BASE DE DATOS -"
echo "2: Realizar copia de seguridad de la DB."
echo "3: Realizar importacion DB."
echo ""
echo "0: Salir."
echo ""

read -p "--> " seleccion_menu

echo "-----------------------------------------"

case $seleccion_menu in
    0)
        echo "Adios :)"
        exit 0
    ;;
    1) # INICIAR ENTORNO
        echo "-----------------------------------------"
        echo "            INICIANDO ENTORNO"
        echo "-----------------------------------------"
        docker-compose up -d
        exit 0
    ;;
    2) # REALIZAR COPIA
        comprobar_carpetas_copias

        echo "-----------------------------------------"
        echo "             BACKUP DE DB"
        echo "-----------------------------------------"

        TIMESTAMP=$(date +'%Y%m%d%H%M')
        docker exec mysql bash -c 'exec mysqldump --databases ${MYSQL_DATABASE} -u root -p"$MYSQL_ROOT_PASSWORD"' > ./backup/mysql/dump-${TIMESTAMP}.sql

        echo -e "[\x1b[1;32m BACKUP REALIZADO\x1b[0m ]"
        echo "Copia realizada en: ./backup/mysql/dump-${TIMESTAMP}.sql"

        exit 0
    ;;
    3) # REALIZAR IMPORTACION
        comprobar_carpetas_copias

        echo "-----------------------------------------"
        echo "            IMPORTACION DE DB"
        echo "-----------------------------------------"

        # Listamos las copias
        ls backup/mysql

        read -p "--> " archivo

        # Comprobamos de que existe el archivo
        comprobar_archivo "./backup/mysql/$archivo"

        archivo="./backup/mysql/$archivo"

        # Realizamos la importacion
        docker exec -i mysql bash -c 'exec mysql -u root -p"$MYSQL_ROOT_PASSWORD"' < $archivo

        echo -e "[\x1b[1;32m BACKUP IMPORTADO\x1b[0m ]"

        exit 0
    ;;
    *) # ORDEN NO ENCONTRADA
        echo "/////////////////////////////////////////"
        echo "                  ERROR"
        echo "/////////////////////////////////////////"

        echo -e "\x1b[1;31m LO SIENTO PERO ESA PETICION NO ES RECONOCIDA. \x1b[0m"
    ;;
esac
