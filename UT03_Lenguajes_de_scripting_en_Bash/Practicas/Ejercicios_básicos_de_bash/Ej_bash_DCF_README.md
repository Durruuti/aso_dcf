[Volver al indice de la unidad](../../index.md)

# PR0301: Introducción a los scripts en Bash

## 1. Crea un script que muestre por pantalla la fecha y la hora del sistema

### Codigo del script

```bash
#/bin/bash

fecha=$(date +"%A %d de %B del %Y")

hora=$(date +"%H:%M")

function fechahora {
        echo "Hoy es: $fecha a las $hora"
}

fechahora

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/scripts$ bash 1_script.sh
Hoy es: Tuesday 22 de October del 2024 a las 07:13
```


## 2.Mejora el script anterior para que muestre un mensaje de la forma: “Hoy es jueves día 15 de abril y son las 12:00 horas”. Tendrás que mirar la ayuda del comando date para poder extraer las diferentes partes de la fecha y hora.

Para mejorar este script en bash tendremos que hacer unas operaciones previas.

Lo primero que haremos será actualizar la maquina utilizando los comandos:

```bash
sudo apt-get update
sudo apt-get upgrade
```

Una vez que acaben estos dos procesos instalaremos el siguiente paquete

```bash
sudo apt install language-pack-es
```

Esto nos permitirá tener outputs de los scripts en español.

En cuanto al script y su mejora, como ya habia planteado de esta forma el código lo único que le he añadido como **mejora** ha sido incluir el español

### Código del script

```bash
#/bin/bash

export LC_ALL=es_ES.UTF-8


fecha=$(date +"%A %d de %B del %Y")

hora=$(date +"%H:%M")

function fechahora {
        echo "Hoy es: $fecha a las $hora"
}

fechahora

```

Si lo ejecutamos nos aparecerá algo como lo siguiente

### Ejecución del script

```bash
vagrant@ubuntu2204:~/scripts$ bash 2_script.sh
Hoy es: martes 22 de octubre del 2024 a las 07:30
```

## 3. Crea un script que solicite la usuario dos números y luego imprima la suma de esos números

### Código del script

```bash
#!/bin/bash

read -p "Dame un primer numero" n1

read -p "Dame un segundo numero" n2

resultado= $n1 + $n2

function suma {
        echo "El resultado de la suma entre $n1 y $n2 es: "+ $resultado;
}
suma
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/scripts$ bash 3_script.sh
Dame un primer numero 2
Dame un segundo numero 2
El resultado de la suma entre 2 y 2 es 4
```

## 4. Crea un script que determine si un número introducido por el usuario es par o impar. Para realizar este ejercicio puedes utilizar el operador módulo, que es el símbolo %

### Código del script

```bash
read -p "Introduce un número: " n1


function parimpar {
        if [ $(( n1 % 2)) -eq 0 ];
        then
                echo "El número es par"
        else
                echo "El número es impar"
        fi
}

parimpar

```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/scripts$ bash 4_script.sh 
Introduce un número: 67
El número es impar
```


