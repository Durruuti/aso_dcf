[Volver al indice de la unidad](../../index.md)

# PR0301: Condicional if

# Ejercicio 1: Comprobación de número par o impar

### Código del script

```bash
#!/bin/bash

read -p "Introduce cualquier número: " n1

function  parimpar {
        if [ $((n1 % 2)) -eq 0 ];
        then
                echo "El número $n1 es par";
        else
                echo "El número $n1 es impar"
        fi
}
parimpar
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ bash ej1_script.sh
Introduce cualquier número: 2
El número 2 es par
```

# Ejercicio 2: Verificación de archivo

### Código del script

```bash
#!/bin/bash

read -p "Dame la ruta absoluta del archivo que quieras verificar: " ruta


function existeylectura {
        if [ -e "$ruta"  ];
        then
                echo "El archivo $ruta existe"
                if [ -r "$ruta" ];
                then
                        echo "Tiene permisos de lectura"
                else
                        echo "no tiene permisos de lectura"
                fi
        else
                echo "lo siento el archivo no existe"
        fi
}
existeylectura

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej2_Script.sh 
Dame la ruta absoluta del archivo que quieras verificar: /etc/network/interfaces
El archivo /etc/network/interfaces existe
Tiene permisos de lectura
```

# Ejercicio 3: Comparación de dos números

### Código del script

```bash
#!/bin/bash

read -p "Dime un primer numero " n1
read -p "Dime un segundo nuemro " n2

function comparativa {
        if [ "$n1" -gt "$n2" ];
        then
                echo "El $n1 es mayor que $n2"

        elif [ "$n1" -lt "$n2" ];
        then
                echo "El $n1 es menor que $n2"

        else
                echo "Ambos numeros son iguales"
        fi
}
comparativa
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej3_script.sh 
Dime un primer numero 432432423
Dime un segundo nuemro 3243243243243
El 432432423 es menor que 3243243243243
```


# Ejercicio 4:  Validación de contraseñas

## Código del script

```bash
#!/bin/bash

echo "Bienvenido al comprobador de contraseñas"

read -sp "Introduce tu contraseña: " contra


predef="Villabalter1" 

function comprobacion {
        if [ "$predef" == "$contra" ];
        then
                echo "Acceso autorizado"
        else
                echo "Acceso denegado"
        fi
}

comprobacion
```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej4_script.sh 
Bienvenido al comprobador de contraseñas
Introduce tu contraseña: Acceso denegado
vagrant@ubuntu2204:~/condicional_if$
```

# Ejercicio 5: Comprobación de directorio

## Código del script

```bash
#!/bin/bash

echo "verificador de directorios"

read -p "Dame un directorio para comprobar" direct

function comprobaciondirect  {
        if [ -d "$direct" ];
        then
                echo "El directorio existe! "
                if [ -w "$direct" ];
                then
                        echo "El directorio tiene permisos de escritura"
                else
                        echo "El directorio no tiene permisos de escritura"
                fi

        else
                echo "El directorio no existe, procediendo a la creación de $direct"
                mkdir "$direct"
                echo "El directorio ha sido creado"
                ls "$direct"
        fi
}
comprobaciondirect
```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej5_script.sh
verificador de directorios
Dame un directorio para comprobar/home/vagrant/ejemplo/
El directorio no existe, procediendo a la creación de /home/vagrant/ejemplo/        
El directorio ha sido creado
```


# Ejercicio 6: Verificar si el usuario es root

## Código del script

```bash
#!/bin/bash


archivo="ej6_script.sh"

comprobador="$(lsof -u root | grep '$archivo')"

function usuarioejecutor {
        if [ -z "comprobador" ];
        then
                echo "El usuario root no lo ha utilizado"
        else
                echo "El archivo $archivo ha sido utilizado por root"
        fi
}

usuarioejecutor
```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej6_script.sh
El archivo ej6_script.sh ha sido utilizado por root
```


# Ejercicio 7: Calificacion de un examen

## Código del script

```bash
#!/bin/bash

echo "EXAMEN DE CONDUCIR"

read -p "Dame la nota del examen: " nota

function aprosus {
        if [ "$nota" -lt 5 ];then
                echo "El examen está suspenso"
        elif [ "$nota" -eq 5 ] || [ "$nota" -gt 5 ] && [ "$nota" -lt 10 ];then      
                echo "El examen está aprobado"
        else
                echo "Pon una nota real"
        fi
}

aprosus
```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej7_script.sh
EXAMEN DE CONDUCIR
Dame la nota del examen2
El examen está suspenso
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej7_script.sh
EXAMEN DE CONDUCIR
Dame la nota del examen6
El examen está aprobado
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej7_script.sh
EXAMEN DE CONDUCIR
Dame la nota del examen99
Pon una nota real
```

# Ejercicio 8: Comprobacion del espacio en disco

## Código de script

```bash
#!/bin/bash

echo "Comprobador de espacio en disco principal"

espacio=$( df -h | grep /dev/mapper | awk '{print $5}' | tr -d '%')

function comprobar {
        if [ "$espacio" -lt  10 ];
        then
                echo "Te queda menos de un 10% de espacio"
        else
                echo "Todo bien"
        fi
};
comprobar
```


## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej8_script.sh
Comprobador de espacio en disco principal
Te queda menos de un 10% de espacio
```

# Ejercicio 9: Menú de opciones

## Código del script

```bash
#!/bin/bash

echo "Menú diario"
echo "1) Filete con patatas"
echo "2) Zamburiñas"
echo "3) Arroz tres delicias"
echo "Seleccione el número del plato"

read -p "Qué plato desea probar? " plato

function comer {
        if [ "$plato" -eq 1 ]
        then
                echo "De acuerdo, preparando tu filete con patatas"
        elif [ "$plato" -eq 2 ]
        then
                echo "Genial! En poco tendrás tus zamburiñas"
        elif [ "$plato" -eq 3 ]
        then
                echo "Muy buena elección el arroz tres delicias"
        else
                echo "Hijo/a mio/a, mira bien la carta!"
        fi
};

comer

```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej9_script.sh
Menú diario
1) Filete con patatas
2) Zamburiñas
3) Arroz tres delicias
Seleccione el número del plato
Qué plato desea probar? 88
Hijo/a mio7a, mira bien la carta!
```

# Ejercicio 10: Evaluación de edad

## Código del script

```bash
#!/bin/bash

echo "Control parental activado!"

read -p "Dime tu edad si quieres entrar al sitio web! " edad

function verificar {
        if [ "$edad" -lt 18 ];
        then
                echo "Lo siento eres menor de edad!"
        elif [ "$edad" -lt 65 ] && [ "$edad" -gt 18 ];
        then
                echo "Bienvenido/a eres mayor de edad, puedes acceder al casino"
        elif [ "$edad" -lt 100 ] && [ "$edad" -gt 65 ];
        then
                echo "No estas muy mayor para entrar en la web de un casino?"
        else
                echo "Dame una edad real porfavor!"
        fi
};

verificar
```

## Estructura del script

```bash
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej10_script.sh
Control parental activado!
Dime tu edad si quieres entrar al sitio web! 5
Lo siento eres menor de edad!
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej10_script.sh
Control parental activado!
Dime tu edad si quieres entrar al sitio web! 20  
Bienvenido/a eres mayor de edad, puedes acceder al casino
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej10_script.sh
Control parental activado!
Dime tu edad si quieres entrar al sitio web! 99
No estas muy mayor para entrar en la web de un casino?
vagrant@ubuntu2204:~/condicional_if$
```


# Ejercicio 11 : Contar líneas de un archivo

## Código del script

```bash
#!/bin/bash

echo "Verificador de archivos"

read -p "Introduce el nombre de un archivo a verificar" archivo

function verificador {
        if [ -e "$archivo" ]
        then
                echo "El archivo existe!"
                comprobar=$( wc -l $archivo | tr -d $archivo)
                echo "El archivo tiene $comprobar lineas"
        else
                echo "Dame un archivo que exista"
        fi
}

verificador
```

## Ejecución del script

```bash0
vagrant@ubuntu2204:~/condicional_if$ sudo bash ej11_Script.sh
Verificador de archivos
Introduce el nombre de un archivo a verificar/etc/network/interfaces
El archivo existe!
El archivo tiene 3  lineas
```