[Volver al indice de la unidad](../../index.md)

# PR0304: Ejercicios entrada y salida de datos

## 1.Buscar palabra en archivo

### Código del script

```bash
#!/bin/bash

archivo=$1
palabra=$2

if [ ! -f "$archivo" ]; then
        echo "El archivo '$archivo' no existe. "
        echo exit 1
fi


grep "$palabra" "$archivo"
```

#### Archivo .txt

```txt
hola buenos dias
El dia de hoy esta nublado
Tengo cuidado con ese coche
Hoy es de noche
Mañana sera de dia
Por las noches no es de dia
Quiero un zumo
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej1.sh archivo.txt dia
hola buenos dias
El dia de hoy esta nublado
Mañana sera de dia
Por las noches no es de dia
vagrant@ubuntu2204:~/ejercicios$
```


## Ejercicio 2: Contar palabras

En este ejercicio utilizaré el archivo de texto creado en el anterior ejercicio

### Código del script

```bash
#!/bin/bash

archivo=$1

if [ ! -f "$archivo" ]; then
        echo "El archivo '$archivo' no existe!"
        exit 1
fi

contar=$(wc -w < "$archivo")

echo "El archivo '$archivo' tiene '$contar' palabras!"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej2.sh archivo.txt
El archivo 'archivo.txt' tiene '32' palabras!
vagrant@ubuntu2204:~/ejercicios$
```

## 3.Suma de numeros

### Código del script

```bash
#!/bin/bash

archivo=$1

if [ ! -f "$archivo" ]; then
        echo "El archivo '$archivo' no existe!!"
        exit 1
fi

suma=0

while read linea; do
        suma=$((suma + linea))
done < "$archivo"

echo "La suma total es: '$suma' "
```

#### Contenido del archivo de números

```txt
1
2123
23
565
34

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej3.sh numeros.txt
La suma total es: '2746' 
vagrant@ubuntu2204:~/ejercicios$
```

## 4. Datos de usuario

### Código del script

```bash
#!/bin/bash

nif=$1

archivo=$2

if [ ! -f "$archivo" ]; then
        echo "El archivo '$archivo' no existe!!"
        exit 1
fi

while read -r linea; do
    linea=$(echo "$linea" | tr ',' ' ' | xargs)

    read nif_line nombre apellidos ciclo modulo nota <<< "$linea"

    if [ "$nif_line" == "$nif" ]; then
        echo "El alumno $nombre $apellidos tiene una calificación de $nota puntos en el>    fi
done < "$archivo"
```

#### Contenido alumnos.csv

```csv
10100100X, victor, gonzález rodríguez, asir, aso, 6
12345678A, pepe, fernández fernández, asir, aso, 8
10100100X, victor, gonzález rodríguez, asir, iso, 5
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej4.sh 10100100X alumnos.csv
El alumno victor gonzález tiene una calificación de aso 6 puntos en el módulo asir.
El alumno victor gonzález tiene una calificación de iso 5 puntos en el módulo asir.
```

## Ejercicio 5: Lineas con más de N caracteres

Para este archivo utilizaré el archivo del ejercicio 1

## Código del script

```bash
#!/bin/bash


archivo=$1
numero=$2

if [ ! -f "$archivo" ]; then
    echo "El archivo '$archivo' no existe."
    exit 1
fi

while read -r linea; do
    longitud=${#linea}

    if [ "$longitud" -gt "$numero" ]; then
        echo "$linea"
    fi
done < "$archivo"
```

## Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej5.sh archivo.txt 20
El dia de hoy esta nublado
Tengo cuidado con ese coche
Por las noches no es de dia
vagrant@ubuntu2204:~/ejercicios$
```

## Ejercicio 6: Estadísticas de archivos

### Código del script

```bash
#!/bin/bash

for archivo in *; do
    if [ -f "$archivo" ]; then
        lineas=$(wc -l < "$archivo")
        palabras=$(wc -w < "$archivo")
        caracteres=$(wc -c < "$archivo")

        echo "Informe para el archivo: $archivo"
        echo "Líneas: $lineas"
        echo "Palabras: $palabras"
        echo "Caracteres: $caracteres"
        echo "---------------------------"
    fi
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios$ sudo bash ej6.sh
Informe para el archivo: alumnos.csv
Líneas: 3
Palabras: 21
Caracteres: 161
---------------------------
Informe para el archivo: archivo.txt
Líneas: 7
Palabras: 32
Caracteres: 151
---------------------------
Informe para el archivo: ej1.sh
Líneas: 12
Palabras: 24
Caracteres: 152
```