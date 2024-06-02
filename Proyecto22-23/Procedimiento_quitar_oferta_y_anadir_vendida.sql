CREATE PROCEDURE Quitar_oferta()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE recinto varchar(50);
    DECLARE grada varchar(30);
    DECLARE localidad varchar(50);    

    DECLARE Localidades_vendida CURSOR FOR
        SELECT UbicacionRecinto, NombreGrada, UbicacionLocalidad
        FROM Localidades
        WHERE EstadoLocalidad = 'Vendida';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    OPEN Localidades_vendida;

    read_loop: LOOP
        FETCH Localidades_vendida INTO recinto, grada, localidad;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF EXISTS (
        SELECT UbicacionRecinto, NombreGrada, UbicacionLocalidad 
        FROM oferta
        WHERE UbicacionRecinto = recinto AND 
        NombreGrada = grada AND 
        UbicacionLocalidad = localidad)

            THEN 
            DELETE FROM oferta 
            WHERE UbicacionRecinto = recinto AND 
            NombreGrada = grada AND 
            UbicacionLocalidad = localidad;
        END IF;        

    END LOOP read_loop;

    CLOSE Localidades_vendida;

    COMMIT;
END;    

CREATE PROCEDURE Insertar_vendida(
    in DNI varchar(9), 
    in TipoUsuario ENUM('Jubilado', 'Adulto', 'Infantil', 'Parado'))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE recinto varchar(50);
    DECLARE grada varchar(30);
    DECLARE localidad varchar(50);    

    DECLARE Localidades_vendida CURSOR FOR
        SELECT UbicacionRecinto, NombreGrada, UbicacionLocalidad
        FROM Localidades
        WHERE EstadoLocalidad = 'Vendida';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    OPEN Localidades_vendida;

    read_loop: LOOP
        FETCH Localidades_vendida INTO recinto, grada, localidad;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF NOT EXISTS (
        SELECT UbicacionRecinto, NombreGrada, UbicacionLocalidad 
        FROM vendida
        WHERE UbicacionRecinto = recinto AND 
        NombreGrada = grada AND 
        UbicacionLocalidad = localidad)

            THEN  

            INSERT INTO vendida (DNICliente, TipoUsuario, UbicacionRecinto, NombreGrada, UbicacionLocalidad) VALUES
                (DNI, TipoUsuario, recinto, grada, localidad);
        END IF;         

    END LOOP read_loop;

    CLOSE Localidades_vendida;

    COMMIT;
END; 