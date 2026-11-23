SET LINESIZE 150 FEEDBACK ON
ALTER SESSION SET CONTAINER = FREEPDB1;
COLUMN owner FORMAT A12
COLUMN index_name FORMAT A22
SELECT i.owner, i.index_name, i.uniqueness, i.status, i.visibility,
       (SELECT COUNT(*) FROM dba_ind_columns x WHERE x.index_owner = i.owner AND x.index_name = i.index_name) AS n_columnas
  FROM dba_indexes i JOIN dba_ind_columns c ON c.index_owner = i.owner AND c.index_name = i.index_name
 WHERE c.table_owner = 'TIENDASUR' AND c.table_name = 'CLIENTE' AND c.column_name = 'DNI';
SELECT constraint_name, constraint_type FROM dba_constraints
 WHERE owner = 'TIENDASUR' AND table_name = 'CLIENTE' AND constraint_type IN ('U', 'P');
EXIT
