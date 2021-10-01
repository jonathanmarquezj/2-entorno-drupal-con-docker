# Entorno Drupal con Docker-compose
## Directorios necesarios
Tendremos que crear primero los directorios necesarios para el proyecto, de tal manera que donde descargamos el repositorio tendremos que crear las siguientes carpetas.
<pre>
mkdir volumen/mysql
mkdir volumen/files
</pre>

## Cargar variables necesarias <br>
Copiamos el contenido del archivo ".env" en la terminal.

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

## Iniciar el entorno
Para iniciar el entorno pondremos el siguiente comando.
<pre>
docker-compose up -d
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

# Explicación del entorno
- <b>Haproxy</b>: Sera el encargado de balancear la carga del puerto 80 a los nginx.
- <b>Nginx</b>: Es el servicio web, esta escalado a 2, para que el balanceador de carga funcione.
- <b>Db</b>: La base de datos para el Drupal.
- <b>Drupal con PHP-fmp</b>: Sera el servicio con PHP y tendrá la aplicación de Drupal.
- <b>Fluent-bit</b>: Es el encargado de recolectar los Log de los contenedores con los servicios.
- <b>Loki</b>: Es como el interprete para proporcionar los datos a Grafana.
- <b>Grafana</b>: Es la aplicación que se encargara de enseñar los Log de los contenedores, para entrar ponemos en el navegador "<b>localhost:3000<b>".
