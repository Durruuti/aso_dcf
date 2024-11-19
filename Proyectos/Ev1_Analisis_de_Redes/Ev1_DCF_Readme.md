[Volver a inicio](../index.md)

# NetScanner by Diego Calles Fernández
## Proyecto 1ª Evaluación ASO

Programa escrito en *Bash* que permite escanear direcciones IP dentro de un rango de red de tipo `/8`, `/16` o `/24`, buscando equipos activos y escaneando los puertos abiertos en esos dispositivos. Además, ofrece la opción de registrar las direcciones MAC y el tiempo de ejecución.

---

## Índice

- [NetScanner by Diego Calles Fernández](#netscanner-by-diego-calles-fernández)
  - [Proyecto 1ª Evaluación ASO](#proyecto-1ª-evaluación-aso)
  - [Índice](#índice)
  - [Explicación](#explicación)
    - [El código](#el-código)
      - [Funciones](#funciones)
        - [`mostrar_ayuda`](#mostrar_ayuda)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento)
        - [`ip_valida`](#ip_valida)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento-1)
        - [`arp`](#arp)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento-2)
        - [Función Principal (Bucle Principal)](#función-principal-bucle-principal)
          - [Descripción del Funcionamiento](#descripción-del-funcionamiento-3)
  - [Requisitos](#requisitos)
    - [1. **SO**](#1-so)
    - [2. **Dependencias**](#2-dependencias)
    - [3. **Permisos**](#3-permisos)
  - [Troubleshooting](#troubleshooting)
    - [Error: "script no se ejecuta correctamente"](#error-script-no-se-ejecuta-correctamente)
    - [Condición importante: "No está permitido el uso conjunto de -o y de --json"](#condición-importante-no-está-permitido-el-uso-conjunto-de--o-y-de---json)
    - [Error: "Máscara de subred inválida"](#error-máscara-de-subred-inválida)
  - [Ejemplos de uso](#ejemplos-de-uso)
    - [Ejemplos de ejecución:](#ejemplos-de-ejecución)

---

## Explicación

Este script realiza un escaneo de red de acuerdo con el rango de IP proporcionado, buscando dispositivos activos mediante *ping*, identificando el sistema operativo de los dispositivos y escaneando los puertos abiertos. También puede generar un archivo de salida con los resultados y/o exportar la información en formato JSON.

---

### El código

#### Funciones

##### `mostrar_ayuda`

La función `mostrar_ayuda` proporciona un menú informativo con el uso correcto del script, las opciones disponibles y ejemplos de ejecución.

###### Descripción del Funcionamiento

1. **Uso y Opciones:** Muestra cómo usar el script y las opciones disponibles.
2. **Descripción General:** Proporciona una descripción básica del funcionamiento del script.
3. **Salida:** Muestra la información de ayuda y termina la ejecución del script.

##### `ip_valida`

La función `ip_valida` valida la dirección IP y la máscara de subred proporcionada por el usuario, asegurándose de que sea del tipo correcto.

###### Descripción del Funcionamiento

1. **Entrada:** Recibe una dirección IP y una máscara de subred.
2. **Validación de Formato:** Verifica que el formato de la IP y la máscara sea válido (ej. `192.168.1.0/24`).
3. **Salida:** Si la IP o la máscara no son válidas, muestra un mensaje de error y termina la ejecución.

##### `arp`

La función `arp` consulta la tabla ARP del sistema para obtener la dirección MAC de un dispositivo dado.

###### Descripción del Funcionamiento

1. **Entrada:** Recibe una dirección IP.
2. **Consulta ARP:** Usa el comando `arp -n` para obtener la dirección MAC asociada a la IP.
3. **Salida:** Muestra la dirección MAC en la consola si es encontrada.

##### Función Principal (Bucle Principal)

El script no tiene una función principal explícita, pero su lógica se organiza en un bucle que procesa los argumentos de la línea de comandos y ejecuta las funciones necesarias.

###### Descripción del Funcionamiento

1. **Procesamiento de Argumentos:** El bucle `while` procesa los argumentos del script, configurando opciones como el archivo de salida, el formato JSON y si se desea mostrar las direcciones MAC.
2. **Escaneo de IPs:** Llama a la función `ping_a_ips` para realizar el escaneo de las IPs activas dentro del rango especificado.
3. **Escaneo de Puertos:** Para cada dispositivo activo, el script escanea los puertos definidos en el archivo `tcp.csv`.
4. **Registro de Resultados:** Los resultados se guardan en el archivo de salida o en un archivo JSON si así se especifica.

---

## Requisitos

Para ejecutar el script, asegúrate de que tu sistema cumpla con los siguientes requisitos:

### 1. **SO**

El script está diseñado para funcionar en sistemas basados en Unix, como:

- **Linux** (Ubuntu, CentOS, Debian, etc.)
- **macOS**

No se garantiza su funcionamiento en Windows sin un entorno compatible como **Cygwin** o **WSL**.

### 2. **Dependencias**

Asegúrate de que las siguientes herramientas y bibliotecas estén instaladas:

- **ping:** Herramienta para enviar paquetes ICMP.
  - **Instalación en Debian/Ubuntu:** `sudo apt install iputils-ping`
  - **Instalación en CentOS/RHEL:** `sudo yum install iputils`

- **netcat (nc):** Utilidad para conexiones TCP/UDP.
  - **Instalación en Debian/Ubuntu:** `sudo apt install netcat`
  - **Instalación en CentOS/RHEL:** `sudo yum install nc`

- **jq:** Herramienta para procesar JSON desde la línea de comandos.
  - **Instalación en Debian/Ubuntu:** `sudo apt install jq`
  - **Instalación en CentOS/RHEL:** `sudo yum install jq`

- **arp:** Comando para consultar la tabla ARP.
  - Generalmente incluido en la mayoría de distribuciones de Linux y macOS por defecto.

### 3. **Permisos**

Es posible que necesites permisos de superusuario para ejecutar algunas funciones del script, especialmente aquellas que implican escaneo de puertos o acceso a la tabla ARP.

Puedes ejecutar el script con `sudo` si es necesario:

```bash
sudo ./netscanner.sh
```

## Troubleshooting

Si al ejecutar el script encuentras problemas relacionados con los saltos de línea o formatos de texto, puedes solucionarlo instalando y utilizando la herramienta ```dos2unix```.

![Problemas](imagenes/Probar_script_en_Linux.png)

### Error: "script no se ejecuta correctamente"

1. Solución instalar ```dos2unix```

```bash
sudo apt-get install dos2unix
```

2. Convertir el archivo con ```dos2unix```

```bash
dos2unix ./netscanner.sh
```

Después de realizar esta conversión, el script deberiía de ejecutarse correctamente

![Dos2unix](imagenes/dos2unix.png)

### Condición importante: "No está permitido el uso conjunto de -o y de --json"

Este error ocurre cuando intentas usar ambas opciones al mismo tiempo. No puedes generar la salida en formato JSON y al mismo tiempo guardar el resultado en un archivo de texto.

**Solucion**:

1. Elimina una de las opciuones!
   1. Si deseas utilizar JSON, asegúrate de no utilizar la opción -o
   2. Si quieres guardar la salida en un archivo, omite la opción --json

### Error: "Máscara de subred inválida"

Este error puede ocurrir si la máscara de subred proporcionada no es válida. Las máscaras válidas que acepta el script son /8, /16, o /24.

Solución:
Asegúrate de que el rango de IP esté en el formato correcto, como 192.168.1.0/24.

## Ejemplos de uso

Para ejecutar el script, usa la siguiente sintaxis:

```bash
sudo bash ./netscanner.sh <rango_ip> [-o archivo_salida] [-m]
```

### Ejemplos de ejecución:

1. Escanear un rango de IPs y guardar la salida en un archivo:

```bash
sudo bash ./netscanner.sh 192.168.1.0/24 -o resultado.txt -m

```

Este comando escaneará el rango 192.168.1.0/24, mostrará las direcciones MAC y guardará los resultados en el archivo resultado.txt.

2. Escanear un rango de IPs, obtener la dirección MAC y exportar los resultados en formato JSON:

```bash
sudo bash ./netscanner.sh 192.168.1.0/24 --json -m

```
Este comando escaneará el rango 192.168.1.0/24, mostrará las direcciones MAC y guardará los resultados en un archivo JSON llamado exportacion.json.


3. Escanear un rango de IPs sin opciones adicionales:

```bash
sudo bash ./netscanner.sh 192.168.1.0/24

```

Este comando escaneará el rango 192.168.1.0/24 sin mostrar direcciones MAC ni generar un archivo de salida.

4. Escanear un rango con un tiempo de ejecución registrado:

```bash
sudo bash ./netscanner.sh 192.168.1.0/24 -t

```
Este comando escaneará el rango 192.168.1.0/24 y mostrará el tiempo que tarda en completarse el escaneo.