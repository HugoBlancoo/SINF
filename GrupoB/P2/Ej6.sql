drop database Cine;
create database Cine;
use Cine

create table Actores (
ID_actor int not null primary key auto_increment,
Nombre_actor varchar(50) not null,
Edad int not null check (Edad >= 0 AND Edad <= 120),
IMDb int unique
);

create table Directores (
ID_director int not null primary key auto_increment,
Nombre_director varchar(50) not null,
Edad int not null check (Edad >= 0 AND Edad <= 120),
IMDb int unique
);

create table Peliculas (
ID_pelicula int not null primary key auto_increment,
Titulo_pelicula varchar(50) not null,
ID_director int not null,
IMDb int unique,
FOREIGN KEY (ID_director) REFERENCES Directores(ID_director)
);

create table actuaEn (
    ID_actor int not null,
    ID_pelicula int not null,
    foreign key (ID_actor) references Actores(ID_actor),
    foreign key (ID_pelicula) references Peliculas(ID_pelicula)
);

insert Actores values (null, 'Vin Diesel', 56, 0004874);
insert Actores values (null, 'Paul Walker', 40, 0908094);
insert Actores values (null, 'Margot Robbie', 33, 3053338 );
insert Actores values (null, 'Emma Watson', 33, 0914612);
insert Actores values (null, 'Brad Pitt', 60, 0000093);

insert Directores values (null, 'Quentin Tarantino', 60, 0000233);
insert Directores values (null, 'Justin Lin', 52, 0510912);
insert Directores values (null, 'Steven Spielberg', 77, 0000229);
insert Directores values (null, 'Cristopher Nolan', 53, 0634240);
insert Directores values (null, 'J.A Bayona', 48, 1291105);

insert Peliculas values (null, 'A Todo Gas', 2, 0232500);
insert Peliculas values (null, 'Once Upon a Time in Hollywood', 1, 7131622);
insert Peliculas values (null, 'Oppenheimer', 4, 15398776);
insert Peliculas values (null, 'La sociedad de la nieve', 5, 16277242);
insert Peliculas values (null, 'E.T', 3, 0083866);

insert actuaEn values (1, 1);
insert actuaEn values (2, 1);
insert actuaEn values (3, 2);
insert actuaEn values (5, 2);
