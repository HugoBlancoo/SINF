delimiter //
DROP TRIGGER IF EXISTS deleteActores//
CREATE TRIGGER deleteActores BEFORE DELETE ON Actores FOR EACH ROW
BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE ID_PelAux int;
DECLARE cursorAparece CURSOR FOR SELECT actuaEn.ID_Pelicula FROM actuaEn WHERE
actuaEn.ID_Actor=old.ID_actor;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cursorAparece;
bucle: LOOP
FETCH cursorAparece INTO ID_PelAux;
IF done THEN
LEAVE bucle;
END IF;
IF((SELECT COUNT(*) FROM actuaEn WHERE actuaEn.ID_Pelicula=ID_PelAux)=1) THEN
DELETE FROM actuaEn WHERE actuaEn=ID_Pelicula=ID_PelAux;
DELETE FROM Peliculas WHERE Peliculas.ID_Pelicula=ID_PelAux;
END IF;
END LOOP;
DELETE FROM actuaEn WHERE actuaEn.ID_Actor = old.ID_Actor;
END
//
DROP TRIGGER IF EXISTS borrarActuaciones//
CREATE TRIGGER borrarActuaciones BEFORE DELETE ON actuaEn FOR EACH ROW
BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
IF((SELECT COUNT(*) FROM actuaEn WHERE actuaEn.ID_Pelicula=old.ID_Pelicula)=1) THEN
DELETE FROM actuaEn WHERE actuaEn.ID_Pelicula=old.ID_Pelicula;
DELETE FROM Peliculas WHERE Peliculas.ID_Pelicula=old.ID_Pelicula;
END IF;
END
//
DROP PROCEDURE IF EXISTS introducirPelicula//
CREATE PROCEDURE introducirPelicula(IN ID_PelAux int, IN titAux varchar(50), IN idDirAux int, in IMBDPelAux int, in
NacPelAux varchar(50), IN idActAux int)
BEGIN
START TRANSACTION;
INSERT INTO Peliculas VALUES(ID_PelAux, titAux, idDirAux, IMBDPelAux, NacPelAux);
INSERT INTO actuaEn VALUES(ID_PelAux, ID_ActAux);
COMMIT;
END
//
delimiter ;