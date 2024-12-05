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

### 3. Muestra los ficheros del directorio con extension **.exe** que tengan un tamaño superior a 50000 bytes

```powershell
Get-ChildItem C:\Windows\System32 -Filter *.exe | Where-Object Length -gt 50000
```

### 4. Muestra los ficheros que tengan extensión **.dll**, ordenados por fecha de creación y mostrando las propiedades de fecha de creación, último acceso y nombre

```powershell
Get-ChildItem C:\Windows\System32 -Filter *.dll | Select-Object CreationTime, LastAccessTime, Name |
 Sort-Object CreationTime
```

### 5. Mostrar el tamaño (`Length`) y nombre completo (`FullName`) de todos los ficheros del directorio , ordenados por tamaño en sentido descendente

```powershell
PS C:\Users\Alumno> Get-ChildItem C:\Windows\System32 -Filter *.dll | Select-Object CreationTime, LastAccessTime, Name | Sort-Object CreationTime

CreationTime        LastAccessTime      Name
------------        --------------      ----
11/06/2011 2:15:38  28/11/2024 13:38:39 mfc100fra.dll
11/06/2011 2:15:38  28/11/2024 13:38:39 mfc100ita.dll
11/06/2011 2:15:38  28/11/2024 13:38:39 mfcm100u.dll
11/06/2011 2:15:38  28/11/2024 13:38:39 mfc100cht.dll
11/06/2011 2:15:38  28/11/2024 13:38:39 mfc100deu.dll
```

### 6. Muestra el tamaño y el nombre completo de todos los ficheros del diretorio que tengan un tamaño superior a 10MB ordenados por tamaño

```powershell
Get-ChildItem C:\Windows\System32 | Where-Object Length -gt 10000000 | Sort-Object Length -Descending
```

### 7. Muestra el tamaño y el nombre completo de todos los ficheros del diretorio que tengan un tamaño superior a 10MB y extension .exe ordenados por

```powershell
PS C:\Users\Alumno> Get-ChildItem C:\Windows\System32\*.exe | ? Length -gt 10MB | sort Length -Descending


    Directorio: C:\Windows\System32


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        14/11/2024     14:07      202035632 MRT.exe
-a----        01/04/2024     18:30       60357040 OneDriveSetup.exe
-a----        26/11/2024      9:06       12744096 ntoskrnl.exe
-a----        26/11/2024      9:06       11670960 ntkrla57.exe


PS C:\Users\Alumno>
```