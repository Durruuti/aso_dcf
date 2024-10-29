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

### Ejecución del script
