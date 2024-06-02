delimiter //

drop procedure if exists contar_directores//

create procedure contar_directores()
begin
    declare numDirectoresAux int;
    declare fechaAux datetime;

    create table if not exists totalDirectores(
        fecha datetime,
        numDirectores int
    );

    set fechaAux = now();
    select count(*) into numDirectoresAux from Directores;

    insert totalDirectores values(fechaAux, numDirectoresAux);
    select * from totalDirectores;
end//

delimiter ;