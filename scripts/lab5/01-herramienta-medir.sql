-- scripts/lab5/01-herramienta-medir.sql — el banco de medida del Lab 5: un paquete que ejecuta una sentencia y
dice lo que costó
-- Se ejecuta como SYSDBA: bash scripts/ops/sysdba.sh <este archivo> <evidencia>
-- Vive en un esquema de herramientas propio (LAB_TOOLS, sin contraseña): nada de código de laboratorio dentro
de SYS ni de TIENDASUR.
-- Derechos del definidor (AUTHID DEFINER): las sentencias se ejecutan con los privilegios de LAB_TOOLS, que
solo alcanzan a TIENDASUR.
-- (Con AUTHID CURRENT_USER, SYS tendría que "prestar" sus privilegios: ORA-06598, INHERIT PRIVILEGES. Oracle lo
impide por algo.)
-- lab_tools.medir.consulta('etiqueta', 'SELECT ...') -> filas, lecturas lógicas y físicas, tiempo y plan
real
-- lab_tools.medir.dml('etiqueta', 'UPDATE ...') -> lecturas, bloques modificados, redo y tiempo;
deshace el cambio
-- Cada sentencia se ejecuta dos veces y se mide la segunda (en caliente), como en un banco de pruebas serio.
WHENEVER SQLERROR EXIT FAILURE
ALTER SESSION SET CONTAINER = FREEPDB1;
DECLARE n NUMBER;
BEGIN
SELECT COUNT(*) INTO n FROM dba_users WHERE username = 'LAB_TOOLS';
IF n = 0 THEN EXECUTE IMMEDIATE 'CREATE USER lab_tools NO AUTHENTICATION'; END IF;
END;
/
GRANT SELECT ON sys.v_$mystat TO lab_tools;
GRANT SELECT ON sys.v_$statname TO lab_tools;
GRANT SELECT ON sys.v_$sql TO lab_tools;
GRANT SELECT ON sys.v_$sql_plan TO lab_tools;
