1. Compara el paso 6 de tu copia lab4-final con el de la copia lab3-final. ¿Qué demuestra la diferencia? 
Demuestra el efecto de la activacion del modo ARCHIVELOG y la gestion de copias de seguridad. En lab3-final los cambios no archivados provocan perdida de datos irreparables ante un fallo, en lab4-final la cadena de Archive Logs permite reconstruir el estado exacto sin perder transacciones

2. Calcula el factor de bloqueo (bfr) de CLIENTE y de PEDIDO con sus estadísticas. ¿Por qué PEDIDO cabe casi el 
triple de filas por bloque?
PEDIDO tiene un tamaño medio de fila significativamente menor que CLIENT, al ocupar menos bytes por registro, un unico bloque de 8KB puede albergar casi 3 veces mas filas de PEDIDO

3. ¿Por qué el banco de medida ejecuta cada sentencia dos veces y mide solo la segunda?
La primera ejecucion realiza lecturas fisicas de disco a memoria, parseo del SQL y llenado de la Buffer Cache y Shared Pool. La segunda evalua el rendimiento puro en memoria

4. Con tu evidencia 02: altura, número de hojas y factor de ramificación (fan-out) real de IX_PED_CLIENTE. ¿Qué 
altura tendría con mil millones de filas?
Para 10^9 filas, la altura del arbol B-Tree solo se incrementaria a 4 o 5

5. En el volcado de la hoja de PK_CLIENTE, localiza una entrada y descompón el ROWID que guarda en bloque y 
fila. ¿Por qué no aparece el número de archivo?
El bloque hoja guarda una estructura comprimida de ROWID restringido con el numero de bloque relativo y el indicee de fila, no incluye el numero de archivo relativo dentro de cada clave individual

6. Elige tres pruebas de la Parte D y explica, con las lecturas lógicas medidas, por qué un tipo de índice gana al otro.
El B-Tree gana con 3 lecturas logicas frente a miles de un Full Table Scan por acceso directo
Un Bitmap Index o un FTS gana a una B-Tree tradicional porque este necesita varios saltos aleatorios
El B-Tree gana al no requerir acceso a los bloques de datos de la tabla, reduciendo las lecturas logicas al leer solo las hojas del indice.

7. ¿Por qué IX_PED_FECHA tiene un clustering factor cercano al número de bloques e IX_PED_CLIENTE cercano 
al de filas? ¿Lo arreglaría un REBUILD?
IX_PED_FECHA tiene un Clustering Factor bajo porque los datos se insertaron cronologicamente, haciendo coincidir el orden del indice con el orden fisico de las filas en disco. En IX_PED_CLIENTE, los IDs de cliente se reparten aleatoriamente por la tabla. Un REBUILD del indice no lo arregla, porque lo que esta desordenado es la tabla fisica en disco

8. Según tu curva de la Parte E, ¿a partir de qué porcentaje deja de compensar cada índice? Compáralo con la 
fórmula de la Unidad 3.
Deja de compensar entre el 2 y el 5% de selectividad de la tabla cuando el Clustering Factor es malo, la formula teorica donde el coste de lecturas logicas aleatorias por indice (Coste = Hojas + Filas / Factor) supera el coste del escaneo completo secuencial optimizado por lecturas multibloque

9. Explica por qué Q4b ('Gonz%') usa el índice y aun así lee más bloques que un recorrido completo.
Porque al no ser altamente selectiva y tener un Clustering Factor desfavorable, el optimizador decide usar el indice, pero la ejecucion debe leer mutiples bloques de hojas del indice

10. Con tu evidencia 06: bloques modificados por INSERT con 4, 9 y 5 índices. ¿Qué índices de la propuesta del 
compañero rechazaste y con qué dato?
A medida que aumenta el nº de indices, los bloques modificados por INSERT y el redo generado crecen exponencialmente debido al mantenimiento de las estructuras B-Tree. Se rechazaron los índices redundantes sobre columnas de baja cardinalidad o compuestas cuyos bloques inserción sin ofrecer mejoras significativas en lecturas.

11. Distingue, con tus gráficos de la Parte H, un índice con divisiones 50/50, uno con divisiones 90/10 y uno con 
patrón cola. 
12. ¿Qué remedio elegirías para el patrón cola en producción, en horario de servicio, y por qué? 
13. Con tu evidencia 08: ¿qué valores compara Oracle al abrir para decidir si hace falta recuperación? 
14. ¿Qué protege la multiplexación del control file en el mismo volumen y qué no? ¿Cómo se haría en producción? 
15. Explica los estados CURRENT, ACTIVE e INACTIVE con tu evidencia 10 y por qué Oracle rechaza los tres 
borrados del paso 4. 
16. Describe la cadena de causas del escenario de la FRA llena, desde ORA-19815 hasta que la base deja de 
aceptar cambios. 
17. Explica, con los pasos 1 a 4 de tu evidencia 12, la frase "lectores no bloquean a escritores". 
18. ¿Por qué un DELETE genera más undo que un INSERT? ¿Por qué el ROLLBACK también genera redo? 
19. Con tu evidencia 13: ¿dónde está la garantía de durabilidad justo después del COMMIT? ¿Y después del 
checkpoint? 
20. Simulacro A: explica roll forward y roll back con las filas 102 y 103 y las líneas del alert log. 
21. Simulacros C y D: tu RTO y tu RPO en cada uno. ¿Por qué son tan distintos? 
22. Clasifica cada error ORA- del bloque 5 de tu runbook: incidente real, efecto del laboratorio o ruido conocido.