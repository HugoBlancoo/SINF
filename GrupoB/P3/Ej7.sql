delimiter //

drop procedure if exists contar_directores//

create procedure contar_directores()
begin
    declare numDirectoresAux int;
    declare fechaAux datetime;
    declare contador int default 0;

    create table if not exists totalDirectores(
        fecha datetime,
        numDirectores int
    );

    set fechaAux = now();
    select count(*) into numDirectoresAux from Directores;

    if (@contador is null) then
        set @contador = 0;
    end if;
    
    set @contador = @contador+1;

    if ((select count(*) from totalDirectores)>=10) then
        DELETE FROM totalDirectores ORDER BY fecha limit 1;
    end if;

    insert totalDirectores values(fechaAux, numDirectoresAux);
    select * from totalDirectores;
end//

delimiter ;