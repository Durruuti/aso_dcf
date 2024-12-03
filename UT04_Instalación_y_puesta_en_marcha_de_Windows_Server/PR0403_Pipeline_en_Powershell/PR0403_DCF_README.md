[Volver al índice](../index.md)

# PR0403: Pipeline en Powershell

## Primera parte

### 1. El comando **Get-Date** muestra la fecha y hora actual.Muestra por pantalla únicamente el año.

```powershell
PS C:\WINDOWS\system32> Get-Date -Format "yyyy"
2024
PS C:\WINDOWS\system32>
```

### 2. Powershell dispone del comando ```Get-TPM```, que nos muestra información de ese módulo.Muestra por pantalla las propiedades ```TpmPresent```, ```TpmReady```, ```TpmEnabled``` y ```TpmActivated```

```powershell
PS C:\WINDOWS\system32> Get-Tpm | Format-List TpmPresent, TpmReady, TpmEnabled, TpmActivated


TpmPresent   : True
TpmReady     : True
TpmEnabled   : True
TpmActivated : True



PS C:\WINDOWS\system32>
```

## Segunda parte

### 1. Muestra por pantalla el número de ficheros y directorios que hay en ese directorio

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 | Measure-Object


Count    : 4818
Average  :
Sum      :
Maximum  :
Minimum  :
Property :
```

### 2. Los objetos devueltos por el comando anterior tienen una propiedad denominada ```Extension```. Calcula el número de ficheros en el directorio con extension **.dll**

```powershell
PS C:\WINDOWS\system32> Get-ChildItem C:\Windows\System32 -Filter *.dll | Measure-Object


Count    : 3518
Average  :
Sum      :
Maximum  :
Minimum  :
Property :



PS C:\WINDOWS\system32>
```

### 3. Muestra los ficheros del directorio con extension **.exe**