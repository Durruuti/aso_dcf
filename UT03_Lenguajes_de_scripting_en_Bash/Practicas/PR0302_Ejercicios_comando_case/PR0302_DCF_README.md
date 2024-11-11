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

## Ejercicio 4: Menú de configuración de sistema

### Código del script
```bash
#!/bin/bash

echo "Menú para gestionar sistema"
echo "1) Apagar"
echo "2) Reiniciar"
echo "3) Cerrar sesion"

echo "---------------------"

read -p "Selecciona una opción [1-3]" opcion

case $opcion in
        1)
                echo "Apagando el equipo..."
                sudo shutdown now
                ;;
        2)
                echo "Reiniciando el equipo"
                sudo reboot now
                ;;
        3)
                echo "Cerrando la sesion"
                logout
                ;;
        *)
                echo "Solo vale un número del 1 al 3, no inventes!"
                ;;
esac
```

### Ejecución del script

> En la ejecución de este script es dificil de mostrar como funciona aunque, solo viendo de que va el script se puede hacer uno una idea.

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej4_script.sh 
Menú para gestionar sistema
1) Apagar
2) Reiniciar
3) Cerrar sesion
---------------------
Selecciona una opción [1-3]*
Solo vale un número del 1 al 3, no inventes!
vagrant@ubuntu2204:~/comando_case$ 
```

## Ejercicio 5: Dia de la semana

### Código del script

```bash
#!/bin/bash

echo "¿Quieres saber que dia de la semana es?"

read -p "Introduce el numero del dia de la semana que corresponde! [1-7]" dia

case $dia in
        1)
                echo "Hoy es Lunes!"
                ;;
        2)
                echo "Hoy es Martes!"
                ;;
        3)
                echo "Hoy es Miércoles!"
                ;;
        4)
                echo "Hoy es Jueves!"
                ;;
        5)
                echo "Hoy es Viernes!"
;;
        6)
                echo "Hoy es Sábado!"
                ;;
        7)
                echo "Felicidades! Es Domingo"
                ;;
        *)
                echo "Solo hay siete dias en la semana animal!"
                ;;
esac
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej5_script.sh 
¿Quieres saber que dia de la semana es?
Introduce el numero del dia de la semana que corresponde! [1-7]: 2
Hoy es Martes!
vagrant@ubuntu2204:~/comando_case$ sudo bash ej5_script.sh 
¿Quieres saber que dia de la semana es?
Introduce el numero del dia de la semana que corresponde! [1-7]: 432
Solo hay siete dias en la semana animal!
vagrant@ubuntu2204:~/comando_case$ sudo bash ej5_script.sh 
¿Quieres saber que dia de la semana es?
Introduce el numero del dia de la semana que corresponde! [1-7]: a
Solo hay siete dias en la semana animal!
vagrant@ubuntu2204:~/comando_case$
```

## Ejercicio 6: Clasificación de notas

### Código del script

```bash
#!/bin/bash

echo "Es el momento de clasificar las notas!"
echo "Menú clasificador de notas"

echo "UNICAMENTE valdrán números exactos (Sin decimales)"

read -p "Que nota quieres clasificar [0-10]: " nota

case $nota in
        0|1|2|3|4)
                echo "Lo siento mucho esta nota es un Suspenso"
                ;;
        5)
                echo "Esta nota es un Aprobado"
                ;;
        6)      echo "Esta nota es un Bien"
                ;;
        7|8)
                echo "Esta nota es un Notable"
                ;;
        9|10)
                echo "Esta nota es un Sobresaliente"
                ;;
        *)
                echo "Tienes que introducir una nota del 0-10 exacto!"
                ;;
esac
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej6_script.sh
Es el momento de clasificar las notas!
Menú clasificador de notas
UNICAMENTE valdrán números exactos (Sin decimales)
Que nota quieres clasificar [0-10]: 12
Tienes que introducir una nota del 0-10 exacto!
vagrant@ubuntu2204:~/comando_case$ sudo bash ej6_script.sh
Es el momento de clasificar las notas!
Menú clasificador de notas
UNICAMENTE valdrán números exactos (Sin decimales)
Que nota quieres clasificar [0-10]: 4
Lo siento mucho esta nota es un Suspenso
vagrant@ubuntu2204:~/comando_case$ sudo bash ej6_script.sh
Es el momento de clasificar las notas!
Menú clasificador de notas
UNICAMENTE valdrán números exactos (Sin decimales)
Que nota quieres clasificar [0-10]: 7
Esta nota es un Notable
vagrant@ubuntu2204:~/comando_case$ sudo bash ej6_script.sh
Es el momento de clasificar las notas!
Menú clasificador de notas
UNICAMENTE valdrán números exactos (Sin decimales)
Que nota quieres clasificar [0-10]: 8
Esta nota es un Notable
vagrant@ubuntu2204:~/comando_case$ sudo bash ej6_script.sh
Es el momento de clasificar las notas!
Menú clasificador de notas
UNICAMENTE valdrán números exactos (Sin decimales)
Que nota quieres clasificar [0-10]: 10
Esta nota es un Sobresaliente
vagrant@ubuntu2204:~/comando_case$ 
```

## Ejercicio 7: Verificador de numeros

### Código del script

```bash
#!/bin/bash

echo "Comprobación de números"
echo "-----------------------"

echo "Se clasificarán en POSITIVOS, NEGATIVOS y CERO"

read -p "introduce el número a comprobar: " numero

if [[ ! "$numero" =~ ^-?[0-9]+$ ]];
then
        echo "Tienes que introducir un número entero"
else
        case $numero in
                0)
                        echo "Si, es un CERO"
                        ;;
                -*)
                        echo "El $numero es negativo"
                        ;;
                *)
                        echo "El $numero es positivo"
                        ;;

        esac
fi
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej7_script.sh 
Comprobación de números
-----------------------
Se clasificarán en POSITIVOS, NEGATIVOS y CERO
introduce el número a comprobar: zaaaaa
Tienes que introducir un número entero
vagrant@ubuntu2204:~/comando_case$ sudo bash ej7_script.sh                                                                                                                                                                        
Comprobación de números
-----------------------
Se clasificarán en POSITIVOS, NEGATIVOS y CERO
introduce el número a comprobar: 2
El 2 es positivo
vagrant@ubuntu2204:~/comando_case$ sudo bash ej7_script.sh 
Comprobación de números
-----------------------
Se clasificarán en POSITIVOS, NEGATIVOS y CERO
introduce el número a comprobar: -59
El -59 es negativo
vagrant@ubuntu2204:~/comando_case$ 

```

## Ejercicio 8: Control de servicios en Linux

### Código del script

```
!/bin/bash

echo "Control de servicios en el sistema!"        

read -p "Dime el nombre de un servicio: " servicio

if systemctl status "$servicio" &> /dev/null;     
then
        echo "El servicio existe!" 

        echo "Ejecutando menú....."
        echo "1) Iniciar servicio" 
        echo "2) Estado del servicio"
        echo "3) Parar el servicio"
        echo "4) Reiniciar el servicio"

        read -p  "Menú de gestión de procesos. ¿Que desea hacer? [1-4]: " accion

        case $accion in
                1)
                        echo "Iniciando servicio"
                        systemctl start "$servicio"
                        ;;
                2)
                        echo "Comprobando el estado del servicio"
                        systemctl status "$servicio"
                        ;;
                3)
                        echo "Deteniendo el servicio"
                        systemctl stop "$servicio"
                        ;;
                4)
                        echo "Reiniciando servicio"
                        systemctl restart "$servicio"
                        ;;
                *)
                        echo "No ves que solo hay 4 opciones?!"
                        ;;
        esac
else
        echo "Lo siento el servicio no existe!"
fi
```

### Ejecución del script

```bash
vagrant@ubuntu2204:~/comando_case$ sudo bash ej8_script.sh 
Control de servicios en el sistema!
Dime el nombre de un servicio: cron
El servicio existe!
Ejecutando menú.....
1) Iniciar servicio
2) Estado del servicio
3) Parar el servicio
4) Reiniciar el servicio
Menú de gestión de procesos. ¿Que desea hacer? [1-4]: 2
Comprobando el estado del servicio
● cron.service - Regular background program processing daemon
     Loaded: loaded (/lib/systemd/system/cron.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2024-11-01 17:18:31 UTC; 54min ago
       Docs: man:cron(8)
   Main PID: 599 (cron)
      Tasks: 1 (limit: 2220)
     Memory: 3.1M
        CPU: 70ms
     CGroup: /system.slice/cron.service
             └─599 /usr/sbin/cron -f -P

```

