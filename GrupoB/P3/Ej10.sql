delimiter //

drop procedure if exists introducir_pelicula //

create procedure introducir_pelicula(in Titulo_pelicula varchar(50), in NacionalidadPelicula varchar(20), in IMDbPelicula int, in Nombre_director varchar(50), in Edad int, in NacionalidadDirector varchar(20), in IMDbDirector int)
begin
    declare ID_directorAux int;

    start transaction;
        INSERT IGNORE INTO Directores (ID_director, Nombre_director, Edad, Nacionalidad, IMDb)
        SELECT NULL, Nombre_director, Edad, NacionalidadDirector, IMDbDirector;

        SELECT ID_director INTO ID_directorAux FROM Directores WHERE IMDb = IMDbDirector;

        insert into Peliculas values(NULL, Titulo_pelicula, ID_directorAux, NacionalidadPelicula, IMDbPelicula);
    commit;
end //

delimiter ;