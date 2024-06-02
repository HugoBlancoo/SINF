delimiter //
DROP TRIGGER IF EXISTS triggerDeleteDirectores//
CREATE TRIGGER triggerDeleteDirectores BEFORE DELETE ON Directores FOR EACH ROW
BEGIN
DECLARE nacAux varchar(50);
DECLARE IMDbAux int;
SELECT Directores.nacionalidad INTO nacAux FROM Directores WHERE ID_Director = old.ID_Director;
SELECT Directores.IMDb INTO IMDbAux FROM Directores WHERE ID_Director = old.ID_Director;
IF(nacAux='EEUU') THEN
DELETE FROM EEUU WHERE EEUU.IMDb=IMDbAux;
END IF;
END
//
DROP TRIGGER IF EXISTS triggerInsertDirectores//
CREATE TRIGGER triggerInsertDirectores BEFORE DELETE ON Directores FOR EACH ROW
BEGIN
DECLARE nacAux varchar(50);
DECLARE IMDbAux int;
SELECT Directores.nacionalidad INTO nacAux FROM Directores WHERE ID_Director = old.ID_Director;
SELECT Directores.IMDb INTO IMDbAux FROM Directores WHERE ID_Director = old.ID_Director;
IF(nacAux='EEUU') THEN
INSERT INTO EEUU VALUES(IMDbAux);
END IF;
END
//
delimiter ;