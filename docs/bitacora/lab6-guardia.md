## INC-601 · Bloqueo de Alumno 101
- Deteccion: 16:39 UTC · Ana Garcia, mediante ticket.
- Impacto: Ana Garcia no pudo guardar la ficha del alumno 101. 8 minutos.
- Diagnostico: bloqueo de filas por la sesion 177 (APP_ACADEMIA) en idle a Ana Garcia (SID 176).
- Causa raiz: dejar abierta la transaccion de la aplicacion.
- Intervencion: forzar el cierre de sesion 177 (ALTER SYSTEM KILL SESSION '177,38482' IMMEDIATE).
- Validacion: se volvio a ejecutar el diagnostico y se vio el estado de la sesion 177.
- Accion preventiva: no dejar una transaccion abierta mientras se espera usando WAIT.

## INC-602 · No hay conexion con la aplicacion (ORA-12514)
- Deteccion: 16:49 UTC · Equipo de matriculas, mediante ticket.
- Impacto: la app no puede abrir ninguna sesion. 5 minutos.
- Diagnostico: 08-diagnostico.sql, en las CDB_SERVICES existe academia_app, pero no aparece como arrancada.
- Causa raiz: el servicio de la aplicacion se detuvo con la PDB abierta, la lista solo devuelve las instancias y las PDB, pero no los servicios.
- Intervencion: (EXEC DBMS_SERVICE.START_SERVICE), y (ALTER PLUGGABLE DATABASE FREEPDB1 SAVE STATE).
- Validacion: app.sh entra como APP ACADEMIA, el listener vuelve a listar academia_app.
- Accion preventiva: añadir a turno.sql la comprobacion servicios definidos que no estan arrancados, para detectarlo antes que el usuario.

## INC-603 · La app no entra (ORA-28000)
- Deteccion: 16:53 UTC · Equipo de matriculas, mediante ticket.
- Impacto: ninguna instancia de la app puede iniciar sesion desde las 21:00.
- Diagnostico: 08-diagnostico.sql, muestra LOCKED, pero con 10 intentos restantes por contraseña.
- Causa raiz: la cuenta se bloqueo a mano a la misma hora en la que se ejecuto el script de bajas, por lo que puso a todas las cuentas como si fuera la de un empleado.
- Intervencion: (ALTER USER app_academia ACCOUNT UNLOCK), asi no se toca la contraseña ni privilegios.
- Validacion: app.sh entra como APP ACADEMIA, en la seccion 7 del diagnostico sale vacia.
- Accion preventiva: que el script de bajas solo actue sobre cuentas de empleados y no las cuentas de aplicacion.
