[Volver al índice](../index.md)

# PR0404: Administración remota del servidor

## Configuración en WS2019-Interfaz

Metemos a los dos servidores core en el trustedhosts de winrm

```powershell
PS C:\Users\Administrador> set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.25.1.16,172.25.1.19"
```

Comprobamos que están permitidos en el trustedhosts

```powershell
PS C:\Users\Administrador> winrm get winrm/config/client
Client
    NetworkDelayms = 5000
    URLPrefix = wsman
    AllowUnencrypted = false
    Auth
        Basic = true
        Digest = true
        Kerberos = true
        Negotiate = true
        Certificate = true
        CredSSP = false
    DefaultPorts
        HTTP = 5985
        HTTPS = 5986
    TrustedHosts = 172.25.1.16,172.25.1.19

PS C:\Users\Administrador>
```

Comprobamos que podemos conectarnos a ambos servidores desde el WS2019-Interfaz

Conexión a 2016-Core

```powershell
PS C:\Users\Administrador> Enter-PSSession -ComputerName 172.25.1.16 -Credential (Get-Credential)

cmdlet Get-Credential en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
Credential
[172.25.1.16]: PS C:\Users\Administrador\Documents>
```

Conexión a 2019-Core

```powershell
PS C:\Users\Administrador> Enter-PSSession -ComputerName 172.25.1.19 -Credential (Get-Credential)

cmdlet Get-Credential en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
Credential
[172.25.1.19]: PS C:\Users\Administrador\Documents> exit
PS C:\Users\Administrador>
```




Creación usuario a través de powershell en remoto en ambos cores

CORE-2016

```powershell
[172.25.1.16]: PS C:\Users\Administrador\Documents> $Password =Read-Host -AsSecureString
ADVERTENCIA: Un script o una aplicación del equipo remoto 172.25.1.16 está solicitando leer una
línea de forma segura. Proporcione la información confidencial (como sus credenciales) solamente
si confía en el equipo remoto y en la aplicación o el script que la solicita.
************
[172.25.1.16]: PS C:\Users\Administrador\Documents> New-LocalUser "dcf" -Password $Password -FullName "Administrador-dcf" -Description "Usuario de dcf"

Name Enabled Description
---- ------- -----------
dcf  True    Usuario de dcf


[172.25.1.16]: PS C:\Users\Administrador\Documents>
```
Ahora le damos permisos de administración

```powershell
[172.25.1.16]: PS C:\Users\Administrador\Documents> Add-LocalGroupMember -Group "Administradores" -Member "dcf"
```


CORE-2019
Repetimos los mismos pasos que en el 2016-CORE

```powershell
PS C:\Users\Administrador> Enter-PSSession -ComputerName 172.25.1.19 -Credential (Get-Credential)

cmdlet Get-Credential en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
Credential
[172.25.1.19]: PS C:\Users\Administrador\Documents> $Password =Read-Host -AsSecureString
ADVERTENCIA: Un script o una aplicación del equipo remoto 172.25.1.19 está solicitando leer una
línea de forma segura. Proporcione la información confidencial (como sus credenciales) solamente
si confía en el equipo remoto y en la aplicación o el script que la solicita.
************
[172.25.1.19]: PS C:\Users\Administrador\Documents> New-LocalUser "dcf" -Password $Password -FullName "Administrador-dcf" -Description "Usuario de dcf"

Name Enabled Description
---- ------- -----------
dcf  True    Usuario de dcf


[172.25.1.19]: PS C:\Users\Administrador\Documents> Add-LocalGroupMember -Group "Administradores" -Member "dcf"
[172.25.1.19]: PS C:\Users\Administrador\Documents>
```

Configuración acceso remoto a través de https

Creamos los certificados en los cores

Nos conectamos como el usuario dcf y ya empezamos a hacer la configuracion 

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> New-SelfSignedCertificate -DnsName "172.25.1.16" `
>> -CertStoreLocation Cert:\LocalMachine\My `
>> -KeyLength 2048


   PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\My

Thumbprint                                Subject
----------                                -------
CC37444770BC935F9ED6B353545C8D563D2A930D  CN=172.25.1.16


[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Averiguamos el hash

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> Get-ChildItem -Path Cert:\LocalMachine\My\


   PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\My

Thumbprint                                Subject
----------                                -------
CC37444770BC935F9ED6B353545C8D563D2A930D  CN=172.25.1.16


[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Creamos el Listener con el hash

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> New-Item `
>> -Path WSMan:\localhost\Listener `
>> -Transport HTTPS `
>> -Address * `
>> -CertificateThumbPrint CC37444770BC935F9ED6B353545C8D563D2A930D

Crea un nuevo elemento Listener.
Este comando crea un nuevo elemento Listener.

¿Desea continuar?
[S] Sí  [N] No  [?] Ayuda (el valor predeterminado es "S"): S


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Listener

Type            Keys                                Name
----            ----                                ----
Container       {Transport=HTTPS, Address=*}        Listener_1305953032


[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Abrimos el puerto 5986

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> netsh advfirewall firewall add rule name="WinRM HTTPS" protocol=TCP dir=in localport=5986 action=allow
Aceptar

[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Ahora tenemos que exportar e importar el certificado SSL

Exportamos a C: el certificado

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> Export-Certificate `
>> -Cert Cert:\LocalMachine\My\CC37444770BC935F9ED6B353545C8D563D2A930D `
>> -FilePath C:\\servercert.cer


    Directorio: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       12/12/2024      9:31            802 servercert.cer


[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Creamos una carpeta compartida y ejecutamos el siguiente comando

En mi caso he montado en z: la carpeta compartida, seguidamente he copiado dentro el archivo y ya lo tenemos en nuestro servidor con interfaz

```powershell
[172.25.1.16]: PS C:\Users\dcf\Documents> net use z: \\172.25.0.19\compartida /user:Administrador Villabalter1
Se ha completado el comando correctamente.

[172.25.1.16]: PS C:\Users\dcf\Documents> ls
[172.25.1.16]: PS C:\Users\dcf\Documents> dir
[172.25.1.16]: PS C:\Users\dcf\Documents> cd z:
[172.25.1.16]: PS z:\> dir
[172.25.1.16]: PS z:\> c
El término 'c' no se reconoce como nombre de un cmdlet, función, archivo de script o programa
ejecutable. Compruebe si escribió correctamente el nombre o, si incluyó una ruta de acceso,
compruebe que dicha ruta es correcta e inténtelo de nuevo.
    + CategoryInfo          : ObjectNotFound: (c:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

[172.25.1.16]: PS z:\> c:
[172.25.1.16]: PS C:\Users\dcf\Documents> Copy-Item -Path C:\servercert.cer -Destination Z:\
[172.25.1.16]: PS C:\Users\dcf\Documents>
```

Como vemos, ya tenemos el certificado en el servidor con GUI

```powershell
PS C:\compartida> dir


    Directorio: C:\compartida


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       12/12/2024      9:31            802 servercert.cer


PS C:\compartida> whoami.exe
dcf-2019\administrador
PS C:\compartida>
```

Importamos el certificado

```powershell

PS C:\compartida> Import-Certificate -FilePath C:\compartida\servercert.cer -CertStoreLocation Cert:\LocalMachine\Root\


   PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\Root

Thumbprint                                Subject
----------                                -------
CC37444770BC935F9ED6B353545C8D563D2A930D  CN=172.25.1.16


PS C:\compartida>
```

Comprobamos por último que hemos realizado bien la conexión ssl

```powershell
PS C:\Users\Administrador> Enter-PSSession -ComputerName 172.25.1.16 -Credential (Get-Credential) -UseSSL

cmdlet Get-Credential en la posición 1 de la canalización de comandos
Proporcione valores para los parámetros siguientes:
Credential
[172.25.1.16]: PS C:\Users\dcf\Documents>

```

Configuración remota con WAC (Windows Admin Center)
Lo primero es instalarlo en el Windows server con interfaz

