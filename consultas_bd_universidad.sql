-- Consultas
/*Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. 
El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido,
segundo apellido y nombre.*/
SELECT apellido1,apellido2,nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1,apellido2,nombre;

/*Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.*/
SELECT nombre,apellido1,apellido2 FROM persona WHERE telefono IS NULL AND tipo = 'alumno';

/*Devuelve el listado de los alumnos que nacieron en 1999.*/
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento ='1999%';
