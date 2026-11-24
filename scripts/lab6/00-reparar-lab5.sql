WHENEVER SQLERROR EXIT FAILURE
SET FEEDBACK ON LINESIZE 150
ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER INDEX tiendasur.uk_cliente_dni RENAME TO ux_cli_dni;
COLUMN constraint_name FORMAT A16
COLUMN index_name FORMAT A12
SELECT c.constraint_name, c.index_name, i.uniqueness, i.status
  FROM dba_constraints c JOIN dba_indexes i ON i.owner = c.index_owner AND i.index_name = c.index_name
 WHERE c.owner = 'TIENDASUR' AND c.constraint_name = 'UK_CLIENTE_DNI';
EXIT
