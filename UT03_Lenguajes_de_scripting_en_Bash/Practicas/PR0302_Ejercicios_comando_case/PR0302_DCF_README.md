[Volver al indice de la unidad](../../index.md)

# EJERCICIOS COMANDO CASE

## Ejercicio 1: Menú operaciones matemáticas

### Código del script

```bash
#!/bin/bash

echo "Selecciona la operacion que deseas realizar"

echo "Suma + ; Resta - ; Multiplicacion * ; Division /"

echo "introduce el signo!"
read -p "¿Qué operación deseas realizar? " operacion

case $operacion in
        +)
                echo "Has elegido suma!"
                read -p "Dime un primer numero " s_n1
                read -p "Dime un segundo numero " s_n2
                suma=$((s_n1 + s_n2))
                echo "El resultado de la suma es : $suma"
                ;;
        -)
                echo "Has elegido resta!"
                read -p "Dime un primer número " r_n1
                read -p "Dime un segundo número " r_n2

                resta=$((r_n1 - r_n2))
                echo "El resultado de la resta es $resta"
                ;;
        *)
                echo "Has elegido multiplicación!"
                read -p "Dime un primer número " m_n1
                read -p "Dime un segundo número " m_n2

                multi=$((m_n1 * m_n2))

                echo "El resultado de la multiplicación es: $multi"
                ;;
        /)
                echo "Has elegido división!"
                read -p "Dime un primer número " d_n1
                read -p "Dime un segundo número " d_n2

                div=$((d_n1 / d_n2))
                echo "El resultado de la division es: $div"
                ;;
esac


```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comandos_case$ sudo bash ej1_script.sh 
Selecciona la operacion que deseas realizar
Suma + ; Resta - ; Multiplicacion * ; Division /
introduce el signo!
¿Qué operación deseas realizar? +
Has elegido suma!
Dime un primer numero 2
Dime un segundo numero 2
El resultado de la suma es : 4
vagrant@ubuntu2204:~/comandos_case$ 
```

> No sé por qué no me divide.


## Ejercicio 2: identificación de extension de archivo

### Código del script

```bash
#!/bin/bash

echo "Identificacion de extensión de archivo"


read -p "Dame un nombre de archivo: " archivo

extension="${archivo##*.}"

# Esto es para que funcione el tar.gz.

if [[  "$archivo" == *.tar.gz ]];then
        extension="tar.gz"
fi

case $extension in
        txt)
                echo "Es un archivo de texto"
                ;;
        zip)
                echo "Es un archivo comprimido"
                ;;
        tar.gz)
                echo "Es un archivo comprimido"
                ;;
        *)
                echo "Este archivo es diferente a lo que buscaba"
                ;;
esac
```

### Ejecución del script

```bash
#Considero que la parte dificil del ejercicio es que funcione el .tar.gz
vagrant@ubuntu2204:~/comando_case$ sudo bash ej2_script
Identificacion de extensión de archivo
Dame un nombre de archivo: hola.tar.gz
Es un archivo comprimido
```

## Ejercicio 3 : Conversor de unidades

### Código del script

```bash
#!/bin/bash

echo "Conversor de unidades"
echo "AVISO: Los cálculos no incluirán decimales. Únicamente resultados enteros"

echo "1) Convertir de m a km"
echo "2) Convertir de millas a m"
echo "3) Convertir de hectareas a m2"

read -p "Selecciona una opcion [1-3]" opcion

case $opcion in
        1)
                echo "Has seleccionado convertir metros a kilómetros"
                read -p "Introduce los metros: " metros

                # El scale=2 significan que tiene que sacar 2 decimales

                kilometros=$( echo "scale=2; $metros / 1000" | bc)
                echo "Los $metros metros son igual a $kilometros kilómetros"
                ;;
        2)
                echo "Has seleccionado convertir millas a m"
                read -p "Introduce las millas: " millas

                metros=$( echo "scale=2; $millas * 1609.34" | bc)
                echo "Las $millas millas son igual a $metros metros"
                ;;
        3)
                echo "Has seleccionado convertir de hectareas a m2"
                read -p "Introduce las hectareas: " hectareas
                m2=$(echo "scale=2; $hectareas * 10000" | bc)
                echo "Las $hectareas hectareas son igual a $m2 m2"
                ;;
esac
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej3_script 
Conversor de unidades
AVISO: Los cálculos no incluirán decimales. Únicamente resultados enteros
1) Convertir de m a km
2) Convertir de millas a m
3) Convertir de hectareas a m2
Selecciona una opcion [1-3]2
Has seleccionado convertir millas a m
Introduce las millas: 213
Las 213 millas son igual a 342789.42 metros
```