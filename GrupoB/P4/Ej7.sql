use Cine

drop view if exists Ej7;

create view Ej7 as
select Peliculas.Titulo_pelicula, Peliculas.Nacionalidad, Directores.Nombre_director, Actores.Nombre_actor from Peliculas
inner join Directores on Directores.ID_director = Peliculas.ID_director 
inner join actuaEn on actuaEn.ID_pelicula = Peliculas.ID_pelicula
inner join Actores on Actores.ID_actor = actuaEn.ID_actor
where Peliculas.ID_pelicula = actuaEn.ID_pelicula and  Peliculas.ID_director = Directores.ID_director
order by Peliculas.Titulo_pelicula;
-- group by Peliculas.ID_pelicula, Titulo_pelicula, Directores.Nombre_director, Actores.Nombre_actor;