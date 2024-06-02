drop database Cine;
create database Cine;
use Cine

create table Actores (
ID_actor int not null primary key auto_increment,
Nombre_actor varchar(50) not null,
Edad int not null check (Edad >= 0 AND Edad <= 120),
Nacionalidad varchar(20) not null,
IMDb int unique
);

create table Directores (
ID_director int not null primary key auto_increment,
Nombre_director varchar(50) not null,
Edad int not null check (Edad >= 0 AND Edad <= 120),
Nacionalidad varchar(20) not null,
IMDb int unique
);

create table Peliculas (
ID_pelicula int not null primary key auto_increment,
Titulo_pelicula varchar(50) not null,
ID_director int not null,
Nacionalidad varchar(20) not null,
IMDb int unique,
FOREIGN KEY (ID_director) REFERENCES Directores(ID_director)
);

create table actuaEn (
    ID_actor int not null,
    ID_pelicula int not null,
    foreign key (ID_actor) references Actores(ID_actor),
    foreign key (ID_pelicula) references Peliculas(ID_pelicula)
);
