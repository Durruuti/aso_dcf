
[Volver al indice de la unidad](../../index.md)

# Conexión SSH en Varios usuarios

## 1. Preparación MV:

El **VagrantFile** que vamos a generar tendrá la siguiente configuración:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.network "public_network", ip: "172.16.0.59", netmask: "255.255.0.0"
  config.vm.hostname = "vusersdcf"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Conexion SSH varios usuarios"
    vb.memory = 3076
    vb.cpus = 2
  end
end
```

Como vemos en la configuración le hemos asignado la **public_network** de manera que mis compañero tendrán también una dirección IP en el mismo rango.

Para comprobar que tenemos conexión entre todos haremos un ping :

```bash
vagrant@vusersdcf:~$ ping 172.16.0.58
PING 172.16.0.58 (172.16.0.58) 56(84) bytes of data.
64 bytes from 172.16.0.58: icmp_seq=1 ttl=64 time=6.66 ms
64 bytes from 172.16.0.58: icmp_seq=2 ttl=64 time=2.01 ms
64 bytes from 172.16.0.58: icmp_seq=3 ttl=64 time=2.02 ms
^C
--- 172.16.0.58 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 2.011/3.564/6.661/2.189 ms
vagrant@vusersdcf:~$
```

Ahora voy a crear los usuarios para mis compañeros

```bash
vagrant@vusersdcf:~$ sudo useradd -s /bin/bash david -m
vagrant@vusersdcf:~$ sudo useradd -s /bin/bash hugo -m
vagrant@vusersdcf:~$ sudo useradd -s /bin/bash alex -m
vagrant@vusersdcf:~$ sudo passwd david
New password: 
Retype new password:
passwd: password updated successfully
vagrant@vusersdcf:~$ sudo passwd hugo
New password: 
Retype new password:
passwd: password updated successfully
vagrant@vusersdcf:~$ sudo passwd alex
New password: 
Retype new password:
passwd: password updated successfully
vagrant@vusersdcf:~$
```

Ya tendria los usuarios creados para cada usuario junto con sus contraseñas

Ahora creare la clave para mi usuario y se la pasare a mis compañeros 

1. Crear el ssh-keygen en el usuario desde donde nos vamos a conectar
2. Pasar a traves de scp la clave publica

 scp /home/diego/.ssh/id_rsa.pub 172.16.0.56:/home/diego/.ssh/

3. Copiar y sustituiy la clave publica por el authorized_keys
4. Probar el ssh y comprobar que no pide contraseña.