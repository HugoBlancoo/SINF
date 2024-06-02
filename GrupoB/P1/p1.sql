CREATE DATABASE mi_base_de_datos;
USE mi_base_de_datos;

CREATE TABLE Profesores (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE Alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    codigo_profesor INT,
    FOREIGN KEY (codigo_profesor) REFERENCES Profesores(codigo)
);

INSERT INTO Profesores (nombre) VALUES ('Juan Pérez'), ('María García'), ('Carlos López');

INSERT INTO Alumnos (nombre, codigo_profesor) VALUES ('Ana Sánchez', 1), ('Luis Torres', 2), ('Sofía Rodríguez', 1), ('Carlos Torres', 3);

