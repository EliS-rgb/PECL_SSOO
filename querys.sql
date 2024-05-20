-- 1. Mostrar el nombre de los directores nacidos en 1970.
SELECT DISTINCT personal.id_personal, id_director, nacimiento
FROM Personal
INNER JOIN director ON personal.id_personal=director.id_personal
WHERE nacimiento=1970;

--2. Mostrar todos los idiomas de las películas, junto al número de películas que hay en ese idioma. La salida debe de estar ordenada del idioma con más películas al que tiene menos.
SELECT idioma, COUNT(id_pelicula) AS num_peliculas
FROM Pelicula
GROUP BY idioma
ORDER BY num_peliculas DESC;

--3. Mostrar el número de actores nacidos en la década de los 70 (De 1970 a 1979 inclusive)
SELECT nacimiento, COUNT(id_actor)
FROM Personal
INNER JOIN actor ON personal.id_personal=actor.id_personal
WHERE nacimiento BETWEEN 1970 AND 1979
GROUP BY nacimiento
ORDER BY nacimiento;

--4. Mostrar cuantas críticas a realizado Oscar Gutiérrez junto a la puntuación media de todas sus críticas
SELECT critico, AVG(puntuacion)
FROM Critica
WHERE critico = 'Oscar Gutiérrez'
GROUP BY critico;

--5A. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--SE ORDENAN CONTANDO EL CAMPO ENTERO 
SELECT generos, COUNT(id_pelicula) AS num_peliculas
FROM Pelicula
GROUP BY generos
ORDER BY num_peliculas DESC;

--5B. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--EN COLUMNAS SIN ORDENAR
SELECT
    SUM(CASE WHEN generos LIKE '%Drama%' THEN 1 ELSE 0 END) AS Drama,
    SUM(CASE WHEN generos LIKE '%Comedy%' THEN 1 ELSE 0 END) AS Comedy,
    SUM(CASE WHEN generos LIKE '%Documentary%' THEN 1 ELSE 0 END) AS Documentary,
    SUM(CASE WHEN generos LIKE '%Horror%' THEN 1 ELSE 0 END) AS Horror,
    SUM(CASE WHEN generos LIKE '%Romance%' THEN 1 ELSE 0 END) AS Romance,
    SUM(CASE WHEN generos LIKE '%Triller%' THEN 1 ELSE 0 END) AS Triller,
    SUM(CASE WHEN generos LIKE '%Crime%' THEN 1 ELSE 0 END) AS Crime,
    SUM(CASE WHEN generos LIKE '%Romance%' THEN 1 ELSE 0 END) AS Romance,
    SUM(CASE WHEN generos LIKE '%Biography%' THEN 1 ELSE 0 END) AS Biography,
    SUM(CASE WHEN generos LIKE '%Mystery%' THEN 1 ELSE 0 END) AS Mystery,
    SUM(CASE WHEN generos LIKE '%War%' THEN 1 ELSE 0 END) AS War,
    SUM(CASE WHEN generos LIKE '%Music%' THEN 1 ELSE 0 END) AS Music,
    SUM(CASE WHEN generos LIKE '%Adventure%' THEN 1 ELSE 0 END) AS Adventure,
    SUM(CASE WHEN generos LIKE '%Sci-Fi%' THEN 1 ELSE 0 END) AS "Sci-Fi",
    SUM(CASE WHEN generos LIKE '%Western%' THEN 1 ELSE 0 END) AS Western,
    SUM(CASE WHEN generos LIKE '%Sport%' THEN 1 ELSE 0 END) AS Sport,
    SUM(CASE WHEN generos LIKE '%Fantasy%' THEN 1 ELSE 0 END) AS Fantasy,
    SUM(CASE WHEN generos LIKE '%Animation%' THEN 1 ELSE 0 END) AS Animation,
    SUM(CASE WHEN generos LIKE '%Film-Noir%' THEN 1 ELSE 0 END) AS "Film-Noir",
    SUM(CASE WHEN generos LIKE '%Family%' THEN 1 ELSE 0 END) AS Family,
    SUM(CASE WHEN generos LIKE '%History%' THEN 1 ELSE 0 END) AS History,
    SUM(CASE WHEN generos LIKE '%Musical%' THEN 1 ELSE 0 END) AS Musical,
    SUM(CASE WHEN generos LIKE '%Reality-TV%' THEN 1 ELSE 0 END) AS "Reality-TV",
    SUM(CASE WHEN generos LIKE '%Family%' THEN 1 ELSE 0 END) AS Family,
    SUM(CASE WHEN generos LIKE '%action%' THEN 1 ELSE 0 END) AS "Action"
FROM Pelicula;

--5C. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--EN FILAS Y ORDENADO
SELECT 
    genero,
    COUNT(*) AS num_peliculas
FROM (
    SELECT 
        regexp_split_to_table(generos, E'\\s*,\\s*') AS genero
    FROM Pelicula
) AS generos_pelis
GROUP BY genero
ORDER BY num_peliculas DESC;

SELECT 
    unnest(string_to_array(generos, ',')) AS genero,
    COUNT(*) AS num_peliculas
FROM Pelicula
GROUP BY genero
ORDER BY num_peliculas;

--6. Mostrar todas las películas que tienen más de un guionista
SELECT pelicula.titulo,pelicula.id_pelicula, COUNT(id_guionista) AS num_guionistas
FROM Dirige
INNER JOIN pelicula ON pelicula.id_pelicula=dirige.id_pelicula
GROUP BY pelicula.id_pelicula
HAVING COUNT(id_guionista) > 1
ORDER BY id_pelicula DESC;

--7. Solicitar los actores que hayan actuado en películas en idioma japonés y tengan una duración inferior a 120 minutos y cuyo año de nacimiento sea inferior a 1960. a salida mostrará el actor, el papel que hay interpretado en la
--película, así como el título, año, idioma, y duración de la misma
SELECT personal.nombre, Actua.papel, Pelicula.titulo, Pelicula.ano, Pelicula.idioma, Pelicula.duracion
FROM Actor
JOIN Actua ON Actor.id_actor = Actua.id_actor
JOIN Pelicula ON Actua.id_pelicula = Pelicula.id_pelicula
JOIN personal ON actor.id_personal=personal.id_personal
WHERE Pelicula.idioma = 'ja' AND Pelicula.duracion < 120 AND personal.nacimiento < 1960;

--8A. Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media
SELECT pelicula.titulo,critica.id_pelicula, AVG(puntuacion) AS puntuacion_media
FROM Critica
INNER JOIN pelicula ON pelicula.id_pelicula= critica.id_pelicula
GROUP BY pelicula.titulo,critica.id_pelicula
ORDER BY puntuacion_media DESC
LIMIT 3

--8B. Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media
SELECT titulo, ano, puntuacion_media
FROM (
    SELECT id_pelicula, AVG(puntuacion) AS puntuacion_media
    FROM Critica
    GROUP BY id_pelicula
    ORDER BY puntuacion_media DESC
    LIMIT 3
) AS Top3Peliculas
JOIN Pelicula ON Top3Peliculas.id_pelicula = Pelicula.id_pelicula;

--9A. Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media.
SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
    FROM Director
    INNER JOIN personal ON director.id_personal = personal.id_personal
    INNER JOIN pelicula ON director.id_director = pelicula.id_director
    INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
	
    GROUP BY personal.nombre, personal.id_personal
	ORDER BY puntuacion_media DESC;
    --LIMIT 1;

--9B. Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media.
--ELIMINANDO LOS DIRECTORES CON UNA SOLA PELICULA
-----------------------------------------------------------------A----------------------------------------------------------------
SELECT subconsulta.id_personal, subconsulta.nombre, MAX(subconsulta.puntuacion_media) AS puntuacion_media_alta
FROM (
    SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
    FROM Director
    INNER JOIN personal ON director.id_personal = personal.id_personal
    INNER JOIN pelicula ON director.id_director = pelicula.id_director
    INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
    GROUP BY personal.nombre, personal.id_personal
) AS subconsulta
WHERE num_peliculas>1
GROUP BY subconsulta.id_personal, subconsulta.nombre
ORDER BY puntuacion_media_alta DESC;
--LIMIT 1

-----------------------------------------------------------------B----------------------------------------------------------------
SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
FROM Director
INNER JOIN personal ON director.id_personal = personal.id_personal
INNER JOIN pelicula ON director.id_director = pelicula.id_director
INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
GROUP BY personal.nombre, personal.id_personal
HAVING COUNT(pelicula.id_pelicula)>1
ORDER BY puntuacion_media DESC;
--LIMIT 1
