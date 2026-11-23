He leído la política de uso de IA de la asignatura.

# Declaración de uso de IA · Lab 6 · E0NN

<!--
CÓMO SE RELLENA (léelo y borra este comentario si quieres; el script de evaluación lo ignora)
- La PRIMERA línea es obligatoria y no se toca: «He leído la política de uso de IA de la asignatura.»
- Copia este archivo como docs/bitacora/lab6-ia.md (junto a lab6-respuestas.md) y pon tu código en el título.
  Cada laboratorio tiene el suyo: en el Lab 7 será docs/bitacora/lab7-ia.md.
- Si NO has usado IA: deja solo la línea «No he usado IA.» y borra la entrada de ejemplo.
- Si la has usado: borra la línea «No he usado IA.» y escribe UNA entrada por cada uso, con los 7 campos.
  Un campo vacío es una entrada incompleta (D3: −0,5 por entrada).
- Preguntar a la IA como tutor o corregir la ortografía de un texto propio está permitido: decláralo también.
  Si no copiaste código, escribe «no aplica» en «Código recibido» y en «Evidencia de ejecución» (no cuentan como vacíos).
  Los demás campos son siempre obligatorios.
- Una entrada con TODOS los campos vacíos (la de ejemplo sin tocar) no cuenta: se ignora.
- El código copiado de una IA puntúa si lo EJECUTAS en tu contenedor, lo EXPLICAS con tus palabras,
  dices para qué lo usaste y adjuntas aquí el código y el prompt LITERAL.
-->

## Entrada 1
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
Vamos a hacer esta practica con Docker, partiendo de otro laboratorio anterior, lee todo el documento y empecemos por la parte A, solo tengo pensado usar la IA en las partes de verificacion o cuando salga algun error. El laboratio parte de mi repositorio en https://github.com/jcimbernon-kmo/oracle-database-lab. Te paso tambien los archivos que el tutor nos ha dado en la carpeta a la que tienes acceso "C:\Users\jcimb\Downloads\P2_Lab6_v1.3_Estudiante".
```
- **Código recibido (el fragmento, o la ruta del archivo donde está):** no aplica
- **Dónde lo usé (parte, script o pregunta):** Parte A (A.1 a A.6)
- **Propósito (para qué lo necesitaba):** [ESCRIBE TÚ]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [ESCRIBE TÚ: qué te explicó la revisión]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** no aplica

## Entrada 2
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
[PEGA del chat tu mensaje completo que empieza por «No los lista, los copio manualmente?:»]
```
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
```bash
cp -r /mnt/c/Users/jcimb/Downloads/P2_Lab6_v1.3_Estudiante/repo-kit/. ~/oracle-database-lab/
```
- **Dónde lo usé (parte, script o pregunta):** Parte A.2
- **Propósito (para qué lo necesitaba):** [ESCRIBE TÚ]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [ESCRIBE TÚ: qué significa el «/.» y qué archivos sobrescribió]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** los archivos del kit en el commit de la Parte A; [ruta del log _00-alumno], que solo funciona con el kit copiado

## Entrada 3
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
[PEGA del chat tu mensaje con la salida «ESTUDIANTE debe ser tu código de la lista de clase…»
 y después el de la salida «11:ESTUDIANTE=""$»]
```
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
```bash
grep -n 'ESTUDIANTE' config/.env | cat -A
grep -c $'\r' config/.env
sed -i 's/^ESTUDIANTE=""/ESTUDIANTE="E0NN"/' config/.env   # SOLO si lo usaste; si lo pusiste con nano, borra esta línea
```
- **Dónde lo usé (parte, script o pregunta):** Parte A.3
- **Propósito (para qué lo necesitaba):** [ESCRIBE TÚ]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [ESCRIBE TÚ: qué muestran cat -A y $'\r', y por qué fallaba alumno.sh]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):** [ruta del log _00-alumno]

## Entrada 4
- **Herramienta:** Claude (Anthropic)
- **Prompt (literal, copiado tal cual):**
```text
[PEGA del chat, en orden, tres mensajes tuyos:source scripts/deployment/env/00-config.sh
df -h ~        # necesitas al menos 4 GB libres
bash scripts/ops/backup-estado.sh lab6-inicio \
  | tee "$EVID_LAB6/script/$(ts)_00-backup-lab6-inicio.script.log"
 1) el que empieza por «juancarlos@HP15:~/oracle-database-lab$ git switch main» (verificación del Lab 5 con 1 FALLO)
 2) «Sale error:» con el ORA-01408
 3) la salida del diagnóstico con UK_CLIENTE_DNI]
```
- **Código recibido (el fragmento, o la ruta del archivo donde está):**
  - Primera versión de scripts/lab6/00-reparar-lab5.sql (falló con ORA-01408; sustituida después):
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
  - scripts/lab6/00-reparar-lab5.sql (versión final: ALTER INDEX ... RENAME)
- **Dónde lo usé (parte, script o pregunta):** Parte A.1 (prerrequisito: 16-verificacion-final.sh del Lab 5 en TODO OK)
- **Propósito (para qué lo necesitaba):** [ESCRIBE TÚ]
- **Qué hace (con mis palabras; línea a línea si es SQL corto):** [ESCRIBE TÚ: qué hace cada uno de los tres scripts y por qué renombrar era suficiente]
- **Evidencia de ejecución (archivo de docs/bitacora/lab6/evidencia con mi cabecera):**
  - [ruta del log _00-reparar-lab5 de las 12:27 (ORA-01408)]
  - [ruta del log _00-diagnostico-dni]
  - [ruta del log _00-reparar-lab5 de las 12:30 (Index altered)]
