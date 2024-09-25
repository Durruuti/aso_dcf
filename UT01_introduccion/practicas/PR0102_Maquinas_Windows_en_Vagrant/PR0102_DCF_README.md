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

  Vamos a darnos cuenta que tardará un poco en descargar pero cuando lo tengamos podremos iniciar la maquina en el directorio

![Server2019](imagenes/Descargamaquina1.png)