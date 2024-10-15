[Volver al indice de la unidad](../../index.md)

# Programación de tareas con ```cron```

Para esta práctica utilizare un ubuntu 22.04

## 1. ¿Con qué orden pondría con crontab los siguientes casos?

1. La tarea se ejecuta cada hora
   - 0 * * * *

2. La tarea se ejecuta los domingos cada 3 horas
   - 0 */3 * * 0

2. La tarea se ejecuta a las 12 de la mañana los días pares del mes.
   - 0 0 */2 * *

2. La tarea se ejecuta el primer día de cada mes a las 8 de la mañana y a las 8 de la tarde.
   - 0 8 1 * *
   - 0 20 1 * *

2. La tarea se ejecuta cada media hora de lunes a viernes.
   - */30 * * * 1-5

2. La tarea se ejecuta cada cuarto de hora, entre las 3 y las 8, de lunes a viernes, durante todo el mes de agosto
   - */15 3-8 * 8 1-5

2. La tarea se ejecuta cada 90 minutos
   - */90 * * * *

## 2. Como comprobar que el servicio cron está ejecutándose

Para saber si el servicio ```cron``` está activo tendremos que hacer lo siguiente: