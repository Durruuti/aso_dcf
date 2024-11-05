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

```

### Ejecución del script

```bash

```
