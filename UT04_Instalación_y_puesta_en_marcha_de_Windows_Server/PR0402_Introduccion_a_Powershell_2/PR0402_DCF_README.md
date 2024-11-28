[Volver al índice](../index.md)

# PR0402: Introducción a Powershell II

## Ejercicios

### 1. Visualiza las últimas cinco entrdas del historial mostrando en cada una la hora de ejecución y el estado de ejecución

#### Comando:

```powershell
PS C:\Users\Administrador> Get-History -Count 5 | Select-Object CommandLine, StartExecutionTime, Status

```

#### Output:

```powershell
CommandLine                             StartExecutionTime                      Status
-----------                             ------------------                      ------
Measure-Command { Get-History -Count... 28/11/2024 10:11:04
Get-History | Select-Object Id, Comm... 28/11/2024 10:11:47
Get-History -Count 5 | Select-Object... 28/11/2024 10:12:05
Get-History -Count 5 | Select-Object... 28/11/2024 10:13:13
Get-History -Count 5 | Select-Object... 28/11/2024 10:13:21


PS C:\Users\Administrador>
```

### 2. Ejecutar el comando ```Get-Command``` e interrumpirlo antes de que finalice su ejecución


##### Ejecución con la detención utilizando ```Ctrl + C```

```
PS C:\Users\Administrador> Get-Command

CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Alias           Add-ProvisionedAppxPackage                         Dism
Alias           Add-WindowsFeature                                 ServerManager
Alias           Apply-WindowsUnattend                              Dism
Alias           Expand-IscsiVirtualDisk                            IscsiTarget
Alias           Flush-Volume                                       Storage
Alias           Get-ProvisionedAppxPackage                         Dism
Alias           Initialize-Volume                                  Storage
Alias           Move-SmbClient                                     SmbWitness
Alias           Remove-ProvisionedAppxPackage                      Dism
Alias           Remove-WindowsFeature                              ServerManager
Alias           Write-FileSystemCache                              Storage
Function        A:
Function        Add-BCDataCacheExtension                           BranchCache
Function        Add-DnsClientNrptRule                              DnsClient
Function        Add-DtcClusterTMMapping                            MsDtc
Function        Add-InitiatorIdToMaskingSet                        Storage
Function        Add-NetEventNetworkAdapter                         NetEventPacketCapture
PS C:\Users\Administrador>
```


Si no paramos la ejecución del comando nos mostrará TODO el listado que tiene Powershell

