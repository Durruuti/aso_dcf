[Volver al índice](../index.md)

# Introducción a Powershell

## Ejercicios

### 1. Obtén ejemplos de utilización del comando ```Get-LocalUser```

Este comando obtiene las cuentas de usuario locales.

Podemos realizar 3 ejemplos de utilización de este comando

#### Parámetros

```-Name``` : Se escribe el nombre del usuario, además podemos utilizar el carácter comodín

```-SID``` : Introduciriamos el SID del usuario que queremos consultar


#### Ejemplo 1: Obtener una cuenta con su nombre

Este ejemplo nos lista si el usuario está habilitado y su respectiva descripción

```powershell
PS C:\WINDOWS\system32> Get-LocalUser -Name "Alumno"

Name   Enabled Description
----   ------- -----------
Alumno True


PS C:\WINDOWS\system32>
```

#### Ejemplo 2: Obtener una cuenta conectada a una cuenta de Microsoft

Podremos obtener, a través del coreo electronico de la cuenta de Microsoft, un usuario de nuestro equipo

```powershell


PS C:\WINDOWS\system32> Get-LocalUser -Name "MicrosoftAccount\diego.calfer.3@educa.jcyl.es"
Get-LocalUser : No se encontró el usuario MicrosoftAccount\diego.calfer.3@educa.jcyl.es.
En línea: 1 Carácter: 1
+ Get-LocalUser -Name "MicrosoftAccount\diego.calfer.3@educa.jcyl.es"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (MicrosoftAccoun...3@educa.jcyl.es:String) [Get-LocalUser], UserNotFound
   Exception
    + FullyQualifiedErrorId : UserNotFound,Microsoft.PowerShell.Commands.GetLocalUserCommand

PS C:\WINDOWS\system32>

```

Aparece error porque aqui en el host de clase no tengo vinculada ninguna cuenta con ningún usuario local.

#### Ejemplo 3: Obtener una cuenta a través de un SID

Primero sacamos el SID del usuario con el comando: 

```powershell
PS C:\WINDOWS\system32> whoami /user

INFORMACIÓN DE USUARIO
----------------------

Nombre de usuario     SID
===================== ==============================================
ed24016481p059\alumno S-1-5-21-1748662432-2652827518-3551581417-1022
PS C:\WINDOWS\system32>

```

Una vez que lo tenemos , lo copiamos y introducimos el comando de ```Get-LocalUser```

```powershell
PS C:\WINDOWS\system32> Get-LocalUser -SID S-1-5-21-1748662432-2652827518-3551581417-1022

Name   Enabled Description
----   ------- -----------
Alumno True


PS C:\WINDOWS\system32>
```


### 2. Obtén un listado de todos los comandos relacionados con ```LocalUser```

Si introducimos el siguiente comando podremos ver todos los Cmdlet relacionados con LocalUser

```powershell
PS C:\WINDOWS\system32> Get-Command *LocalUser*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-LocalUser                                  1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          Enable-LocalUser                                   1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          Get-LocalUser                                      1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          New-LocalUser                                      1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          Remove-LocalUser                                   1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          Rename-LocalUser                                   1.0.0.0    Microsoft.PowerShell.LocalAccounts
Cmdlet          Set-LocalUser                                      1.0.0.0    Microsoft.PowerShell.LocalAccounts


PS C:\WINDOWS\system32>
```

### 3. Mostrar en el navegador la ayuda de ```Get-Localuser```

Para mostrar la ayuda en el navegador de cualquier comando introduciremos el siguiente comando

```powershell
PS C:\WINDOWS\system32> get-help -Name Get-LocalUser -online
PS C:\WINDOWS\system32>
```

### 4. Averiguar que uso tiene ```Set-Content``` 

El Cmdlet ```Set-Content``` es utilizado para reemplazar texto en archivos de texto.

Con el siguiente ejemplo podemos ver lo fácil que es sustituir texto en archivos.

```powershell
Get-ChildItem -Path .\Test*.txt

Test1.txt
Test2.txt
Test3.txt

Set-Content -Path .\Test*.txt -Value 'Hello, World'
Get-Content -Path .\Test*.txt

Hello, World
Hello, World
Hello, World
```

También lo podemos utilizar para crear un archivo de 0 y escribir contenido en el

```powershell
Set-Content -Path .\DateTime.txt -Value (Get-Date)
Get-Content -Path .\DateTime.txt

1/30/2019 09:55:08
```

> Estos dos ejemplos los he sacado de [Documentación Windows Powershell : Set-Content](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.management/set-content?view=powershell-7.4&viewFallbackFrom=powershell-6)


### 5. Tres formas de mostrar un comando utilizado anteriormente durante la sesión

#### Utilizar la flecha hacia arriba del teclado

Para rebuscar un comando que hemos utilizado previamente duranete la misma sesión podemos utilizar la "flecha hacia arriba" para navegar por cada uno de los comandos que hemos utilizado en orden

#### Get-History y Invoke-History

Podemos visualizar el historial con el comando ```Get-History``` de la siguiente manera

```powershell
PS C:\WINDOWS\system32> Get-history

  Id CommandLine
  -- -----------
   1 winrm quickconfig
   2 winrm get winrm/config/client
   3 set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.25.0.20"
   4 winrm get winrm/config/client
   5 Invoke-Command `...
   6 Invoke-Command `...
   7 Enter-PSSession `...
   8 New-NetFirewallRule `...
   9 Enter-PSSession `...
  10 Enable-PSRemoting -Force
  11 ping 172.25.0.20
  12 Enter-PSSession `...
  13 winrm get winrm/config/client
  14 Enter-PSSession `...
  15 ping 172.25.0.20
  16 ipconfig
  17 ping 172.25.0.20
  18 Enter-PSSession `...
  19 Get-LocalUser
  20 Get-LocalUser -Name "Alumno"
  21 Get-LocalUser -Name "MicrosoftAccount\diego.calfer.3@educa.jcyl.es"
  22 whoami /Alumno
  23 whoami /user
  24 Get-LocalUser -SID S-1-5-21-1748662432-2652827518-3551581417-1022
  25 Get-Command LocalUser
  26 Get-Command *LocalUser*
  27 get-help -Name Get-Command -online
  28 get-help -Name Get-LocalUser -online
  29 get-help -Name Set-Content -online
  30 get-help -Name Set-Content -online


PS C:\WINDOWS\system32>
```

Ahora que ya tenemos el historial, vamos a escoger por ejemplo el 16

```powershell

PS C:\WINDOWS\system32> Invoke-History 16
ipconfig

Configuración IP de Windows


Adaptador de Ethernet Ethernet:

   Sufijo DNS específico para la conexión. . : InformaticaSanAndres
   Vínculo: dirección IPv6 local. . . : fe80::a769:d866:71a6:c306%3
   Dirección IPv4. . . . . . . . . . . . . . : 192.168.110.28
   Máscara de subred . . . . . . . . . . . . : 255.255.254.0
   Puerta de enlace predeterminada . . . . . : 192.168.110.1

```

#### Utilizar 'Ctrl + R' para buscar comandos.

Esta combinacion de teclas hace lo mismo que la flecha hacia arriba, ya que recorre todos los comandos utilizados previamente.