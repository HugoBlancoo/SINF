drop database Ej12;
create database Ej12;
use Ej12

create table table1 (
    Atributo1 int,
    Atributo2 varchar(50)
);

create table table2 (
    Atributo1 int,
    Atributo2 varchar(50)
);

create  index indice on table1 (Atributo1);


-- Paso 4: Ejecutar consultas JOIN con y sin el índice creado
-- Consulta sin índice
SELECT *
FROM table1 t1
JOIN table2 t2 ON t1.Atributo1 = t2.Atributo1;

-- Consulta con índice
SELECT *
FROM table1 t1
JOIN table2 t2 ON t1.Atributo1 = t2.Atributo1
WHERE t1.Atributo1 = 1; -- Utilizando el atributo indexado en la cláusula WHERE