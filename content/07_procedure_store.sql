-- Ejercicio 1
-- Crea un procedimiento almacenado llamado add_student que:

-- Reciba nombre, apellido, email y ciudad como parámetros.
-- Inserte un nuevo estudiante en la tabla student.
-- Muestre el ID generado y el nombre completo.

    CREATE or REPLACE PROCEDURE ()
    LANGUAGE plpgsql
    as $$
    DECLARE
    ;
    BEGIN
    END;
    $$

CREATE or REPLACE PROCEDURE add_student(
	v_firstname text,
	v_lastname text,
	v_email text,
	v_city text
)
LANGUAGE plpgsql
AS $$
DECLARE
	v_student_id int;
BEGIN
	INSERT INTO student
	(first_name,last_name,email,city,enrollment_date,status)
	VALUES(v_firstname,v_lastname,v_email,v_city,current_date,'active')
	RETURNING id INTO v_student_id;

	RAISE NOTICE 'ID student: %',v_student_id;
END;
$$
CALL add_student('juan','torrez','juan.torrez1@gmail.com','Tarija')

SELECT * from
student


-- Ejercicio 2
-- Crea un procedimiento almacenado que reciba el ID de un estudiante 
-- y un nuevo estado.
-- El procedimiento debe actualizar el campo status en 
-- la tabla student y mostrar un mensaje confirmando el cambio.

CREATE OR REPLACE PROCEDURE update_status(
	v_student_id int,
	v_status text
)
LANGUAGE plpgsql
AS $$
BEGIN
	update student
	set status=v_status
	where id = v_student_id;

	RAISE NOTICE 'El estudiante: % fue actualizado con el estado: %',
	v_student_id,v_status;
END;
$$
CALL update_status(3,'active')

SELECT * from student

-- Ejercicio 3
-- Crea un procedimiento almacenado que:

-- Reciba los datos de un estudiante (nombre, apellido, email y ciudad) y el ID de una sección por defecto.
-- Inserte el nuevo estudiante en la tabla student con la fecha actual y estado 'active'.
-- Matricule automáticamente al estudiante en la sección indicada insertando en la tabla enrollment.
-- Muestre un mensaje confirmando el ID del estudiante y el ID de la matrícula generados.



-- Ejercicio 4
-- Crea un procedimiento almacenado llamado enroll_if_not_exists que:

-- Reciba el ID de un estudiante y el ID de una sección.
-- Verifique si el estudiante ya está matriculado en esa sección.
-- Si no lo está, lo inserte en la tabla enrollment con fecha actual y estado 'enrolled'.
-- Si ya existe la matrícula, muestre un mensaje indicando que el estudiante ya está matriculado.
-- Mostrar el resultado de la operación.

