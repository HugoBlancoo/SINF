delimiter //

drop procedure if exists listar_directores_peliculas//

create procedure listar_directores_peliculas()
begin
    select Peliculas.Titulo_pelicula, Directores.Nombre_director from Peliculas
    inner join Directores
        on Peliculas.ID_director = Directores.ID_director;
end
//

delimiter ;

--para llamarla call listar_directores_peliculas();