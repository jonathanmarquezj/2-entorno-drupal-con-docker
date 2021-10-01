#!/bin/bash


# Shell para entrar en mysql
function dev-2-entorno-drupal-con-docker.test-mysql-shell() {

  docker exec -ti mysql /bin/bash

}

# Desplegar el entorno
function dev-2-entorno-drupal-con-docker.test-deploy() {
  
  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml up -d

}

# Eliminar el entorno
function dev-2-entorno-drupal-con-docker.test-down() {

  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml down

}

# Backup
function dev-2-entorno-drupal-con-docker.test-mysql-dump-db() {

    TIMESTAMP=$(date +'%Y%m%d%H%M')
    docker exec mysql bash -c 'exec mysqldump --databases ${MYSQL_DATABASE} -u root -p"$MYSQL_ROOT_PASSWORD"' > $PROJECT_DIR/backup/mysql/dump-${TIMESTAMP}.sql

    echo -e "[\x1b[1;32m BACKUP REALIZADO\x1b[0m ]"
    echo "Copia realizada en: $PROJECT_DIR/backup/mysql/dump-${TIMESTAMP}.sql"

}

# Importación de db
function dev-2-entorno-drupal-con-docker.test-mysql-import-db() {

  [ ! -n "$1" ] && echo -e "[!] sql dump not found \n
Usage: dev-2-entorno-drupal-con-docker.test-mysql-import-db $PROJECT_DIR/backup/mysql/dump.sql" && return
  
  SQL_DUMP=$1

  docker exec -i mysql bash -c 'exec mysql -u root -p"$MYSQL_ROOT_PASSWORD"' < $SQL_DUMP

  echo -e "[\x1b[1;32m IMPORTACION REALIZADA\x1b[0m ]"

}