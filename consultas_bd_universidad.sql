-- Consultas
/*Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. 
El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido,
segundo apellido y nombre.*/
SELECT apellido1,apellido2,nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1,apellido2,nombre;

/*Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su nú	mero de teléfono en la base de datos.*/
SELECT nombre,apellido1,apellido2 FROM persona WHERE telefono IS NULL AND tipo = 'alumno';

/*Devuelve el listado de los alumnos que nacieron en 1999.*/
--Consultas 
SELECT * FROM persona 
WHERE tipo = 'alumno' 
--Extract( for extrac the year)
AND EXTRACT(YEAR FROM fecha_nacimiento) = 1999;

--Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
--Buscar el ultimo %
SELECT * FROM persona WHERE telefono IS NULL AND nif LIKE '%K';

--Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
--SELECT * FROM asignatura;
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

--Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
--SELECT * FROM persona;

SELECT * FROM persona P
JOIN alumno_se_matricula_asignatura AM  ON P.id = AM.id_alumno
WHERE P.tipo = 'alumno' AND P.sexo = 'M'AND AM.id_asignatura = 4;

-- Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).

SELECT A.nombre FROM asignatura A
JOIN grado G ON A.id_grado = G.id_grado
WHERE A.id_grado = 4;

/*Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados.
El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. 
El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.*/

select * from departamento;

SELECT P.nombre, P.apellido1, P.apellido2, D.nombre
FROM persona P
JOIN profesor PR ON P.id = PR.id_profesor
JOIN departamento D ON D.id = PR.id_departamento
ORDER BY P.apellido1,P.apellido2,P.nombre;

/*Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.*/
SELECT * FROM asignatura;
