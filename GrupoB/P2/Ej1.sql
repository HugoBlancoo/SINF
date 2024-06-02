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
Titulo_pelicula varchar(50) not null
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

insert Peliculas values (null, 'A Todo Gas');
insert Peliculas values (null, 'Once Upon a Time in Hollywood');
insert Peliculas values (null, 'Oppenheimer');
insert Peliculas values (null, 'La sociedad de la nieve');
insert Peliculas values (null, 'E.T');
