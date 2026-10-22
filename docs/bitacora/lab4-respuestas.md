# Respuestas del Laboratorio 4: Oracle DBA Workflow I

## 8. Preguntas de comprobación

### 8.1. Respaldo
1. **Copia consistente:** Se realizó con SHUTDOWN IMMEDIATE (checkpoint completo). Con la base abierta sería inconsistente y requeriría aplicar logs de redo con RMAN.
2. **Manifiesto y SHA256SUMS:** Verifican el origen y la integridad bit a bit de la copia antes de sobreescribir el volumen.
3. **RPO y RTO:** RPO = pérdida de datos aceptada (los datos desde la copia); RTO = tiempo de restauración (~1 minuto con restaurar-estado.sh).

### 8.2. Diagnóstico y correcciones
4. **Ubicación de datafiles en V000:** Se crearon en `$ORACLE_HOME/dbs` por usar ruta relativa sin configurar OMF (`db_create_file_dest`).
5. **ALTER TABLESPACE ... RENAME DATAFILE:** Solo actualiza el puntero en el control file; la copia física del archivo en el SO debe realizarse previamente.
6. **Inmutabilidad de V000 y V003:** Las migraciones aplicadas no se editan. Se usa `NO AUTHENTICATION` (schema-only) para invalidar credenciales expuestas en la base de datos.
7. **Prueba de persistencia:** Demuestra que al destruir el contenedor los datos sobreviven en el volumen persistente `oralab-26ai-data`.

### 8.3. Instancia y arranque
8. **Instancia vs Base de datos:** Instancia = SGA, PGA, procesos (`v$instance`); Base = datafiles, control files, redo logs (`v$database`).
9. **Etapas de arranque:** NOMOUNT lee SPFILE; MOUNT abre control files; OPEN abre datafiles/redo logs.
10. **Apertura de FREEPDB1:** Se abre automáticamente gracias al estado guardado (`SAVE STATE` en `dba_pdb_saved_states`).
11. **Alert log (ORA-00800 / ORA-20013):** Ruido conocido por falta de capacidades de rendimiento en el contenedor Docker.

### 8.4. Parámetros
12. **v$parameter vs v$spparameter:** `v$parameter` refleja valores activos en memoria; `v$spparameter` muestra lo escrito persistentemente en el SPFILE.
13. **SCOPE=BOTH:** Aplica el cambio en memoria y en el SPFILE inmediatamente.
14. **PROCESSES estático:** Aunque la vista indique de forma genérica su modificabilidad, dimensiona estructuras reservadas al arrancar la SGA (ORA-02095).
15. **Versionar PFILE / Configuration Drift:** Detecta modificaciones no autorizadas en la configuración al comparar la foto de la instancia con Git.

### 8.5. Memoria y procesos
16. **Modelo de memoria:** ASMM gestionado mediante `sga_target = 1536M` y `pga_aggregate_target = 512M` con `memory_target = 0`.
17. **Experimento de caché:** Ronda 1 (fría) requirió lecturas físicas en disco; Ronda 2 (caliente) tuvo 0 lecturas físicas al encontrar los bloques en el Buffer Cache.
18. **Memoria RSS:** No se suma directamente porque incluye la SGA compartida mapeada en todos los procesos.
19. **PID en /proc vs SPID:** `v$process.spid` guarda el PID dentro del namespace del contenedor; `docker top` muestra el PID en la máquina anfitriona.
20. **PMON vs SMON:** PMON limpia procesos caídos y libera bloqueos; SMON realiza la recuperación de la instancia en el arranque.

### 8.6. Seguridad y trabajo profesional
21. **C##OPS_RO:** Aplica el principio de mínimo privilegio. No puede alterar datos ni estructuras.
22. **Exposición corregida:** Eliminadas contraseñas de la línea de comandos (`/ as sysdba`) e invalidadas cuentas de esquema.

---

## Preguntas tipo examen (P1 - P12)

* **P1:** A, D (Copia consistente tras SHUTDOWN; se abre directamente con STARTUP).
* **P2:** B (Método offline estándar para mover datafiles en Standard Edition / Free).
* **P3:** A, C (STARTUP_TIME indica el arranque de la instancia; CREATED la fecha de creación de la base).
* **P4:** A, C (En NOMOUNT solo se leen parámetros y se pueden crear control files).
* **P5:** B (El modo ARCHIVELOG requiere que la base esté en MOUNT).
* **P6:** B (Por defecto con SPFILE, un ALTER SYSTEM equivale a SCOPE=BOTH).
* **P7:** C (Un parámetro de instancia/proceso no se puede modificar desde una PDB).
* **P8:** A, C (Arrancar con PFILE conocido y regenerar el SPFILE).
* **P9:** B (ASMM gestiona la SGA respetando el valor mínimo fijado).
* **P10:** A, D (El área de ordenación y la memoria de sesión en servidor dedicado forman parte de la PGA).
* **P11:** C (LGWR debe confirmar la escritura en el redo log antes del retorno del COMMIT).
* **P12:** B, D (PMON y SMON son procesos obligatorios e indispensables para la instancia).
