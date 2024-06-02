drop database Cine;
create database Cine;
use Cine

create table Actores (
ID_actor int primary key auto_increment,
Nombre_actor varchar(50) not null
);

create table Directores (
ID_director int primary key auto_increment,
Nombre_director varchar(50) not null
);

create table Peliculas (
ID_pelicula int primary key auto_increment,
Titulo_pelicula varchar(50) not null,
ID_director int not null,
FOREIGN KEY (ID_director) REFERENCES Directores(ID_director)
);

create table actuaEn (
    ID_actor int not null,
    ID_pelicula int not null,
    foreign key (ID_actor) references Actores(ID_actor),
    foreign key (ID_pelicula) references Peliculas(ID_pelicula)
);

insert Actores values (null, 'Vin Diesel');
insert Actores values (null, 'Paul Walker');
insert Actores values (null, 'Margot Robbie');
insert Actores values (null, 'Emma Watson');
insert Actores values (null, 'Brad Pitt');

insert Directores values (null, 'Quentin Tarantino');
insert Directores values (null, 'Justin Lin');
insert Directores values (null, 'Steven Spielberg');
insert Directores values (null, 'Cristopher Nolan');
insert Directores values (null, 'J.A Bayona');

insert Peliculas values (null, 'A Todo Gas', 2);
insert Peliculas values (null, 'Once Upon a Time in Hollywood', 1);
insert Peliculas values (null, 'Oppenheimer', 4);
insert Peliculas values (null, 'La sociedad de la nieve', 5);
insert Peliculas values (null, 'E.T', 3);

insert actuaEn values (1, 1);
insert actuaEn values (2, 1);
insert actuaEn values (3, 2);
insert actuaEn values (5, 2);
