# Entorno Drupal con Docker-compose
## Preparacion del entorno
Lo primero es cargar las variables necesarias que la podemos encontrar en el ".env".

Despues creamos el directorio del proyecto.
<pre>
mkdir -p $PROJECTS_DIR
</pre>

Despues tendremos que clonar el repositorio en el direcotio creado para el proyecto
<pre>
git clone https://github.com/jonathanmarquezj/2-entorno-drupal-con-docker.git $PROJECT_DIR
</pre>

## Directorios necesarios
Tendremos que crear primero los directorios necesarios para el proyecto.
<pre>
mkdir $PROJECTS_DIR/volumen/mysql
mkdir $PROJECTS_DIR/volumen/files
mkdir -p $PROJECTS_DIR/backup/mysql
</pre>

## Imagenes necesarios
Para crear las imagens necesarios nos dirigimos al directorio "drupal" y ejecutamos el siguiente comando.
<pre>
cd drupal
docker build -t "jonathan-drupal" .
</pre>

Lo mismo hacemos en el directorio "nginx".
<pre>
cd nginx
docker build -t "jonathan-nginx" .
</pre>

## Explicación del entorno
- <b>Haproxy</b>: Sera el encargado de balancear la carga del puerto 80 a los nginx.
- <b>Nginx</b>: Es el servicio web, esta escalado a 2, para que el balanceador de carga funcione.
- <b>Db</b>: La base de datos para el Drupal.
- <b>Drupal con PHP-fmp</b>: Sera el servicio con PHP y tendrá la aplicación de Drupal.
- <b>Fluent-bit</b>: Es el encargado de recolectar los Log de los contenedores con los servicios.
- <b>Loki</b>: Es como el interprete para proporcionar los datos a Grafana.
- <b>Grafana</b>: Es la aplicación que se encargara de enseñar los Log de los contenedores, para entrar ponemos en el navegador "<b>localhost:3000</b>".

## Automatización con Baids
Lo primero es instalar los paquetes necesarios para poder ejecutar los Baids, accede a [aqui](https://github.com/rcmorano/baids#installation) para la instalacion.

Es tan facil como poner el siguiente codigo para la instalacion.

<pre>
curl -sSL https://raw.githubusercontent.com/rcmorano/baids/master/baids | bash -s install
</pre>

El siguiente paso es crear el enlace y recargamos los baids
<pre>
ln -fs $PROJECT_DIR/baids $HOME/.baids/functions.d/$PROJECT_NAME

baids-reload
</pre>

Para iniciar el entorno pondremos el siguiente comando.
<pre>
dev-2-entorno-drupal-con-docker.test-deploy
</pre>

Comprobamos que funciona con el siguiente comando.
<pre>
docker-compose ps
</pre>

Y nos tendrea que salir algo como esto.
| Name | Command | State | Ports |
|---|---|---|---|
| 2-entorno-drupal-con-docker_nginx_1 | /bin/bash /assets/bin/dock ... | Up | 443/tcp, 80/tcp |
| 2-entorno-drupal-con-docker_nginx_2 | /bin/bash /assets/bin/dock ... | Up | 443/tcp, 80/tcp |
| drupal | docker-php-entrypoint php- ... | Up | 9000/tcp |
| fluent-bit | /fluent-bit/bin/fluent-bit ... | Up | 92020/tcp, 0.0.0.0:24224->24224/tcp,:::24224->24224/tcp,    0.0.0.0:24224->24224/udp,:::24224->24224/udp |
| grafana | /run.sh | Up | 0.0.0.0:3000->3000/tcp,:::3000->3000/tcp |
| haproxy | docker-entrypoint.sh hapro ... | Up | 9000/tcp |
| loki | docker-php-entrypoint php- ... | Up | 0.0.0.0:80->80/tcp,:::80->80/tcp,0.0.0.0:8181->8181/tcp,:::8181->8181/tcp |
| mysql | docker-entrypoint.sh mysqld | Up | 3306/tcp |

Y si nos dirigimos al "localhost" nos aparecera la web de drupal para comenzar la instalación.

Para eliminar el entorno
<pre>
dev-2-entorno-drupal-con-docker.test-down
</pre>

Para entrar en el entorno de la DB
<pre>
dev-2-entorno-drupal-con-docker.test-mysql-shell
</pre>

Para realizar la copia de la DB
<pre>
dev-2-entorno-drupal-con-docker.test-mysql-dump-db
</pre>

Para realizar la importacion de la DB
<pre>

</pre>
