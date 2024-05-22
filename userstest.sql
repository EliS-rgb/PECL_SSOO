-- Conectarse como admin_user
\c PE admin

-- Crear una nueva tabla
CREATE TABLE PruebaAdmin (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

--Consulta para verificar que se creó la tabla
SELECT * FROM PruebaAdmin;
-- Borrar la tabla creada
DROP TABLE PruebaAdmin;
--Consulta para verificar que se borró la tabla
SELECT * FROM PruebaAdmin;


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--


-- Conectarse como gestor
\c PE gestor

--Consulta para verificar que no se encuentra la pelicula
SELECT * FROM pelicula WHERE pelicula.titulo='Nueva pelicula';
-- Insertar datos en una tabla existente
INSERT INTO PELICULA (titulo, ano, duracion, calificacion_edad, idioma, generos, id_director) VALUES ('Nueva pelicula',2024, NULL, NULL, NULL, 'Action', '111');
--Consulta para verificar que se añadio la entrada la tabla
SELECT * FROM pelicula WHERE pelicula.titulo='Nueva pelicula';

-- Actualizar datos en una tabla existente
UPDATE Pelicula SET duracion = 115 WHERE titulo = 'Nueva pelicula';
--Consulta para verificar que se actualizó la entrada la tabla
SELECT * FROM pelicula WHERE pelicula.titulo='Nueva pelicula';

-- Borrar datos en una tabla existente
DELETE FROM Pelicula WHERE titulo = 'Nueva pelicula';

--Consulta para verificar que se actualizó la entrada la tabla
SELECT * FROM pelicula WHERE pelicula.titulo='Nueva pelicula';

-- Intentar crear una nueva tabla (esto debería fallar)
CREATE TABLE PruebaGestor (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(100)
);


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-- Conectarse a la base de datos como usuario crítico
\c PE critico

-- Consultar la tabla Críticas
SELECT * FROM Critica LIMIT 10;

-- Insertar una nueva crítica en la tabla Críticas
INSERT INTO Critica (critico, Texto, Puntuacion, id_pagweb, Fecha, id_pelicula)
VALUES ( 'John Doe', 'Una excelente película', 5, 1, '2024-05-21', 1);

SELECT * FROM Critica WHERE critico='John Doe';
DELETE FROM Critica WHERE critico='John Doe';

INSERT INTO PagWeb (url, tipo) VALUES('https://www.pagweb.test','Critica');--Deberia denegar el permiso


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

\c PE cliente

-- Consultar datos en la tabla Películas
SELECT * FROM Pelicula LIMIT 10;

-- Intentar insertar datos en la tabla Películas (esto debería fallar)
INSERT INTO Pelicula ( Ano, Titulo, Duracion, calificacion_edad, Idioma, generos, id_director) 
VALUES (2024, 'Película Cliente', 90, 'G', 'en', 'Comedy', 102);

-- Intentar actualizar datos en la tabla Películas (esto debería fallar)
UPDATE Pelicula SET Duracion = 95 WHERE id_pelicula=1;

-- Intentar borrar datos en la tabla Películas (esto debería fallar)
DELETE FROM Pelicula WHERE id_pelicula = 2;