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

/*Devuelve un listado con el nombre de las asignaturas,año de inicio y año de fin del curso escolar del alumno con nif 26902806M.
*/
SELECT * FROM asignatura;
SELECT A.nombre,CE.anyo_inicio,CE.anyo_fin,P.nif
FROM asignatura A
JOIN persona P ON A.id = P.id
JOIN alumno_se_matricula_asignatura AL ON AL.id_alumno = P.id
JOIN curso_escolar CE ON CE.id = AL.id_curso_escolar
WHERE P.nif = '26902806M'
;

/*Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).*/
SELECT D.nombre FROM departamento D
JOIN profesor P ON P.id_departamento = D.id
JOIN asignatura A ON A.id_profesor = P.id_profesor
WHERE A.id = 4 OR A.nombre = 'Grado en Ingeniería Informática (Plan 2015).';

/*Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.*/

SELECT DISTINCT P.nombre 
FROM persona P
JOIN alumno_se_matricula_asignatura AM ON AM.id_alumno = P.id
JOIN curso_escolar C ON C.id = AM.id_curso_escolar
WHERE C.anyo_inicio = 2018 AND C.anyo_fin = 2019 AND P.tipo = 'alumno';


/*Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. 
El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. 
El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.*/
SELECT D.nombre AS nombre_departamento, PS.nombre AS nombre_profesor, PS.apellido1, PS.apellido2
FROM departamento D
LEFT JOIN profesor P ON P.id_departamento = D.id
JOIN persona PS ON PS.id = P.id_profesor
WHERE PS.tipo = 'profesor' AND P.id_departamento IS NULL OR P.id_departamento IS NOT NULL
ORDER BY D.nombre ASC, PS.apellido1 ASC, PS.apellido2 ASC, PS.nombre ASC;

/*Devuelve un listado con los profesores que no están asociados a un departamento.*/
SELECT P.nombre AS nombre_profesor FROM persona P
JOIN profesor ON profesor.id_profesor = P.id
LEFT JOIN departamento D ON D.id = profesor.id_departamento;

/*Devuelve un listado con los departamentos que no tienen profesores asociados.*/
SELECT D.nombre AS nombre_departamento FROM departamento D
LEFT JOIN profesor P ON P.id_departamento = D.id
WHERE P.id_departamento IS NULL;

/*Devuelve un listado con los profesores que no imparten ninguna asignatura.*/
SELECT CONCAT_WS(' ', P.nombre, P.apellido1, P.apellido2) AS profesores 
FROM persona P
LEFT JOIN asignatura A ON A.id_profesor = P.id
WHERE A.id IS NULL;

/*Devuelve un listado con las asignaturas que no tienen un profesor asignado.*/
SELECT DISTINCT A.nombre 
FROM asignatura A
LEFT JOIN profesor P ON P.id_profesor = A.id_profesor
WHERE P.id_profesor IS NULL;

/*Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar.
El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.*/

SELECT D.nombre AS nombre_departamento ,A.nombre AS nombre_asignatura FROM departamento D
JOIN profesor PF ON PF.id_departamento = D.id
JOIN asignatura A ON A.id_profesor = PF.id_profesor
LEFT JOIN alumno_se_matricula_asignatura AM ON AM.id_asignatura = A.id
WHERE AM.id_asignatura IS NULL;

/*Devuelve el número total de alumnas que hay.*/
SELECT nombre,apellido1,apellido2 FROM persona 
WHERE tipo = 'alumno' AND sexo = 'M';

/*Calcula cuántos alumnos nacieron en 2005.*/
SELECT COUNT(*) AS total_alumnos_2005
FROM persona 
WHERE tipo = 'alumno' AND EXTRACT(YEAR FROM fecha_nacimiento) = 2005;

-- Calcula cuántos profesores hay en cada departamento.
-- El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento.
-- El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.

SELECT D.nombre AS nombre_departamento, COUNT(*) AS numero_profesores 
FROM departamento D
JOIN profesor PR ON PR.id_departamento = D.id
JOIN persona P ON P.id = PR.id_profesor
GROUP BY D.nombre
ORDER BY numero_profesores DESC;

/*Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. 
Estos departamentos también tienen que aparecer en el listado.*/

SELECT D.nombre AS nombre_departamento, COUNT(*) AS numero_profesores 
FROM departamento D
JOIN profesor PR ON PR.id_departamento = D.id
LEFT JOIN persona P ON P.id = PR.id_profesor
GROUP BY D.nombre
ORDER BY numero_profesores DESC;


/*Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas.
Estos grados también tienen que aparecer en el listado. 
El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.*/

SELECT G.nombre, COUNT(*) AS numero_asignaturas FROM grado G
RIGHT JOIN asignatura A ON A.id_grado = G.id_grado
GROUP BY G.nombre
ORDER BY numero_asignaturas DESC;

/*Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas.
Estos grados también tienen que aparecer en el listado. 
El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.*/

SELECT G.nombre AS grados, COUNT(*) AS numero_asignaturas FROM grado G
LEFT JOIN asignatura A ON A.id_grado = G.id_grado
GROUP BY G.nombre
ORDER BY numero_asignaturas DESC;

/*Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno,
de los grados que tengan más de 40 asignaturas asociadas.*/
SELECT G.nombre AS grados, COUNT(*) AS numero_asignaturas 
FROM grado G
RIGHT JOIN asignatura A ON A.id_grado = G.id_grado
GROUP BY G.nombre
HAVING COUNT(*) > 40
ORDER BY numero_asignaturas DESC;

/*Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. 
El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo.
Ordene el resultado de mayor a menor por el número total de crédidos.*/
SELECT G.nombre AS grados, ASI.tipo, SUM(ASI.creditos) AS total_creditos 
FROM grado G
JOIN asignatura ASI ON ASI.id_grado = G.id_grado
GROUP BY G.nombre, ASI.tipo
ORDER BY total_creditos DESC;

/*Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.*/

SELECT CE.anyo_inicio, COUNT(AM.id_alumno) AS alumnos_matriculados 
FROM curso_escolar CE
JOIN alumno_se_matricula_asignatura AM ON AM.id_curso_escolar = CE.id
GROUP BY CE.anyo_inicio;

/*Devuelve un listado con el número de asignaturas que imparte cada profesor. 
El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. 
El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas.
El resultado estará ordenado de mayor a menor por el número de asignaturas.*/

SELECT P.id, P.nombre, P.apellido1, P.apellido2, COUNT(A.id) AS numero_asignaturas 
FROM persona P 
JOIN profesor PF ON PF.id_profesor = P.id
LEFT JOIN asignatura A ON A.id_profesor = PF.id_profesor
GROUP BY P.id, P.nombre, P.apellido1, P.apellido2
ORDER BY numero_asignaturas DESC;

/*Devuelve todos los datos del alumno más joven.*/
SELECT *
FROM persona
WHERE fecha_nacimiento = (SELECT MIN(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');

/*Devuelve un listado con los profesores que no están asociados a un departamento:*/
SELECT P.* FROM profesor P
LEFT JOIN departamento D ON P.id_departamento = D.id
WHERE D.id IS NULL;
/*Devuelve un listado con los departamentos que no tienen profesores asociados:*/

SELECT * FROM profesor PF
WHERE PF.id_departamento NOT IN (SELECT id FROM departamento);

/*Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura:*/
SELECT nombre FROM departamento 
WHERE id NOT IN (SELECT id_departamento FROM profesor);

/*Devuelve un listado con las asignaturas que no tienen un profesor asignado:*/
SELECT pe.nombre, pe.apellido1, pe.apellido2, asi.id AS id_asignatura 
FROM persona pe
JOIN profesor pr ON pe.id = pr.id_profesor
LEFT JOIN asignatura asi ON pr.id_profesor = asi.id_profesor
WHERE asi.id IS NULL;