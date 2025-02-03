# Nombre 
Villabalter.edu

## Ciclos

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

Cada uno con un aula de 15 equipos windows 10

15 Profesores que pueden impartir clase en cualquier aula


## Alumnos

El archivo **alumnos.csv** contiene todos los alumnos del dominio

**Obligatorio** Cada alumno tiene que tener una carpeta personal. Importante automatizarlo y unirlo utilizando el archivo alumnos.csv

Cada grupo tendrá una carpeta personal compartida por todo el grupo

Maximizar la seguridad del dominio :

    1. Utilizando politicas del dominio
       1. Al menos deben de incluir las directivas de "Configuracion de seguridad"
       2. Establecer una correecta política de excepciones


## Estructura

Modelo de dominio único


## Característica Servidor

- Nombre: SRV-MASTER
- Dominio: Villabalter.edu
- Dirección ip: Estática (192.168.1.254)
- Servicios : Active Directory, DNS, Servicio de impresión (Sala de profesores)


## Organización alumnos

- De forma automática se le establecerá una carpeta personal a cada alumno