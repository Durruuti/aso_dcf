<#
    .TITULO
    Importador automático de usuarios en Powershell

    .DESCRIPCION
    Este script importa usuarios desde un archivo CSV y los crea automáticamente en Active Directory, asignándoles la Unidad Organizativa (OU) correspondiente según el ciclo y curso.

    .AUTOR
    Diego Calles Fernández
#>

# Importar módulo de Active Directory
Import-Module ActiveDirectory

# Búsqueda de archivo CSV
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$ventana = New-Object System.Windows.Forms.OpenFileDialog
$ventana.InitialDirectory = "C:\" 
$ventana.Filter = "CSV (*.csv)| *.csv"
$ventana.ShowDialog() | Out-Null
$rutacsv = $ventana.FileName

# Importar archivo en variable
if (-not [System.IO.File]::Exists($rutacsv)) {
    Write-Host "La ruta del archivo no es válida"
    Exit
}

Write-Host "Importando archivo CSV..."
$ArchivoCSV = Import-Csv -LiteralPath "$rutacsv"

# Diccionario de Ciclos y Cursos
$Ciclos = @{
    "ASIR" = @{ "Primero" = "OU=Primero,OU=ASIR,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu"; "Segundo" = "OU=Segundo,OU=ASIR,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu" }
    "DAM"  = @{ "Primero" = "OU=Primero,OU=DAM,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu"; "Segundo" = "OU=Segundo,OU=DAM,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu" }
    "DAW"  = @{ "Primero" = "OU=Primero,OU=DAW,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu"; "Segundo" = "OU=Segundo,OU=DAW,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu" }
    "SMR"  = @{ "Primero" = "OU=Primero,OU=SMR,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu"; "Segundo" = "OU=Segundo,OU=SMR,OU=Alumnos,OU=Usuarios,OU=Centro Educativo,DC=Villabalter,DC=edu" }
}

# Ruta base para HomeDirectory
$RutaBaseUsuarios = "\\SRV-MSTR\Usuarios$"

# Iterar en el CSV
foreach ($usuario in $ArchivoCSV) {
    ## Recoger el nombre y apellidos
    $Nombre = $usuario."Nombre"
    $PrimerApellido = $usuario."Primer Apellido"
    $SegundoApellido = $usuario."Segundo Apellido"

    ## Iniciales de los apellidos
    $inicPA = $PrimerApellido[0]
    $inicSA = $SegundoApellido[0]

    ## Generar el nombre de usuario
    $NombreUsuario = "$Nombre$inicPA$inicSA"

    ## Crear el UPN base
    $UPN = "$NombreUsuario@villabalter.edu"
    $SamAccountName = $NombreUsuario

    ## Verificar si el UPN ya existe
    $i = 1
    $UPNtemp = $UPN
    $SamAccountTemp = $SamAccountName

    while (Get-ADUser -Filter {UserPrincipalName -eq $UPNtemp} -ErrorAction SilentlyContinue) {
        $UPNtemp = "$NombreUsuario$i@villabalter.edu"
        $SamAccountTemp = "$NombreUsuario$i"
        $i++ 
    }

    $UPN = $UPNtemp
    $SamAccountName = $SamAccountTemp

    ## Recoger datos adicionales
    $Contra = ConvertTo-SecureString "Villabalter1" -AsPlainText -Force
    $Ciclo = $usuario."Ciclo"
    $Curso = $usuario."Curso"

    # Verificación y asignación de la ruta de la OU
    if ($Ciclos.ContainsKey($Ciclo) -and $Ciclos[$Ciclo].ContainsKey($Curso)) {
        $RutaOU = $Ciclos[$Ciclo][$Curso]
        Write-Host "Creando usuario $NombreUsuario en la UO: $RutaOU"

        # Definir HomeDirectory y unidad de red
        $HomeDirectory = "$RutaBaseUsuarios\$SamAccountName"
        $HomeDrive = "H:"  # Asignar la letra de la unidad de red que quieres (A:, Z:, etc.)

        # Crear usuario en Active Directory
        New-ADUser -SamAccountName $SamAccountName `
                   -UserPrincipalName "$UPN" `
                   -Name "$Nombre $PrimerApellido $SegundoApellido" `
                   -GivenName $Nombre `
                   -Surname "$PrimerApellido $SegundoApellido" `
                   -DisplayName "$Nombre $PrimerApellido $SegundoApellido" `
                   -Path $RutaOU `
                   -AccountPassword $Contra `
                   -HomeDirectory $HomeDirectory `
                   -HomeDrive $HomeDrive `
                   -Enabled $true `
                   -ScriptPath "conecta.bat" `
                   -PassThru

        Write-Host "Usuario $SamAccountName creado correctamente con HomeDirectory en $HomeDirectory."


    } else {
        Write-Host "Error: Ciclo o curso no válido para $NombreUsuario."
    }
}
