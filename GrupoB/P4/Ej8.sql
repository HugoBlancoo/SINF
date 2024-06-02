-- alter table Peliculas add Año int;

update Peliculas set Año = 2001 where ID_pelicula = 1;
update Peliculas set Año = 2019 where ID_pelicula = 2;
update Peliculas set Año = 2023 where ID_pelicula = 3;
update Peliculas set Año = 2023 where ID_pelicula = 4;
update Peliculas set Año = 1982 where ID_pelicula = 5;
update Peliculas set Año = 1993 where ID_pelicula = 6;
update Peliculas set Año = 2023 where ID_pelicula = 7;

drop view if exists Ej8;

create view Ej8 as
select * from Peliculas
where Peliculas.Año < 2000 and Peliculas.Año >= 1900;