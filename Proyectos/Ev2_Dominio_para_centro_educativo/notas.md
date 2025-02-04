# Nombre 
Villabalter.edu

## Ciclos

- Villabalter.edu
  - OU=Usuarios
    - OU=Profesores
      - CN=Profesor A (Usuario)
      - CN=Profesor B (Usuario)
      - CN=Profesor C (Usuario)
      - CN=Profesor D (Usuario)
    - OU=Alumnos
      - OU=ASIR
        - OU=Primero
          - CN=Alumno 1 (Usuario)
          - CN=Alumno 2 (Usuario)
          - ... (hasta 30)
        - OU=Segundo
          - CN=Alumno 31 (Usuario)
          - CN=Alumno 32 (Usuario)
          - ... (hasta 15)
      - OU=SMR
        - OU=Primero
          - CN=Alumno 46 (Usuario)
          - CN=Alumno 47 (Usuario)
          - ... (hasta 30)
        - OU=Segundo
          - CN=Alumno 76 (Usuario)
          - CN=Alumno 77 (Usuario)
          - ... (hasta 15)
      - OU=DAM
        - OU=Primero
          - CN=Alumno 91 (Usuario)
          - CN=Alumno 92 (Usuario)
          - ... (hasta 30)
        - OU=Segundo
          - CN=Alumno 121 (Usuario)
          - CN=Alumno 122 (Usuario)
          - ... (hasta 15)
      - OU=DAW
        - OU=Primero
          - CN=Alumno 136 (Usuario)
          - CN=Alumno 137 (Usuario)
          - ... (hasta 30)
        - OU=Segundo
          - CN=Alumno 166 (Usuario)
          - CN=Alumno 167 (Usuario)
          - ... (hasta 15)
  - OU=Equipos
    - OU=Aulas
      - OU=Aula 200
        - CN=PC1-Aula200 (Equipo)
        - CN=PC2-Aula200 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula200 (Equipo)
      - OU=Aula 202
        - CN=PC1-Aula202 (Equipo)
        - CN=PC2-Aula202 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula202 (Equipo)
      - OU=Aula 100
        - CN=PC1-Aula100 (Equipo)
        - CN=PC2-Aula100 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula100 (Equipo)
      - OU=Aula 101
        - CN=PC1-Aula101 (Equipo)
        - CN=PC2-Aula101 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula101 (Equipo)
      - OU=Aula 300
        - CN=PC1-Aula300 (Equipo)
        - CN=PC2-Aula300 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula300 (Equipo)
      - OU=Aula 303
        - CN=PC1-Aula303 (Equipo)
        - CN=PC2-Aula303 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula303 (Equipo)
      - OU=Aula 400
        - CN=PC1-Aula400 (Equipo)
        - CN=PC2-Aula400 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula400 (Equipo)
      - OU=Aula 404
        - CN=PC1-Aula404 (Equipo)
        - CN=PC2-Aula404 (Equipo)
        - ... (hasta 15)
        - CN=PC-Profesor-Aula404 (Equipo)
    - OU=Sala de Profesores
      - CN=PC-Profesor1 (Equipo)
      - CN=PC-Profesor2 (Equipo)
      - CN=Impresora-SalaProfesores (Equipo)
  - OU=Grupos
    - CN=Profesores (Grupo)
    - CN=ASIR1 (Grupo)
    - CN=ASIR2 (Grupo)
    - CN=SMR1 (Grupo)
    - CN=SMR2 (Grupo)
    - CN=DAM1 (Grupo)
    - CN=DAM2 (Grupo)
    - CN=DAW1 (Grupo)
    - CN=DAW2 (Grupo)

Cada uno con un aula de 15 equipos windows 10

15 Profesores que pueden impartir clase en cualquier aula


CN=Profesor A (Usuario) → Se le añadirá al grupo especial Administradores del Dominio.

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