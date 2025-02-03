[Volver a inicio](../index.md)

A través del siguiente enlace podrá consultar las notas que he ido tomando para constituir este dominio educativo

[Notas](notas.md)

# Proyecto 2º Evaluación: Dominio educativo

## Villabalter.edu

### Características del servidor

- Nombre de equipo: SRV-MSTR
- Dominio: Villabalter.edu
- SO: Windows Server 2019
- Versión: Datacenter
- Tipo de disco duro: NVMe (Partición GPT)
- Direcciones ip:
  - Interfaz de internet: DHCP(NAT)
  - Interfaz local: 192.168.1.254
- Dirección MAC: 00:50:56:38:2A:4B
- DNS: Villabalter
  -  DNS principal: Servidor
  -  DNS secundario: 8.8.4.4 (Google)

### Configuración básica

Como primer paso a la instalación y configuración de este dominio educativo va a ser, tener una máquina Windows Server 2019. 

Los primeros pasos en esta configuración básica es establecer el nombre del equipo y la/las direcciones ip.

- Nombre equipo: SRV-MSTR
- Interfaz de internet: DHCP
- Interfaz de Red local: 192.168.1.0/24 -> Ip servidor: 192.168.1.254/24

### Alta disponibilidad

Como configuración de alta disponibilidad al servidor le vamos a añadir dos NvMe en los cuales vamos a tener redundancia en forma de espejo RAID-1, para salvar la información en caso de fallo de uno de los discos

Formaremos un RAID1 con dos discos NVME

### Instalación de servicios

Obviamente como controlador principal de nuestro dominio, tenemos que instalar el rol de Active Directory y DNS.

#### Roles: 

- Servicios de dominio de ACtive Directory
- DNS
- Servicios de impresión y documentos

#### Opciones del controlador

- Nombre del bosque: Villabalter.edu
- Nivel funcional del bosque y dominio: Windows Server 2016
- Contraseña: Villabalter1 (La he establecido así en la MV. En un entorno real deberá de ser como la siguiente: **I36m}0":2?Zw**)
- Nombre dominio NETBIOS: VILLABALTER
- Carpetas
  - Base de datos: C:\Windows\NTDS
  - Archivos de registro: C:\Windows\NTDS
  - SYSVOL: C:\Windows\SYSVOL

#### Servicio de impresión
A parte de estos roles,vamos a instalarle la característica de impresoras para que, en el caso de que un profesor necesite imprimir algo desde el aula, pueda imprimir por red.

Existirá una impresora en el aula de profesores conectada a la red del servidor 

Nombre impresora: IMP-PROF
Dirección IP: 192.168.1.230

##### Panel Web

 (Apuntar lo que contiene el panel web)

##### Servicio LPD

Este servicio entrará en funcionamiento cuando algún equipo UNIX, ya sea en físico o en máquina virtual, necesite realizar alguna impresión. (Tiene que estar dentro del dominio)

El servidor desplegará la impresora compartida en todo el dominio

### Unidades organizativas
Vamos a establecer la siguiente estructura de unidades organizativas.

Entenderemos mejor así la estructura de nuestro dominio

- Dominio Principal
  - Ciclos
    - ASIR
      - Primero
        - Aula 200
        - Alumnos
        - Profesores
      - Segundo
        - Aula 202
        - Alumnos
        - Profesores
    - SMR
      - Primero
        - Aula 100
        - Alumnos
        - Profesores
      - Segundo
        - Aula 101
        - Alumnos
        - Profesores
    - DAM
      - Primero
        - Aula 300
        - Alumnos
        - Profesores
      - Segundo
        - Aula 303
        - Alumnos
        - Profesores
    - DAW
      - Primero
        - Aula 400
        - Alumnos
        - Profesores
      - Segundo
        - Aula 404
        - Alumnos
        - Profesores
  - Sala de Profesores
    - Equipos
    - Impresoras
  - Aulas
    - Aula 200
    - Aula 202
    - Aula 100
    - Aula 101
    - Aula 300
    - Aula 303
    - Aula 400
    - Aula 404