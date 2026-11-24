1. ¿Cuántos errores ORA- tenía tu alert log en 24 h en la Parte B y a qué se debían? ¿Por qué ese número no es una alarma por sí solo?
    4 errores ORA, no es una alarma porque son comparaciones respecto a la linea base

2. ¿A qué hora empieza y cuánto dura la ventana de mantenimiento de un miércoles en tu base? ¿Qué tareas automáticas corren en ella?
    El miercoles, WEDNESDAY_WINDOW, a las 22:00 (byday=WED;byhour=22), dura 4 horas. Ejecutan auto optimizer stats collection, auto space advisor y sql tuning advisor

3. Explica con tu salida de la Parte C la diferencia entre lo que mostraban V$SPPARAMETER y V$PARAMETER tras el SCOPE = SPFILE. ¿Qué habría pasado en el siguiente reinicio sin el RESET?

4. ¿Por qué RESET fue la vuelta atrás correcta para db_files y no lo habría sido para processes? Cita la línea de tu PFILE que lo demuestra.

5. Tras el reinicio sin estado guardado, ¿qué error obtuvo C##OPS_RO y por qué la instancia decía «Database opened»?
    ORA-01109. Database opened es por el CDB, antes se hizo DISCARD STATE, FREEPDB1 no tenía estado guardado y se quedó en MOUNTED. El listener seguía activo y entregaba conexiones, pero la PDB no estaba abierta

9.1.1. Partes D-E · Servicios, sesiones y diccionario
6. ¿Qué SID, SPID y evento tenía la sesión de la aplicación en tu ejecución? ¿Qué te dicen MODULE, ACTION y CLIENT_IDENTIFIER que no te diría USERNAME?
    SID 213, SERIAL# 63078, SPID 3715, evento PL/SQL lock timer. USERNAME solo dice la cuenta técnica, APP_ACADEMIA, que comparten todas las instancias y todos los usuarios de la aplicación. En cambio, MODULE = matriculas y ACTION = cierre-periodo dicen qué función de la aplicación hace esa sesión. CLIENT_IDENTIFIER = ana.garcia@ucam dice qué persona está detrás. Es lo que necesitas para hablar con el dueño antes de intervenir.

7. Tras CANCEL SQL, ¿cuántas transacciones abiertas tenía la aplicación? ¿Y tras KILL SESSION? ¿En qué estado quedó la fila 101 y por qué?
    Tras CANCEL SQL quedaba 1 transacción abierta: cayó la llamada, el SLEEP, con ORA-01013, pero la sesión siguió viva («sigo viva»). Tras KILL SESSION quedaron 0 sesiones y 0 transacciones. La fila 101 quedó en ACTIVO porque el UPDATE no estaba confirmado: al terminar la sesión, PMON lo deshizo. Matar una sesión nunca confirma su trabajo.

8. ¿Qué valor tiene common_user_prefix en tu imagen? ¿Qué implica para el nombre de una cuenta común?
    common_user_prefix = C##. Toda cuenta comun

9. Completa con tus cifras la tabla de las tres miradas (ALL_TABLES, DBA_USERS, CDB_USERS, V$DATAFILE) y explica una diferencia.
    Vista       C##OPS_RO en CDB$ROOT   C##OPS_RO por freepdb1  APP_ACADEMIA por academia_app
    ALL_TABLES  0                       0                       1
    DBA_USERS   37                      47                      ORA-00942
    CDB_USERS   37                      47                      ORA-00942
    V$DATAFILE  17                      10                      ORA-00942

10. Con tu salida de 04-deltas: ¿cuántas lecturas lógicas por recorrido y cuánto DB time costó la carga? ¿Qué indica la relación entre DB time y DB CPU?
    5372 lecturas lógicas, con DB time 0,34s y DB CPU 0,25s, en 0,33ss de reloj. Casi todo el tiempo fue trabajo en CPU sobre bloques que ya estaban en la buffer cache, el resto fueron esperas, no hubo un cuello de botella

9.1.2. Partes F-G · Espacio y acceso
11. Da las tres medidas (asignado, libre, máximo) de TBS_ACADEMIA_HIST antes de la carga y explica cuál usarías para alertar.
    El umbral de la parte F, aviso al 80 % y crítico al 95 %

12. ¿Quién insertó y quién «pagó» en el ORA-01950? ¿Por qué ampliar el tablespace no habría resuelto el ORA-01536?
    Inserto SYS, porque el script lo ejecuta sysdba.sh, pero pago CARGA_HIST. Ampliar el tablespace no lo hubiera resuelto porque el tablespace tenia sitio.

13. ¿Cuánto tiempo estuvo suspendida la carga reanudable y qué evidencia de ello dejó Oracle en el alert log?
    La sentencia quedo suspendida 15s. En el alert log esta en statement in resumable session 'carga-historico' was suspended due to (con el ORA-01536), y was resumed

14. Antes y después del SHRINK: filas, bloques y cuota consumida. ¿Por qué un DELETE no devolvió el espacio?
            Filas   Bloques Cuota
    Antes   20000   2944    23
    Despues 2000    304     2,4

15. ¿Qué valores tenía tu perfil DEFAULT? Justifica dos de los límites de PRF_PERSONAS para una persona de secretaría.
    El perfil DEFAULT tiene FAILED_LOGIN_ATTEMPTS 10, PASSWORD_LOCK_TIME 1, PASSWORD_LIFE_TIME 180, PASSWORD_GRACE_TIME 7, INACTIVE_ACCOUNT_TIME 365, PASSWORD_REUSE_MAX/TIME UNLIMITED, PASSWORD_ROLLOVER_TIME 0 y PASSWORD_VERIFY_FUNCTION NULL. Tenia los 10 intentos aun disponibles, tambien obliga a usar contraseñas robustas.

16. ¿Por qué Ana pudo leer ACA_MATRICULAS si nadie se la concedió por nombre? ¿Qué error obtuvo al cambiar el nombre de un alumno?
    Por el privilegio de esquema SELECT ANY TABLE ON SCHEMA admin_academia, por lo que cubre todas las tablas del esquema. Al cambiar el nombre se obtiene ORA-41900, porque solo tiene UPDATE, el privilegio sobre esa columna

9.1.3. Partes H-I · Objetos, diagnóstico y guardia
17. ¿Qué objetos se invalidaron en cada uno de los tres cambios de columna y por qué no se invalidó nada con la columna nueva?
    Columna nueva: no se invalida nada, los objetos dependen de las columnas que usan, no de la tabla entera, y no se usaba la nueva
    Ampliar email_institucional: invalida V_CONTACTO_LAB6
    Ampliar nombres: invalida V_ACTIVOS_LAB6 y, en cascada, F_TOTAL_ACTIVOS_LAB6, porque la función depende de la vista

18. Según tus advisors, ¿mejoraría el DB time duplicar la SGA? ¿Y por debajo de qué tamaño la PGA tendría sobreasignaciones?

19. ¿Cuántas lecturas lógicas necesitó la consulta de la aplicación según la traza (o tkprof)? ¿Qué línea de la traza lo dice?
    Necesita 247 lecturas, en la línea FETCH #128716427042480:...,cr=247

20. Para cada incidente de la guardia: evidencia clave, intervención y validación (una línea por cada uno).
    ## INC-601 · Bloqueo de Alumno 101
    - Diagnostico: bloqueo de filas por la sesion 177 (APP_ACADEMIA) en idle a Ana Garcia (SID 176).
    - Intervencion: forzar el cierre de sesion 177 (ALTER SYSTEM KILL SESSION '177,38482' IMMEDIATE).
    - Validacion: se volvio a ejecutar el diagnostico y se vio el estado de la sesion 177.

    ## INC-602 · No hay conexion con la aplicacion (ORA-12514)
    - Diagnostico: 08-diagnostico.sql, en las CDB_SERVICES existe academia_app, pero no aparece como arrancada.
    - Intervencion: (EXEC DBMS_SERVICE.START_SERVICE), y (ALTER PLUGGABLE DATABASE FREEPDB1 SAVE STATE).
    - Validacion: app.sh entra como APP ACADEMIA, el listener vuelve a listar academia_app.

    ## INC-603 · La app no entra (ORA-28000)
    - Diagnostico: 08-diagnostico.sql, muestra LOCKED, pero con 10 intentos restantes por contraseña, por lo que es un bloqueo manual.
    - Intervencion: (ALTER USER app_academia ACCOUNT UNLOCK), asi no se toca la contraseña ni privilegios.
    - Validacion: app.sh entra como APP ACADEMIA, en la seccion 7 del diagnostico sale vacia.