delimiter //

drop procedure if exists consultaPorNacionalidad//

create procedure consultaPorNacionalidad (in Nacionalidad varchar(20))
begin
    select * from Peliculas where Peliculas.Nacionalidad = Nacionalidad;  
    select * from Directores where Directores.Nacionalidad =Nacionalidad;
    select * from Actores where Actores.Nacionalidad =Nacionalidad;
end //

delimiter ;
