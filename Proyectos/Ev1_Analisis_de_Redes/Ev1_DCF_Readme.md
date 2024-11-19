[Volver a inicio](../index.md)

# NetScanner by Diego Calles Fernández
## Proyecto 1ª Evaluación ASO

Programa escrito en *Bash* que analiza direcciones de red de tipo `/8`, `/16` y `/24` en busca de equipos. Además, el programa examina los puertos abiertos de dichos equipos. 🔍

## Índice

- [NetScanner by Diego Calles Fernández](#netscanner-by-diego-calles-fernández)
  - [Proyecto 1ª Evaluación ASO](#proyecto-1ª-evaluación-aso)
  - [Índice](#índice)
  - [Explicación](#explicación)
    - [El código](#el-código)
      - [Funciones](#funciones)
        - [mostrar\_ayuda](#mostrar_ayuda)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento)
        - [ip\_valida](#ip_valida)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento-1)
        - [arp](#arp)
          - [Descripción del funcionamiento](#descripción-del-funcionamiento-2)
        - [Función Principal (Bucle principal)](#función-principal-bucle-principal)
          - [Descripción del funcionamiento](#descripción-del-funcionamiento-3)
  - [Requisitos](#requisitos)
    - [1. **SO**](#1-so)
    - [2. **Dependencias**](#2-dependencias)
    - [3. **Permisos**](#3-permisos)
  - [Troubleshooting](#troubleshooting)

## Explicación

Este script escanea un rango de direcciones IP y, opcionalmente, guarda el resultado en un archivo si se especifica la opción `-o` o `--output`. También puede mostrar la dirección MAC de cada equipo y registrar el tiempo de ejecución. ⏱️

### El código

#### Funciones
 
##### mostrar_ayuda

La función `mostrar_ayuda` se encarga de mostrar un menú de ayuda al usuario. Esta función se activa cuando el usuario solicita ayuda o cuando se producen errores en los argumentos de entrada. 

###### Descripción del Funcionamiento

1. **Uso y Opciones:** Muestra cómo usar el script, los parámetros aceptados y ejemplos de uso.
2. **Descripción General:** Proporciona una breve descripción de lo que hace el script.
3. **Salida:** Imprime la información en la consola y finaliza la ejecución del script con `exit 0`.

##### ip_valida

La función `ip_valida` valida el formato de la dirección IP y la máscara de subred proporcionadas por el usuario.

###### Descripción del Funcionamiento

1. **Entrada:** Toma como argumento una dirección IP.
2. **Escaneo de Puertos:** Itera sobre una lista de puertos predefinidos y utiliza el comando `nc` (netcat) para intentar conectarse a cada puerto en la dirección IP proporcionada.
3. **Salida:** 
   - Si un puerto está abierto, se imprime la información del puerto y su servicio asociado.
   - Si se ha habilitado la opción de salida en formato JSON, se agrega la información de los puertos abiertos al archivo JSON acumulativo.
   - Si se especificó un archivo de salida, la información también se guarda en ese archivo.

##### arp

La función `arp` no está definida explícitamente en el script, pero se utiliza para obtener la dirección MAC de un dispositivo activo en la red.

###### Descripción del funcionamiento

1. **Entrada:** Se invoca con una dirección IP específica.
2. **Consulta ARP:** Utiliza el comando `arp -n` para consultar la tabla ARP y obtener la dirección MAC asociada a la dirección IP.
3. **Salida:** Si se encuentra una dirección MAC, se imprime en la consola.

##### Función Principal (Bucle principal)

El script no tiene una función principal explícita, pero la lógica de ejecución se desarrolla a través de un bucle `while` que procesa los argumentos de entrada y llama a las funciones anteriores según sea necesario.

###### Descripción del funcionamiento

1. **Procesamiento de Argumentos:** Utiliza un bucle `while` para analizar los argumentos de línea de comandos y establecer las variables de configuración.
2. **Validación Inicial:** Llama a la función `ip_valida` para verificar la dirección IP y la máscara.
3. **Escaneo de IPs:** Llama a la función `ping_a_ips` para iniciar el escaneo de la red.
4. **Salida Final:** Imprime el tiempo de ejecución y la ubicación del archivo de salida, si corresponde. 📊

## Requisitos

Antes de ejecutar el script, asegúrate de que tu sistema cumpla con los siguientes requisitos:

### 1. **SO**

   - El script ha sido diseñado para funcionar en sistemas basados en Unix, como:
     - **Linux** (distribuciones como Ubuntu, CentOS, Debian, etc.)
     - **macOS**
   - No se garantiza su funcionamiento en sistemas Windows sin un entorno compatible como Cygwin o WSL (Windows Subsystem for Linux).

### 2. **Dependencias**

   Asegúrate de que las siguientes herramientas y bibliotecas estén instaladas en tu sistema:

   - **ping**: Herramienta para enviar paquetes ICMP a direcciones IP.
     - **Instalación en Debian/Ubuntu**: `sudo apt install iputils-ping`
     - **Instalación en CentOS/RHEL**: `sudo yum install iputils`
   
   - **netcat (nc)**: Utilidad para leer y escribir datos a través de conexiones de red utilizando TCP o UDP.
     - **Instalación en Debian/Ubuntu**: `sudo apt install netcat`
     - **Instalación en CentOS/RHEL**: `sudo yum install nc`
   
   - **jq**: Herramienta de línea de comandos para procesar JSON.
     - **Instalación en Debian/Ubuntu**: `sudo apt install jq`
     - **Instalación en CentOS/RHEL**: `sudo yum install jq`
   
   - **arp**: Comando utilizado para mostrar o manipular la tabla ARP (Address Resolution Protocol).
     - Generalmente, está incluido en la mayoría de las distribuciones de Linux y macOS por defecto.

### 3. **Permisos**

   - Es posible que necesites permisos de superusuario para ejecutar algunas de las funciones del script, especialmente aquellas que involucran escaneo de puertos o acceso a la tabla ARP. Puedes ejecutar el script con `sudo` si es necesario:
     ```bash
     sudo ./nombre_del_script.sh
     ```


## Troubleshooting

Para ejecutar el script, utiliza la siguiente sintaxis en la terminal:

```bash
./nombre_del_script.sh [opciones] [argumentos]
````
![Error en Linux](imagenes/Probar_script_en_Linux.png)

Este error puede aparecer cuando ejecutamos el script en Linux:



Para solucionarlo, debemos instalar la aplicación `dos2unix`:

```bash
sudo apt-get install dos2unix
```

Una vez instalada , hacemos lo siguiente:

![Dos2Unix](imagenes/dos2unix.png)

Ahora ya podremos utilizarlo con total normalidad!