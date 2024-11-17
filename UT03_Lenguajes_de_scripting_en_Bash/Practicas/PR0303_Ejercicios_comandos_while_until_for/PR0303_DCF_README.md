[Volver al indice de la unidad](../../index.md)

# PR0303: Ejercicios sobre comandos ```while```,```until``` y ```for```

## Ejercicio 1: Contar hasta 10 con for

### Código del script
```bash
#!/bin/bash

for numero in {1..10}
do
        echo $numero
done

```
### Ejecución del script
```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej1_script.sh
1
2
3
4
5
6
7
8
9
10
```

## Ejercicio 2: Sumar los primeros 50 números

### Código del script

```bash
#!/bin/bash

i=0

for numero in {1..50}
do
        suma=$((suma + numero))
done

echo "La suma de los 50 números naturales es: $suma"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej2_script.sh
La suma de los 50 números naturales es: 1275
```

## Ejercicio 3: Tabla de multiplicar

### Código del script

```bash
#!/bin/bash

echo "TABLA DE MULTIPLCIAR"

read -p "Dame un numero: " num

for n1 in {1..10}
do
        multi=$((n1 * num))

        echo "$num * $n1 = $multi"
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej3_script.sh
TABLA DE MULTIPLCIAR
Dame un numero: 2
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
2 * 10 = 20
```

## Ejercicio 4: Imprimir cada letra

### Código del script

```bash
#!/bin/bash


echo "SEPARADOR DE PALABRAS"

read -p "Dime una palabra: " palabra

for (( i=0; i<${#palabra}; i++ ))
do
        echo "${palabra:i:1}"
done

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej4_script.sh
SEPARADOR DE PALABRAS
Dime una palabra: hola
h
o
l
a
vagrant@ubuntu2204:~/ejercicios_bucles$
```

## Ejercicio 5: Contar numeros pares del 1 al 20 con while

### Código del script

```bash
#!/bin/bash

i=0

while [ $i -le 20 ]
do
        if [ $(( $i % 2  )) -eq 0 ]
        then
                echo $i
        fi

        i=$(($i+1))
done

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej5_script.sh
0
2
4
6
8
10
12
14
16
18
20
```

## Ejercicio 6: Suma de digitos

### Código del script

```bash
#!/bin/bash

echo "SUMADOR DE DIGITOS"

read -p "Dime un numero: " num

suma=0

while [ -n "$num" ];
do
        digito=${num: -1}

        suma=$((suma + digito))

        num=${num:0:${#num}-1}
done

echo "La suma de los digitos es: $suma"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej6_script.sh
SUMADOR DE DIGITOS
Dime un numero: 123
La suma de los digitos es: 6
vagrant@ubuntu2204:~/ejercicios_bucles$
```


## Ejercicio 7: cuenta regresiva

### Código del script

```bash
#!/bin/bash

echo "CUENTA REGRESIVA"

read -p "Dame un numero: " numero

until [ $numero -lt 0 ]
do
        echo "$numero"
        numero=$(( $numero - 1 ))
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej7_script.sh 
CUENTA REGRESIVA
Dame un numero: 7
7
6
5
4
3
2
1
0
```

## Ejercicio 8: Imprimir solo archivos.txt

### Código del script

```bash
#!/bin/bash

for archivo in *.txt;
do
        if [ -e "$archivo" ];
        then
                echo "Archivo encontrado: $archivo"
        fi
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej8_script.sh
Archivo encontrado: adios.txt
Archivo encontrado: hola.txt
Archivo encontrado: prueba.txt
vagrant@ubuntu2204:~/ejercicios_bucles$ ls
123.csv        ej2_script.sh  ej5_script.sh  ej8_script.sh  prueba.txt
adios.txt      ej3_script.sh  ej6_script.sh  hola.txt       si.csv
ej1_script.sh  ej4_script.sh  ej7_script.sh  prueba.csv
vagrant@ubuntu2204:~/ejercicios_bucles$
```


## Ejercicio 9: Factorial de un número

### Código del script

```bash
#!/bin/bash

echo "CALCULADORA DE FACTORIALES"
echo "---------------------------"

read -p "Dame un número " num

factorial=1


for (( i=1; i<=num; i++))
do
        factorial=$((factorial * i)) 
done

echo "el numero factorial de $num es: $factorial"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej9_script.sh
CALCULADORA DE FACTORIALES
---------------------------
Dame un número 3
el numero factorial de 3 es: 6
vagrant@ubuntu2204:~/ejercicios_bucles$
```

## Ejercicio 10: Verificar contraseña

### Código del script

```bash
#!/bin/bash

echo "VERIFICACION DE CONTRASEÑA"
echo "--------------------------"


read -sp "Introduce la contraseña " c1

contra="Villabalter1"

until [ "$c1" = "$contra" ]; do
        echo "error!"
        read -sp "Introduce la contraseña " c1
done

echo "Acertaste!"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej10_script.sh
VERIFICACION DE CONTRASEÑA
--------------------------
Introduce la contraseña error!
Introduce la contraseña error!
Introduce la contraseña Acertaste!
```

## Ejercicio 11: Adivinar un numero

### Código del script

```bash
#!/bin/bash

echo "ADIVINA ADIVINA MI NUMERO!"

read -p "Introduce el número! " n1


sorteo=$(( RANDOM % 10 + 1 ))


while [ "$n1" != "$sorteo" ]; do
        echo "jijiji casi crack"
        read -p "Introduce el número! " n1
done

echo "Felicidades acertastes!"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej11_script.sh
ADIVINA ADIVINA MI NUMERO!
Introduce el número! 1
jijiji casi crack
Introduce el número! 2
jijiji casi crack
Introduce el número! 3
Felicidades acertastes!
```

## Ejercicio 12: Mostrar fecha n veces

### Código del script

```bash
#!/bin/bash

echo "MOSTRADOR DE FECHAS"


read -p "Dime un numero" n1

for (( i=0; i < "$n1" ; i++)); do
        date
        time
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej12_script.sh
MOSTRADOR DE FECHAS
Dime un numero3
Tue Nov  5 09:04:24 AM UTC 2024

real    0m0.000s
user    0m0.000s
sys     0m0.000s
Tue Nov  5 09:04:24 AM UTC 2024

real    0m0.000s
user    0m0.000s
sys     0m0.000s
Tue Nov  5 09:04:24 AM UTC 2024

real    0m0.000s
user    0m0.000s
sys     0m0.000s
vagrant@ubuntu2204:~/ejercicios_bucles$ 
```

## Ejercicio 13: Promedio de numeros ingresados

### Código del script

```bash
ª/bin/bash

echo "CALCULADOR DE PROMEDIO"

suma=0
contador=0

while [ $numweo  != "fin" ] do
        read -p "Introduce un número [Introduce fin para calcular]" numero

        suma=$(echo "$suma + $numero" | bc)
        contador=$((contador + 1 ))
done

if [ $contador -gt 0 ];
then
        promedio=$(echo "scale=2; $suma / $contador" | bc)
        echo "El promedio de los numeros introducidos es: $promedio"
else
        echo "introduce numeros"
fi
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/ejercicios_bucles$ sudo bash ej13_script.sh
CALCULADOR DE PROMEDIO
Introduce un número [Introduce fin para calcular]23
Introduce un número [Introduce fin para calcular]2
Introduce un número [Introduce fin para calcular]4
Introduce un número [Introduce fin para calcular]fin
El promedio de los numeros introducidos es: 9.66
```

## Ejercicio 14: Contar palabras de una cadena

### Código del script

```bash
#!/bin/bash

read -p "Introduce la cadena: " cadena

i=0

for palabra in $cadena; do
        i=$((i + 1))
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ sudo bash ej14_script.sh  
Introduce la cadena: hola buenos dias
La cadena tiene 3 palabras
```

## Ejercicio 15: Juego de adivinar con limites dinámicos

### Código del script

```bash
#!/bin/bash

num=$((RANDOM % 100 + 1))

echo "EL GENIO DE LOS NUMEROS"

echo "¿Conseguiras adivinarme el numero?"

adiv=0

while [ $adiv -ne $num ]; do
        read -p "Intenta adivinar el numero que tengo en la cabeza! " adiv
        if [ $adiv -lt $num ]; then
                echo "El numero que buscas es mayor"
        elif [ $adiv -gt $num ]; then
                echo "El numero que buscas es menor"
        else
                echo "Vaya! Lo adivinastes!"
        fi
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ sudo bash ej15_script.sh  
EL GENIO DE LOS NUMEROS
¿Conseguiras adivinarme el numero?
Intenta adivinar el numero que tengo en la cabeza! 13
El numero que buscas es mayor
Intenta adivinar el numero que tengo en la cabeza! 3
El numero que buscas es mayor
Intenta adivinar el numero que tengo en la cabeza! 4
El numero que buscas es mayor
Intenta adivinar el numero que tengo en la cabeza! 5
El numero que buscas es mayor
Intenta adivinar el numero que tengo en la cabeza! 85
El numero que buscas es menor
Intenta adivinar el numero que tengo en la cabeza! 59
El numero que buscas es menor
Intenta adivinar el numero que tengo en la cabeza! ^C
vagrant@ubuntu2204:~/condicionales$ 
```


## Ejercicio 16: Archivo con nombres de directorios

### Código del script

```bash
#!/bin/bash
> directorios.txt
for dir in */; do

        if [ -d "$dir" ]; then
                echo "${dir%/}" >> directorios.txt
        fi

done


```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ mkdir hola1
vagrant@ubuntu2204:~/condicionales$ sudo bash ej16_script.sh 
Todos los nombres del directorio se guardaron en directorios.txt
vagrant@ubuntu2204:~/condicionales$ cat directorios.txt 
hola1
hola2
vagrant@ubuntu2204:~/condicionales$ 
```


## Ejercicio 17: Crear x numero de archivos

### Código del script

```bash
#!/bin/bash


echo "Generador de archivos"

read -p "Dime un numero [0-10]" num

for ((i=0; i <=num; i++)); do
        touch "archivo".$i.".txt"
done
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ sudo bash ej17_script.sh 
Generador de archivos
Dime un numero [0-10]3
Se han creado 4 archivos
vagrant@ubuntu2204:~/condicionales$ ls
archivo.0..txt  archivo.1..txt  archivo.2..txt  archivo.3..txt 
```

## Ejercicio 18: Contar vocales

### Código del script

```bash
#!/bin/bash

echo "Contador de vocales en una cadena"

read -p "Dame una cadena de texto: " cadena

# Inicializar el contador de vocales
contador_vocales=0

# Usar un bucle for para iterar sobre cada letra de la cadena
for ((i=0; i<${#cadena}; i++)); do
    letra="${cadena:i:1}"
    if [[ "$letra" =~ [aeiouAEIOU] ]]; then
        contador_vocales=$((contador_vocales + 1))  # Incrementar el contador de vocales
    fi
done

echo "La cadena: '$cadena' tiene $contador_vocales vocales."
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ sudo bash ej18_script.sh 
Contador de vocales en una cadena
Dame una cadena de texto: hola
La cadena: 'hola' tiene 2 vocales.
```


## Ejercicio 19: Validación de entrada

### Código del script

```bash
#!/bin/bash

numerito=0

until [[ $numerito -ge 1 && $numerito -le 10 ]]; do
        read -p "Dame un numero [1-10]: " numerito
done

echo "Muy bien me diste un numero entre 1 y 10! -->  $numerito"
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/condicionales$ sudo bash ej19_script.sh
Dame un numero [1-10]: 3
Muy bien me diste un numero entre 1 y 10! -->  3
vagrant@ubuntu2204:~/condicionales$ 
```

## Ejercicio 20: Script de copia de seguridad

### Código del script

```bash
#!/bin/bash

mkdir -p backup

for texto in *.txt; do
        if [[ -f "$texto" ]];then
                cp "$texto" backup/
        fi
done

echo "Los archivos de texto han sido guardados en la carpeta 'backup' "
```

### Ejecución del script

```bash
agrant@ubuntu2204:~/condicionales$ sudo bash ej20_script.sh 
Los archivos de texto han sido guardados en la carpeta 'backup' 
vagrant@ubuntu2204:~/condicionales$ ls backup/
archivo.0..txt  archivo.1..txt  archivo.2..txt  archivo.3..txt  directorios.txt  hola.txt
vagrant@ubuntu2204:~/condicionales$ 
```