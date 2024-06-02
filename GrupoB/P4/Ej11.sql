create user 'Usuario1'@'localhost' identified by 'Usuario.1234';
create user 'Usuario2'@'localhost' identified by 'Usuario.1234';

grant select on  Cine.Ej7 To 'Usuario1'@'localhost';
grant select on  Cine.Ej8 To 'Usuario1'@'localhost';
grant select on  Cine.tituloNacionalidad To 'Usuario1'@'localhost';

grant select on  Cine.Ej7 To 'Usuario2'@'localhost';
grant select on  Cine.Ej8 To 'Usuario2'@'localhost';
grant select on  Cine.tituloNacionalidad To 'Usuario2'@'localhost';