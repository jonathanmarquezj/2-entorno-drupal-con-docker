# entorno-drupal-con-docker
## Directorios necesarios <br/>
Tendremos que crear primero los directorios necesarios para el proyecto, de tal manera que donde descargamos el repositorio tendremos que crear las siguientes carpetas. <br/>
<code>
mkdir -p volumen/mysql
</code><br/>
<code>
mkdir volumen/files
</code><br/>
<br/>
De tal manera que quedario la estructura. 

.<br/>
├── docker-compose.yaml<br/>
├── drupal<br/>
│   └── Dockerfile<br/>
├── nginx<br/>
│   ├── assets<br/>
│   │   ├── bin<br/>
│   │   │   ├── docker-entrypoint.sh<br/>
│   │   │   └── entrypoint.functions<br/>
│   │   └── templates<br/>
│   │       └── nginx.conf.tmpl<br/>
│   └── Dockerfile<br/>
├── opt<br/>
│   └── data<br/>
│       └── proyectoPrueba<br/>
│           ├── files<br/>
│           └── mysql<br/>
└── README.md<br/>

## Cargar variables necesarias <br>
Copiamos el contenido del archivo ".env" en la terminal.

## Para crear las imagenes necesarios <br/>
Para crear las imagens necesarios nos dirigimos al directorio "drupal" y ejecutamos el siguiente comando.<br>
<code>docker build -t "jonathan-drupal" .</code>

Lo mismo hacemos en el directorio "nginx".<br/>
<code>docker build -t "jonathan-nginx" .</code>

## Iniciar el entorno <br/>
Para iniciar el entorno pondremos el siguiente comando.<br/>
<code>
  docker-compose up -d
</code>
<br>
Comprobamos que funciona con el siguiente comando. <br/>
<code>docker-compose ps </code>

Y nos tendrea que salir algo como esto <br/>
| Name | Command | State | Ports |
|---|---|---|---|
| drupal | docker-php-entrypoint php- ... | Up | 9000/tcp |
| mysql | docker-entrypoint.sh mysqld | Up | 3306/tcp |
| nginx | /bin/bash /assets/bin/dock ... | Up | 0.0.0.0:443->443/tcp,:::443->443/tcp, 0.0.0.0:80->80/tcp,:::80->80/tcp |

Y si nos dirigimos al "localhost" en mi caso, en el caso de que modifiqueis el "docker-compose.yaml" tendreis que poner el correspondiente. Nos aparecera la web de drupal para comenzar la instalación.


