He leído la política de uso de IA de la asignatura.

# Declaración de uso de IA · Lab 6 · E036

Todas las consultas son de una misma conversación con Claude. En los prompts que acompañaban a una salida del terminal, copio literal lo que escribí y remito al log donde está esa salida.

## Entrada 1
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Vamos a hacer esta practica con Docker, lee todo el documento y empecemos por la parte A, solo tengo pensado usar la IA en las partes de verificacion o cuando salga algun error. El laboratio parte de mi repositorio en https://github.com/jcimbernon-kmo/oracle-database-lab. Te paso tambien los archivos que el tutor nos ha dado en la carpeta a la que tienes acceso "C:\Users\jcimb\Downloads\P2_Lab6_v1.3_Estudiante".
```
  Después, en la misma Parte A: «No los lista, los copio manualmente?:» (con la salida de `ls scripts/lab6`) y la salida de `alumno.sh` con el error de ESTUDIANTE.
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
```bash
cp -r /mnt/c/Users/jcimb/Downloads/P2_Lab6_v1.3_Estudiante/repo-kit/. ~/oracle-database-lab/
grep -n 'ESTUDIANTE' config/.env | cat -A
grep -c $'\r' config/.env
```
- **Dónde lo usé (parte, script o pregunta):** Parte A completa, revision frente a mi repositorio, copia del kit (A.2) y error de ESTUDIANTE en alumno.sh (A.3)
- **Propósito (para qué lo necesitaba):** [Que claude tenga el contexto de la tarea y pueda entender futuras preguntas]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [claude clona mi repositorio y lee el PDF]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** docs/bitacora/lab6/evidencia/script/20261123T123155Z_00-alumno.script.log

## Entrada 2
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Sale error en la comprobacion del punto A.1:

juancarlos@HP15:~/oracle-database-lab$ nano scripts/lab6/00-reparar-lab5.sql      # pegar, Ctrl+O, Enter, Ctrl+X
bash scripts/ops/sysdba.sh scripts/lab6/00-reparar-lab5.sql "$EVID_LAB6/script/$(ts)_00-reparar-lab5.script.log"
bash scripts/lab5/16-verificacion-final.sh | tail -3
== EVIDENCIA alumno=E036 hora=2026-11-23T12:27:16Z origen=00-reparar-lab5
== EVIDENCIA contenedor=a994b5799b06 dbid=1509902213 arranque=2026-11-23T11:33:27 scn=6270249

Session altered.

== DNI repetidos (debe salir vacío) ==

no rows selected

CREATE UNIQUE INDEX tiendasur.ux_cli_dni ON tiendasur.cliente (dni) ONLINE
                                                               *
ERROR at line 1:
ORA-01408: such column list already indexed
Help: https://docs.oracle.com/error-help/db/ora-01408/


  [OK]    backups/ fuera de Git

RESULTADO: 1 FALLO(S). Corrige antes de abrir el PR.
```
  Antes había pegado la salida de 16-verificacion-final.sh con el FALLO «DNI único garantizado por la base», y después la del diagnóstico (está en su log).
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
  - Primera versión de scripts/lab6/00-reparar-lab5.sql (falló con ORA-01408 y la sustituí):
```sql
WHENEVER SQLERROR EXIT FAILURE
SET FEEDBACK ON LINESIZE 150
ALTER SESSION SET CONTAINER = FREEPDB1;
PROMPT == DNI repetidos (debe salir vacío) ==
SELECT dni, COUNT(*) AS veces FROM tiendasur.cliente GROUP BY dni HAVING COUNT(*) > 1;
CREATE UNIQUE INDEX tiendasur.ux_cli_dni ON tiendasur.cliente (dni) ONLINE;
SELECT index_name, uniqueness, status FROM dba_indexes WHERE owner = 'TIENDASUR' AND index_name = 'UX_CLI_DNI';
EXIT
```
  - scripts/lab6/00-diagnostico-dni.sql
  - scripts/lab6/00-reparar-lab5.sql (versión final: ALTER INDEX ... RENAME TO ux_cli_dni)
- **Dónde lo usé (parte, script o pregunta):** Parte A.1: 16-verificacion-final.sh del Lab 5 daba fallo (UX_CLI_DNI)
- **Propósito (para qué lo necesitaba):** [En el punto A.1, donde se partia del lab5, salia un error y no podia continuar]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Crea 3 scripts para repara el lab5, el 1º para buscar que fallaba, el 2º para saber que indice fallaba, y el 3º para cambiar el nombre, renombraba el indice unico sobre los DNI]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):**
  - docs/bitacora/lab6/evidencia/script/20261123T122716Z_00-reparar-lab5.script.log (ORA-01408)
  - docs/bitacora/lab6/evidencia/script/20261123T122847Z_00-diagnostico-dni.script.log
  - docs/bitacora/lab6/evidencia/script/20261123T123013Z_00-reparar-lab5.script.log (Index altered, TODO OK)

## Entrada 3
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
en la parte D.3, me sale este error:
```
  (con la salida de 03-sesiones.sh, que está en su log)
- **Código recibido (el fragmento, o la ruta del archivo donde está):** nada
- **Dónde lo usé (parte, script o pregunta):** Parte D.3: ORA-00031 y ORA-00942
- **Propósito (para qué lo necesitaba):** [Al crear la evidencia 3, queria comprobar que los fallos eran los esperados al matar la sesion]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Explica los errores y porque eran los correctos]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** nada

## Entrada 4
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Estoy en la seccion G.2, es correcto el mensaje que devuelve?:
```
  (con la salida de 06-probar-acceso.sh terminada en ORA-01918, que está en su primer log)
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
```bash
grep -n -A4 "== 4. Alta" "$EVID_LAB6"/script/*_06-gobierno-acceso*.log
```
- **Dónde lo usé (parte, script o pregunta):** Parte G, ANA_GARCIA no se creo (contraseña rechazada), cambie la contraseña y volvi a hacer G.1 y G.2
- **Propósito (para qué lo necesitaba):** [Salia un error al final del script que devolvia que no encontraba a Ana]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Busco porque no se creo el usuario Ana, y cambie la contraseña a una valida]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** el ultimo *_06-gobierno-acceso.script.log y el ultimo *_06-probar-acceso.script.log de docs/bitacora/lab6/evidencia/script/

## Entrada 5
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
En la seccion H.4 me sale esto:
```
  (con la salida de 07-adr-trazas.sh con ORA-01017, que está en su primer log). Después: «pero la contraseña anterior no cumplía los requisitos de la contraseña».
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
```bash
echo "SELECT 'app entra' AS prueba FROM dual;" > /tmp/prueba.sql
bash scripts/ops/app.sh /tmp/prueba.sql
source config/.env
{ source scripts/ops/cabecera.sh 07-realinear-app
  printf 'ALTER SESSION SET CONTAINER = FREEPDB1;\nALTER USER app_academia IDENTIFIED BY "%s";\nEXIT\n' "$APP_ACADEMIA_PWD" \
    | docker exec -i "$CONT_NAME" sqlplus -s -L / as sysdba; } \
  | tee "$EVID_LAB6/script/$(ts)_07-realinear-app.script.log"
```
- **Dónde lo usé (parte, script o pregunta):** Parte H.4: APP_ACADEMIA no entraba porque la contraseña en config/.env no coincidia con la de la cuenta
- **Propósito (para qué lo necesitaba):** [Cambie por error la contraseña de la app]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Se alineo la cuenta con la contraseña nueva del .env]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** docs/bitacora/lab6/evidencia/script/*_07-realinear-app.script.log y el ultimo *_07-adr-trazas.script.log

## Entrada 6
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Estoy en la sección i.2, es por un bloqueo de la sesion 177??
```
  Después: «Es por un bloqueo de filas? lo tiene abierto, pero no cerrado», «el usuario APP_ACADEMIA:» (con la salida de 08-diagnostico.sql, que está en su log) y «hay que forzar el cierre de la sesión 177».
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
  - scripts/lab6/08-inc601-intervencion.sql (ALTER SYSTEM KILL SESSION '177,38482' IMMEDIATE)
  - /tmp/fila101.sql (SELECT de la fila 101 en FREEPDB1, para validar)
- **Dónde lo usé (parte, script o pregunta):** Parte I.2, incidente INC-601. El diagnostico y la decision, la IA los comprobo y me dio la sentencia
- **Propósito (para qué lo necesitaba):** [Para saber si era esa la causa y me diera una sentencia para ejecutarlo]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Hace un KILL SESSION con la transaccion]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** docs/bitacora/lab6/evidencia/script/*_08-inc601-intervencion.script.log y *_08-inc601-validacion.script.log

## Entrada 7
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Estoy con la incidencia 2, mi hipotesis es que el listener esta ignoando la app y no hace conexion:
```
  (con la salida de 08-diagnostico.sql). Después: «Los 4 tienen instalcias:» (con la salida de lsnrctl), «academia app está parada?» y «entonces ya está, cómo cierro el incidente».
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
  - `docker exec "$CONT_NAME" lsnrctl status | grep -i 'service "'`
  - scripts/lab6/08-inc602-intervencion.sql (DBMS_SERVICE.START_SERVICE('academia_app') y SAVE STATE)
- **Dónde lo usé (parte, script o pregunta):** Parte I, incidente INC-602
- **Propósito (para qué lo necesitaba):** [Para comprobar mi hipotesis y me diera una sentencia]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Veritica porque el listener no conocia el servicio, app.sh entra como APP ACADEMIA, el listener vuelve a listar academia_app]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** docs/bitacora/lab6/evidencia/script/*_08-inc602-intervencion.script.log y *_08-inc602-validacion.script.log

## Entrada 8
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Estoy con la incidencia 3, veo que el usuario APP ACADEMIA esta bloqueado por eso no deja entrar a la app:
```
  (con la salida de 08-diagnostico.sql, que está en su log)
- **Código recibido (el fragmento, o la ruta del archivo donde está):** scripts/lab6/08-inc603-intervencion.sql (ALTER USER app_academia ACCOUNT UNLOCK)
- **Dónde lo usé (parte, script o pregunta):** Parte I, incidente INC-603. El diagnóstico (cuenta bloqueada) es mío; la IA me explicó la diferencia entre LOCKED y LOCKED(TIMED)
- **Propósito (para qué lo necesitaba):** [Para saber si mi teoria era correcta y compribarlo]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Hace que el script de bajas solo actue sobre las cuentas de empleados y no sobre las de la app]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** docs/bitacora/lab6/evidencia/script/*_08-inc603-intervencion.script.log y *_08-inc603-validacion.script.log

## Entrada 9
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
bien, estoy rellenando los postmortem, dime si son correctos:
```
  (con el borrador de mis tres postmortems)
- **Código recibido (el fragmento, o la ruta del archivo donde está):** nada
- **Dónde lo usé (parte, script o pregunta):** docs/bitacora/lab6-guardia.md (INC-601, INC-602 e INC-603)
- **Propósito (para qué lo necesitaba):** [Tras rellenar los postmortem, queria que los corrigiera para ver si estaban correctos]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Devuelve un texto plano con las correcciones o sugerenecias]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** nada

## Entrada 10
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Ya he realizado las preguntas de la parte J, el verificador dice que ya esta todo correcto, rellena el formulario de IA con esta conversacion
```
- **Código recibido (el fragmento, o la ruta del archivo donde está):** nada
- **Dónde lo usé (parte, script o pregunta):** este archivo: estructura de las entradas, prompts y rutas de evidencia. «Propósito» y «Qué hace» los he escrito yo
- **Propósito (para qué lo necesitaba):** [Que volcase los prompts y respuestas dadas en el archivo con la plantilla IA.md para rellenarlo yo]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [Crea el documento con la conversacion y los prompts]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** nada
