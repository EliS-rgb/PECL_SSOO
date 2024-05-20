INSERT INTO Personal (nombre, nacimiento, fallecimiento)
SELECT DISTINCT actor, 
       CASE 
           WHEN nacimiento = 'NULL' THEN NULL 
           WHEN nacimiento = '\N' THEN NULL 
           ELSE CAST(nacimiento AS INTEGER) 
       END, 
       CASE 
           WHEN fallecimiento = 'NULL' THEN NULL 
           WHEN fallecimiento = '\N' THEN NULL 
           ELSE CAST(fallecimiento AS INTEGER) 
       END
FROM temp_actores_peliculas
UNION
SELECT DISTINCT nombre_director, 
       CASE 
           WHEN nacimiento = 'NULL' THEN NULL 
           WHEN nacimiento = '\N' THEN NULL 
           ELSE CAST(nacimiento AS INTEGER) 
       END, 
       CASE 
           WHEN fallecimiento = 'NULL' THEN NULL 
           WHEN fallecimiento = '\N' THEN NULL 
           ELSE CAST(fallecimiento AS INTEGER) 
       END
FROM temp_directores_peliculas
UNION
SELECT DISTINCT nombre_guionista, 
       CASE 
           WHEN nacimiento = 'NULL' THEN NULL 
           WHEN nacimiento = '\N' THEN NULL 
           ELSE CAST(nacimiento AS INTEGER) 
       END, 
       CASE 
           WHEN fallecimiento = 'NULL' THEN NULL 
           WHEN fallecimiento = '\N' THEN NULL 
           ELSE CAST(fallecimiento AS INTEGER) 
       END
FROM temp_guionistas_peliculas;

INSERT INTO Director (id_personal)
SELECT DISTINCT id_personal
FROM Personal
INNER JOIN temp_directores_peliculas ON Personal.nombre = temp_directores_peliculas.nombre_director;

INSERT INTO Actor (id_personal)
SELECT DISTINCT id_personal
FROM Personal
INNER JOIN temp_actores_peliculas ON Personal.nombre = temp_actores_peliculas.actor;

INSERT INTO Guionista (id_personal)
SELECT DISTINCT id_personal
FROM Personal
INNER JOIN temp_guionistas_peliculas ON Personal.nombre = temp_guionistas_peliculas.nombre_guionista;




INSERT INTO Pelicula (titulo, ano, generos, idioma, duracion, calificacion_edad, id_director)
SELECT
    titulo,
    CASE 
        WHEN temp_peliculas.ano = 'NULL' THEN NULL 
        ELSE CAST(temp_peliculas.ano AS INTEGER) 
    END, 
    genero,
    idioma,
    CASE 
        WHEN temp_peliculas.duracion = 'NULL' THEN NULL 
        ELSE CAST(temp_peliculas.duracion AS INTEGER) 
    END,
    calificacion_edad,
    Director.id_director
FROM temp_peliculas
LEFT JOIN temp_directores_peliculas 
  ON temp_peliculas.titulo = temp_directores_peliculas.nombre_pelicula 
  AND temp_peliculas.ano = temp_directores_peliculas.ano
LEFT JOIN Personal 
  ON temp_directores_peliculas.nombre_director = Personal.Nombre
LEFT JOIN Director 
  ON Personal.id_personal = Director.id_personal;



INSERT INTO Actua (id_actor, id_pelicula, papel)
SELECT Actor.id_actor, pelicula.id_pelicula, personaje
FROM temp_actores_peliculas
LEFT JOIN Personal
ON temp_actores_peliculas.actor=personal.nombre
JOIN Actor ON personal.id_personal = Actor.id_actor
JOIN pelicula ON temp_actores_peliculas.nombre_pelicula = pelicula.titulo;

INSERT INTO Dirige (id_guionista, id_pelicula)
SELECT Guionista.id_guionista, pelicula.id_pelicula
FROM temp_guionistas_peliculas
LEFT JOIN Personal
ON temp_guionistas_peliculas.nombre_guionista=personal.nombre
JOIN guionista ON personal.id_personal = guionista.id_guionista
JOIN pelicula ON temp_guionistas_peliculas.nombre_pelicula = pelicula.titulo;



INSERT INTO PagWeb (url, tipo)
SELECT DISTINCT enlace, 'Crítica'
FROM temp_criticas
UNION
SELECT DISTINCT enlace, 'Carátula'
FROM temp_caratulas;


INSERT INTO Critica (critico, texto, puntuacion, id_pagweb, id_pelicula)