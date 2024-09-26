[Volver al indice](../../index.md)
# PR0102 - Máquinas Windows en Vagrant

## Obtener SO
Lo primero que debemos hacer es obtener los SO siguiente:

- Windows Server 2019 Standard
- Windows 10

Para ello vamos a descargar las máquinas de la siguiente forma:

>Los modelos escogidos son **gusztavvargadr/windows-server-2019-standard** y **gusztavvargadr/windows-10**

Con el comando:
 ```powershell
1. vagrant box add gusztavvargadr/windows-server-2019-standard
2. vagrant box add gusztavvargadr/windows-10
  ```

  Vamos a darnos cuenta que tardará un poco en descargar pero cuando lo tengamos podremos iniciar el **Vagrantfile**

![Server2019](imagenes/Descargamaquina1.png)

## Preparación del Vagrantfile

Lo primero es iniciar con el comando ```vagrant init``` el vagrant en nuestro directorio. Esto hará que se genere el Vagrantfile que necesitamos.

![Vagrantfile](imagenes/vagrantinit.png)

> Si leemos la consola, vemos como ha generado el archivo Vagrantfile sin problema.


En este **Vagrantfile** necesitaremos configurar:
- Dos máquinas virtuales:
  - Windows Server 2019 Standard -> 4Gb de RAM y 4 cores
  - Windows 10 -> 2Gb de RAM y 2 cores
- Deberán de estar interconectadas entre sí
- Desde el host se podrá acceder a las maquinas a través de **RDP**


Como resultado de esta configuración tendríamos que tener algo parecido a lo siguiente:
```ruby
Vagrant.configure("2") do |config|
  config.vm.network "private_network" , ip: "172.16.0.0", netmask: "255.255.0.0"

  config.vm.define "Win19_Server" do |winserver|
    winserver.vm.box = "gusztavvargadr/windows-server-2019-standard"
    winserver.vm.hostname = "w19-server"
    winserver.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 4
    end
  end


  config.vm.define "Win10" do |win10|
    win10.vm.box = "gusztavvargadr/windows-10"
    win10.vm.hostname = "w10"
    win10.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
    end
  end
end
```

## RDP


Ahora que tenemos configurado el **vagrantfile**,iniciamos las maquinas

![IniciacionMaquinas](imagenes/iniciacion_maquinas.png)


Cuando nos diga que está iniciada,nos conectaremos por RDP desde el host .

Para ello lo que tenemos que hacer es lo siguiente:

1. Primero escribir el comando ```vagrant rdp [nombre de la mv]```
  
![RDP](imagenes/rdp1.png)

2. Una vez hecho esto, tendremos que introducir las credenciales:
   1. Usuario: **vagrant**
   2. Contraseña: **vagrant**

![Credenciales](imagenes/creds.png)

3.Aceptar el cuadro de sincronización y **listo**.

![RDP](imagenes/RDPfinalizado.png)