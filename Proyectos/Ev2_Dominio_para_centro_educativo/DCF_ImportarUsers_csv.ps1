<#
    .DESCRIPTION
    Importa usuarios en Active Directory desde un archivo .csv de manera optimizada.
    .NOTAS
    Escrito por: Diego Calles Fernández
    Optimizado por: ChatGPT
    .REFERENCIAS
    https://www.alitajran.com/import-ad-users-from-csv-powershell/
#>

# Definición de localización del archivo CSV e importación de datos
$ArchivoCSV = "C:\temporal\alumnos.csv"

# Verificar si el archivo CSV existe
if (!(Test-Path $ArchivoCSV)) {
    Write-Error "El archivo CSV no existe en la ruta especificada: $ArchivoCSV"
    exit
}

# Importar usuarios desde el CSV
$Usuarios = Import-Csv $ArchivoCSV -Delimiter ','

# Importar el módulo de Active Directory
Import-Module ActiveDirectory

# Contraseña por defecto para los usuarios
$Contra = "Villabalter1"

# Definir la estructura de OUs en un Hash Table
$baseOU = "OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu"
$OUHashTable = @{
    "ASIR|Primero"  = "OU=Primero,OU=ASIR,$baseOU"
    "ASIR|Segundo"  = "OU=Segundo,OU=ASIR,$baseOU"
    "SMR|Primero"   = "OU=Primero,OU=SMR,$baseOU"
    "SMR|Segundo"   = "OU=Segundo,OU=SMR,$baseOU"
    "DAM|Primero"   = "OU=Primero,OU=DAM,$baseOU"
    "DAM|Segundo"   = "OU=Segundo,OU=DAM,$baseOU"
    "DAW|Primero"   = "OU=Primero,OU=DAW,$baseOU"
    "DAW|Segundo"   = "OU=Segundo,OU=DAW,$baseOU"
}

# Salida de depuración para verificar los usuarios importados
Write-Output "Usuarios importados: $($Usuarios.Count)"

foreach ($Usuario in $Usuarios) {
    # Validación de campos necesarios
    if (-not ($Usuario.Nombre -and $Usuario."Primer Apellido" -and $Usuario."Segundo Apellido" -and $Usuario.Ciclo -and $Usuario.Curso)) {
        Write-Warning "El usuario tiene datos incompletos: $($Usuario | Out-String)"
        continue
    }

    # Limpiar y normalizar datos
    $nombre = $Usuario.Nombre.Trim()
    $apellido1 = $Usuario."Primer Apellido".Trim()
    $apellido2 = $Usuario."Segundo Apellido".Trim()
    $ciclo = $Usuario.Ciclo.Trim().ToUpper()   
    $curso = $Usuario.Curso.Trim().ToLower()   

    # Mostrar los valores para depuración
    Write-Output "Ciclo: $ciclo, Curso: $curso"

    # Generar la clave para el HashTable
    $OUKey = "$ciclo|$curso"

    # Verificar si la clave está en el HashTable
    if ($OUHashTable.ContainsKey($OUKey)) {
        $OU = $OUHashTable[$OUKey]
        Write-Output "Clave encontrada en el HashTable: $OU"
    } else {
        Write-Warning "Clave '$OUKey' no encontrada en el HashTable. Se asignará a la OU base."
        $OU = $baseOU
    }

    Write-Output "Asignando a usuario $nombre la OU: $OU"  # Depuración

    # Verificar si la OU realmente existe en el dominio
    if (-not (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OU} -ErrorAction SilentlyContinue)) {
        Write-Error "La OU $OU no existe en Active Directory. No se puede asignar el usuario."
        continue
    }

    # Verificar si el usuario ya existe y generar un SamAccountName único
    $samAccountName = "$($nombre.Substring(0,1))$($apellido1)$($apellido2)"
    $contador = 1
    while (Get-ADUser -Filter { SamAccountName -eq $samAccountName } -ErrorAction SilentlyContinue) {
        $samAccountName = "$($nombre.Substring(0,1))$($apellido1)$($apellido2)$contador"
        $contador++
    }

    # Parámetros de usuario
    $NuevosParametros = @{
        Name               = "$nombre $apellido1 $apellido2"
        GivenName          = $nombre
        Surname            = $apellido1
        DisplayName        = "$nombre $apellido1 $apellido2"
        EmailAddress       = "$samAccountName@educa.jcyl.es"
        SamAccountName     = $samAccountName
        UserPrincipalName  = "$samAccountName@educa.jcyl.es"
        Path               = $OU
        AccountPassword    = (ConvertTo-SecureString $Contra -AsPlainText -Force)
        Enabled            = $true
    }

    # Intentar crear el usuario y manejar errores
    try {
        New-ADUser @NuevosParametros -ErrorAction Stop
        Write-Output "Usuario $nombre creado exitosamente con SamAccountName: $samAccountName en $OU."
    } catch {
        Write-Error "Error al crear el usuario ${samAccountName}: $($_.Exception.Message)"
    }
}
