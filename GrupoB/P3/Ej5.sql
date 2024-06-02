delimiter //

drop procedure if exists peliculasPorNacionalidad //

create procedure peliculasPorNacionalidad(in nacionalidad varchar(20))
begin
    declare aux int;                        --Si no pones el aux, el valor de numPeliculas es null
    declare numPeliculas int default 0;
    
    select count(*) into aux from Peliculas where Peliculas.nacionalidad = nacionalidad;
    set @numPeliculas = aux;
end //

delimiter ;