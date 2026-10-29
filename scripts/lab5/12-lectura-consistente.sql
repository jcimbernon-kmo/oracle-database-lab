-- scripts/lab5/12-lectura-consistente.sql
PROMPT ===== 1. Configuración de Undo Tablespace =====
SELECT tablespace_name, retention, status 
FROM dba_tablespaces 
WHERE contents = 'UNDO';

PROMPT ===== 2. Parámetros de Undo y Retention =====
SELECT name, value 
FROM v$parameter 
WHERE name IN ('undo_management', 'undo_tablespace', 'undo_retention');

PROMPT ===== 3. Estadísticas de Undo Segments y ORA-01555 =====
SELECT begin_time, end_time, undoblks, txncount, maxquerylen, ssolderrcnt, nspaceerrcnt
FROM v$undostat
WHERE ROWNUM <= 10
ORDER BY begin_time DESC;
