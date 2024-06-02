use Cine

ALTER TABLE Directores MODIFY Nacionalidad varchar(20) NOT NULL DEFAULT 'Estadounidense';
ALTER TABLE Actores MODIFY Nacionalidad varchar(20) NOT NULL DEFAULT 'Estadounidense';
ALTER TABLE Peliculas MODIFY Nacionalidad varchar(20) NOT NULL DEFAULT 'Estadounidense';
