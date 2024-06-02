delimiter //

drop procedure if exists ponerEnMayusculas //

create procedure ponerEnMayusculas(in cadena varchar(20))
begin
    declare mayuscula varchar(20);

    set @mayuscula = upper(cadena);
end //

delimiter ;