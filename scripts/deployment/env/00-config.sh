#!/usr/bin/env bash

#scripts/deployment/env/00-config.sh

#Constantes del proyecto oracle-database-lab. Uso: source scripts/deployment/env/00-config.sh

export CONT_NAME="oralab-26ai"
export VOL_NAME="oralab-26ai-data"
export IMG="container-registry.oracle.com/database/free:latest"
export PORT_DB=1521
export PORT_ORDS=8181
export SERVICE_CDB="FREE"
export SERVICE_PDB="FREEPDB1"
export BACKUP_DIR="$(pwd)/backups"
export EVID="docs/bitacora/evidencia"
export ORDS_HOME="/opt/oracle/ords"
export ORDS_CONFIG="/etc/ords/config"
export ORDS_LOGS="/var/log/ords"
export ORDS_PORT=8080

ts() { date -u +%Y%m%dT%H%M%SZ; }


#Operacion del entorno backup/restauracion y evidencia
export HELPER_IMG="ubuntu:24.04"                 # imagen auxiliar con GNU tar para copiar el volumen
export DATA_ROOT="/opt/oracle/oradata"           # punto de montaje del volumen dentro del contenedor
export EVID_LAB4="docs/bitacora/lab4/evidencia" # evidencia del Lab 4: script/, spool/, config/
export EVID_LAB5="docs/bitacora/lab5/evidencia" # evidencia del Lab 5
