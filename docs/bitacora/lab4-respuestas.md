# Respuestas del Laboratorio 4: Oracle DBA Workflow I

## 8. Preguntas de comprobación

### 8.1. Respaldo
1. Con SHUTDOWN IMMEDIATE (checkpoint completo). Con la base abierta seria inconsistente y requeriria aplicar logs de redo con RMAN
2. Verifican el origen y la integridad bit a bit de la copia antes de sobreescribir el volumen
3. RTO:** RPO = perdida de datos aceptada, RTO = tiempo de restauracion

### 8.2. Diagnóstico y correcciones
4. "$ORACLE_HOME/dbs "por usar ruta relativa sin configurar OMF
5. Solo actualiza el puntero en el control file; la copia fisica del archivo en el SO debe realizarse previamente
6. Las migraciones aplicadas no se editan, se usa "NO AUTHENTICATION" para invalidar credenciales expuestas en la BBDD
7. Demuestra que al destruir el contenedor los datos sobreviven en el volumen persistente `oralab-26ai-data`.

### 8.3. Instancia y arranque
8. Instancia = SGA, PGA, procesos (`v$instance`); Base = datafiles, control files, redo logs (`v$database`).
9. NOMOUNT lee SPFILE; MOUNT abre control files; OPEN abre datafiles/redo logs.
10. Se abre automáticamente gracias al estado guardado (`SAVE STATE` en `dba_pdb_saved_states`).
11. Ruido conocido por falta de capacidades de rendimiento en el contenedor Docker.

### 8.4. Parámetros
12. v$parameter refleja valores activos en memoria; v$spparameter muestra lo escrito persistentemente en el SPFILE.
13. Aplica el cambio en memoria y en el SPFILE inmediatamente.
14. Aunque la vista indique de forma genérica su modificabilidad, dimensiona estructuras reservadas al arrancar la SGA (ORA-02095).
15. Detecta modificaciones no autorizadas en la configuración al comparar la foto de la instancia con Git.

### 8.5. Memoria y procesos
16. ASMM gestionado mediante sga_target = 1536M y pga_aggregate_target = 512M con memory_target = 0.
17. Ronda 1 (fría) requirió lecturas físicas en disco; Ronda 2 (caliente) tuvo 0 lecturas físicas al encontrar los bloques en el Buffer Cache.
18. No se suma directamente porque incluye la SGA compartida mapeada en todos los procesos.
19. v$process.spid guarda el PID dentro del namespace del contenedor, docker top muestra el PID en la máquina anfitriona.
20. PMON limpia procesos caídos y libera bloqueos, SMON realiza la recuperación de la instancia en el arranque.

### 8.6. Seguridad y trabajo profesional
21. Aplica el principio de mínimo privilegio. No puede alterar datos ni estructuras.
22. Eliminadas contraseñas de la línea de comandos (/ as sysdba) e invalidadas cuentas de esquema.

# Preguntas tipo examen (P1 - P12)

* **P1:** A, D
* **P2:** B 
* **P3:** A, C
* **P4:** A, C
* **P5:** B 
* **P6:** B 
* **P7:** C
* **P8:** A, C
* **P9:** B
* **P10:** A
* **P11:** C
* **P12:** B
