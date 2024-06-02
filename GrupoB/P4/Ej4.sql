use Cine

alter table Peliculas add column hora timestamp default now();
alter table Actores add column hora timestamp default now();
alter table Directores add column hora timestamp default now();