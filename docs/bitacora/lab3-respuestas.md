1. ¿Qué diferencia hay entre una imagen y un contenedor? Usa como ejemplo lo que hiciste en los ejercicios G2 y G4.
	Una imagen es una plantilla sobre la que trabajar, un contenedor es la ejecucion de esa imagen personalizada.
	En G2 se uso la imagen hello-world para imprimir el texto, en G4 se inició un contenedor interactivo con alpine:3.20 ejecutando un sh dentro de un entorno aislado.

2. En el Ejercicio G5 el archivo nota.txt desapareció y en el G6 no. Explica por qué.
	Porque se guardo en la capa efimera del contenedor, en el G6 se guardo en un volumen persistente.

3. ¿Qué diferencia hay entre docker ps y docker ps -a, y qué significa STATUS = Exited (0)?
	Docker ps muestra todos los contenedores en ejecucion.
	Docker ps -a muestra todos los contenedores que tienes.
	STATUS = Exited (0) indica si el contenedor ha finalizado correctamente sin errores.

4. En -p 8181:8181, ¿qué número corresponde a tu equipo y cuál al contenedor? ¿Qué pasaría con -p 80:8080 en el ejercicio de nginx?
	El 1º numero es el host, el 2º es el contenedor.
	Cada entrada por el puerto 80 a tu equipo lo rediriges al contenedor con el puerto 8080.

5. ¿Por qué un contenedor de Oracle se queda en marcha y el de hello-world termina solo?
	En el hello-world finaliza porque acabo su ejecucion, al imprimir el mensaje no tenias mas tareas y se finalizo solo, en el de Oracle esta escuchando constantemente.

6. ¿Qué es el digest de una imagen y por qué lo registramos si ya sabemos que usamos :latest?
	El digest es un hash que identifica el contenido de una imagen, el :latest apunta a distintas versiones segun el paso del tiempo.

7. ¿Qué comando borraría realmente los datos de Oracle? ¿Por qué docker rm oralab-26ai no lo hace?
	docker volume rm oralab-26ai, docker rm oralab solo elimina la capa efimera del conteneodor.

8. ¿Por qué este laboratorio se hace dentro del repositorio oracle-database-lab, con Issue, branch y Pull Request, en vez de en una carpeta aparte?
	Para aprender a usar GitHub, es la forma profesional de usarlo, tener un control de las versiones y revisarlos.

9. ¿Qué diferencia hay entre source 00-config.sh y bash 00-config.sh? ¿Por qué usamos source?
	00-config.sh se destruye al terminar de ejecutar.
	bash 00-config.sh deja las variables guardadas para usarlas despues.

10. Explica cada parte del nombre 20260915T091230Z_02-docker.script.log.
	Marca la fecha y hora, año 2026, mes 09 (septiembre) y dia 15. 9h:12m:30s. 02 es la 2º prueba.

11. ¿Para qué sirve .gitattributes y qué error evita?
	Establece la finalizacion de linea para compatibilidad en sistemas Windows y Linux

12. ¿Por qué en este Pull Request elegimos Create a merge commit en lugar de Squash and merge?
	Para mantener la rama Main con todo el historial.

13. Describe las cuatro capas de la estrategia de contraseñas (Parte D) y qué pasaría si te saltas la primera.
	Capa 1: incluir .gitignore en el directorio config.
	Capa 2: versionar una plantilla libre de secretos.
	Capa 3: crear el archivo .env en /config con las contraseñas.
	Capa 4: cargas las credenciales usando set -a; source config/.env; set +a.

	Las contraseñas estarian subidas a GitHub y al internet.

14. ¿Por qué no escribimos la contraseña directamente en el comando docker run, aunque el script no se suba a Git?
	Para que no quede en el historial de comandos.

15. Si descubres tu contraseña en un commit ya publicado, ¿basta con borrarla en un commit nuevo? ¿Qué debes hacer?
	No, porque quedara en el historial de commits, hay que cambiarla.

16. ¿Por qué no usamos SPOOL ni @archivo.sql con sqlplus dentro del contenedor, y qué hicimos en su lugar?
	Porque se ejecuta internamente, se regirige la entrada del archivo desde el anfitrion.

17. ¿Qué hace WHENEVER SQLERROR EXIT SQL.SQLCODE al inicio de V000 y V001, y qué pasaría sin esa línea?
	Para la ejecucion si encuentrea un error en la ejecucion, si no se usa dejaria la creacion de la BBDD incompleta.

18. ¿Qué es una migración y por qué V000 y V001 no se deben editar una vez aplicadas?
	Aplica cambios estructurales a una BBDD, no se deben hacer porque estas modificando la BBDD original, por lo que la reproducibilidad no es posible.

19. ¿Por qué en SQL Developer se usa el servicio FREEPDB1 y no FREE ni un SID?
	FREEPDB1 es la BBDD conectable, FREE y SID se conecta a la BBDD del contenedor.

20. ¿Qué aporta SQLcl frente a SQL*Plus, y por qué un DBA debe dominar ambas?
	SQLcl es mas moderno, tiene formateo automatico, historial, etc. SQL*Plus debe conocerlo porque sigue estando presente en los servidores Oracle.

21. ¿Por qué el curso pasa de Git Bash a Ubuntu en WSL 2? Da al menos dos problemas concretos de Git Bash que desaparecen en Ubuntu.
	Para trabajar como si fuera Linux nativo.
	Fallos de asignacion en terminales interactivas.
	Ausencia de utilidades nativas de administración

22. ¿Por qué clonamos el repositorio en ~/oracle-database-lab y no trabajamos sobre la carpeta de Windows (/mnt/c/...)? ¿Y por qué recomendamos bash frente a zsh para los scripts del curso?
	Porque es la shell estandar en los servidores Linux, mejor para la compatibilidad.
