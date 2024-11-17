[Volver a inicio](/index.md)

# PR0101: Introdducción a Vagrant
## Descarga SO
Lo primero que tenemos que hacer es buscar la distribución que se nos requiere.
En concreto Ubuntu Server 20.04

Nos dirigimos a la [web de Vagrant](https://portal.cloud.hashicorp.com/vagrant/discover) donde se guardan todas sus máquinas.

Una vez aquí, buscaremos "Ubuntu Server 20.04" y nos debería de aparecer lo siguiente:

> Yo escogeré la primera que aparece.

![Captura1](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/VagrantBoxes.png)


#### Nos vamos a la terminal y escribimos lo siguiente:

```
vagrant box add gusztavvargadr/ubuntu-server-2004-lts
```

![Captura2](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Importarmaquina.png)

Como vemos en la imagen ya tenemos descargado el sSO.

Lo siguiente que haremos será Configurar el VagrantFile.

## Configuración del VagrantFile

Iniciamos la carpeta para que nos genere el vagrantFile

```
vagrant init
```
Si hacemos un ***ls*** en la terminal veremos como nos aparece el archivo.

![ArchivoGenerado](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Vagrantfileexiste.png)

Entramos en el archivo (Vagrantfile) y lo editaremos de la siguiente forma:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/ubuntu-server-2004-lts"
  config.vm.hostname = "server-dcf"
  config.vm.define "UbuntuServer_20.04"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Ubuntu Server"
    vb.memory = 2048
    vb.cpus = 2
  end

  #Carpeta compartida
  config.vm.synced_folder "compartida" , "/data"
end
```

Ahora tendremos preparado el archivo para inicializar la mv

## Inicialización de la mv

Para arrancar la maquina introducimos en la terminal ``` vagrant up``` .
Una vez nos avise la terminal que esta ha acabado de arrancar, podremos entrar en ella utilizando el comando ```vagrant ssh```.

Una vez nos conectemos veremos como nos aparece algo similar a esto:

>Vemos en la imagen que se ha cumplido la configuración que le hemos indicado.
![Conexion](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Conexion.png)


## Comprobación carpeta sincronizada.

Para comprobar que la carpeta se ha creado perfectamente, tenemos que irnos a la carpeta raiz y ver que se ha creado.

Si creamos un archivo de texto dentro de ella, nos deberia de aparecer en windows.

![Comprobacioncarpeta](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Comprobacioncarpeta.png)
=======
[Volver a inicio](/index.md)

# PR0101: Introdducción a Vagrant
## Descarga SO
Lo primero que tenemos que hacer es buscar la distribución que se nos requiere.
En concreto Ubuntu Server 20.04

Nos dirigimos a la [web de Vagrant](https://portal.cloud.hashicorp.com/vagrant/discover) donde se guardan todas sus máquinas.

Una vez aquí, buscaremos "Ubuntu Server 20.04" y nos debería de aparecer lo siguiente:

> Yo escogeré la primera que aparece.

![Captura1](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/VagrantBoxes.png)


#### Nos vamos a la terminal y escribimos lo siguiente:

```
vagrant box add gusztavvargadr/ubuntu-server-2004-lts
```

![Captura2](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Importarmaquina.png)

Como vemos en la imagen ya tenemos descargado el sSO.

Lo siguiente que haremos será Configurar el VagrantFile.

## Configuración del VagrantFile

Iniciamos la carpeta para que nos genere el vagrantFile

```
vagrant init
```
Si hacemos un ***ls*** en la terminal veremos como nos aparece el archivo.

![ArchivoGenerado](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Vagrantfileexiste.png)

Entramos en el archivo (Vagrantfile) y lo editaremos de la siguiente forma:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/ubuntu-server-2004-lts"
  config.vm.hostname = "server-dcf"
  config.vm.define "UbuntuServer_20.04"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Ubuntu Server"
    vb.memory = 2048
    vb.cpus = 2
  end

  #Carpeta compartida
  config.vm.synced_folder "compartida" , "/data"
end
```

Ahora tendremos preparado el archivo para inicializar la mv

## Inicialización de la mv

Para arrancar la maquina introducimos en la terminal ``` vagrant up``` .
Una vez nos avise la terminal que esta ha acabado de arrancar, podremos entrar en ella utilizando el comando ```vagrant ssh```.

Una vez nos conectemos veremos como nos aparece algo similar a esto:

>Vemos en la imagen que se ha cumplido la configuración que le hemos indicado.
![Conexion](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Conexion.png)


## Comprobación carpeta sincronizada.

Para comprobar que la carpeta se ha creado perfectamente, tenemos que irnos a la carpeta raiz y ver que se ha creado.

Si creamos un archivo de texto dentro de ella, nos deberia de aparecer en windows.

![Comprobacioncarpeta](/UT01_introduccion/practicas/PR0101%20Introduccion%20a%20Vagrant/imagenes/Comprobacioncarpeta.png)