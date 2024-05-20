------------------- 1. Mostrar el nombre de los directores nacidos en 1970.-------------------

-- Seleccionar los directores nacidos en 1970
SELECT DISTINCT 
    personal.id_personal, -- ID único de la persona
    id_director, -- ID único del director
    nacimiento -- Año de nacimiento de la persona
FROM Personal
-- Unir la tabla Personal con la tabla Director en la columna id_personal
INNER JOIN director ON personal.id_personal = director.id_personal
-- Filtrar los resultados para incluir solo aquellos nacidos en 1970
WHERE nacimiento = 1970;

--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------2. Mostrar todos los idiomas de las películas, junto al número de películas que hay en ese idioma. La salida debe de estar ordenada del idioma con más películas al que tiene menos.

-- Seleccionar el idioma y el número de películas en ese idioma
SELECT 
    idioma, -- Columna que indica el idioma de la película
    COUNT(id_pelicula) AS num_peliculas -- Contar el número de películas para cada idioma
FROM 
    Pelicula -- Tabla de la que se obtienen los datos
-- Agrupar los resultados por idioma
GROUP BY 
    idioma
-- Ordenar los resultados por el número de películas de forma ascendente (del menor al mayor)
ORDER BY 
    num_peliculas ASC;


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------3. Mostrar el número de actores nacidos en la década de los 70 (De 1970 a 1979 inclusive)

-- Seleccionar el año de nacimiento y el número de actores nacidos en ese año
SELECT 
    nacimiento, -- Columna que indica el año de nacimiento
    COUNT(id_actor) AS num_actores -- Contar el número de actores para cada año de nacimiento
FROM 
    Personal -- Tabla que contiene la información personal
INNER JOIN 
    Actor ON Personal.id_personal = Actor.id_personal -- Unir la tabla Personal con Actor en base a id_personal
-- Filtrar los resultados para incluir solo aquellos nacidos entre 1970 y 1979
WHERE 
    nacimiento BETWEEN 1970 AND 1979
-- Agrupar los resultados por el año de nacimiento
GROUP BY 
    nacimiento
-- Ordenar los resultados por el año de nacimiento de manera ascendente
ORDER BY 
    nacimiento;


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------4. Mostrar cuantas críticas a realizado Oscar Gutiérrez junto a la puntuación media de todas sus críticas

-- Seleccionar el crítico, el promedio de las puntuaciones y el número de críticas realizadas
SELECT 
    critico, -- Nombre del crítico
    AVG(puntuacion) AS puntuacion_media, -- Promedio de las puntuaciones de las críticas
    COUNT(*) AS num_criticas -- Número de críticas realizadas por el crítico
FROM 
    Critica -- Tabla que contiene las críticas
-- Filtrar las críticas para incluir solo aquellas hechas por 'Oscar Gutiérrez'
WHERE 
    critico = 'Oscar Gutiérrez'
-- Agrupar los resultados por el nombre del crítico
GROUP BY 
    critico;


--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------5A. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--SE ORDENAN CONTANDO EL CAMPO ENTERO 

-- Utilizamos regexp_split_to_table para descomponer los géneros en filas individuales
SELECT 
    genero, -- Género de la película
    COUNT(*) AS num_peliculas -- Contar el número de películas para cada género
FROM (
    SELECT 
        regexp_split_to_table(generos, E'\\s*,\\s*') AS genero -- Descomponer la lista de géneros en filas individuales
    FROM 
        Pelicula
) AS generos_pelis
-- Agrupar por el género descompuesto
GROUP BY 
    genero
-- Ordenar los resultados por el número de películas en orden descendente
ORDER BY 
    num_peliculas DESC;


-------------------5B. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
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

-------------------5C. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--ORDENADO Y EN FILAS UNIENDO LOS RESULTADOS

-- Contar el número de películas para cada género individual y ordenarlas de menor a mayor número de películas
SELECT 'Drama' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Drama%'
UNION ALL
SELECT 'Comedy' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Comedy%'
UNION ALL
SELECT 'Documentary' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Documentary%'
UNION ALL
SELECT 'Horror' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Horror%'
UNION ALL
SELECT 'Romance' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Romance%'
UNION ALL
SELECT 'Thriller' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Thriller%'
UNION ALL
SELECT 'Crime' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Crime%'
UNION ALL
SELECT 'Biography' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Biography%'
UNION ALL
SELECT 'Mystery' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Mystery%'
UNION ALL
SELECT 'War' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%War%'
UNION ALL
SELECT 'Music' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Music%'
UNION ALL
SELECT 'Adventure' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Adventure%'
UNION ALL
SELECT 'Sci-Fi' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Sci-Fi%'
UNION ALL
SELECT 'Western' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Western%'
UNION ALL
SELECT 'Sport' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Sport%'
UNION ALL
SELECT 'Fantasy' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Fantasy%'
UNION ALL
SELECT 'Animation' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Animation%'
UNION ALL
SELECT 'Film-Noir' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Film-Noir%'
UNION ALL
SELECT 'Family' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Family%'
UNION ALL
SELECT 'History' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%History%'
UNION ALL
SELECT 'Musical' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Musical%'
UNION ALL
SELECT 'Reality-TV' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Reality-TV%'
UNION ALL
SELECT 'Action' AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
WHERE generos LIKE '%Action%'
ORDER BY num_peliculas ASC; -- Ordenar los resultados por número de películas de menor a mayor


-------------------5D. Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos
--EN FILAS Y ORDENADO

-- 5D.1 Consulta para contar el número de películas por género utilizando regexp_split_to_table
-- Selecciona el género y cuenta el número de películas para cada género
SELECT 
    genero,
    COUNT(*) AS num_peliculas
FROM (
    -- Subconsulta para dividir la columna generos en filas individuales usando regexp_split_to_table
    SELECT 
        regexp_split_to_table(generos, E'\\s*,\\s*') AS genero
    FROM Pelicula
) AS generos_pelis
-- Agrupa los resultados por género
GROUP BY genero
-- Ordena los resultados en orden descendente según el número de películas
ORDER BY num_peliculas DESC;

-- 5D.2 Consulta para contar el número de películas por género utilizando unnest y string_to_array
SELECT 
    -- Subconsulta para dividir la columna generos en filas individuales usando unnest y string_to_array
    unnest(string_to_array(generos, ',')) AS genero,
    COUNT(*) AS num_peliculas
FROM Pelicula
-- Agrupa los resultados por género
GROUP BY genero
-- Ordena los resultados en orden descendente según el número de películas
ORDER BY num_peliculas DESC;

--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------6. Mostrar todas las películas que tienen más de un guionista

-- Selecciona el título de la película, su ID y cuenta el número de guionistas para cada película
SELECT pelicula.titulo, pelicula.id_pelicula, COUNT(id_guionista) AS num_guionistas
FROM Dirige
-- Une la tabla Pelicula con la tabla Dirige utilizando el ID de la película
INNER JOIN pelicula ON pelicula.id_pelicula = dirige.id_pelicula
-- Agrupa los resultados por el ID de la película
GROUP BY pelicula.id_pelicula
-- Filtra solo las películas que tienen más de un guionista
HAVING COUNT(id_guionista) > 1
-- Ordena los resultados por el ID de la película en orden descendente
ORDER BY id_pelicula DESC;

--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------7. Solicitar los actores que hayan actuado en películas en idioma japonés y tengan una duración inferior a 120 minutos y cuyo año de nacimiento sea inferior a 1960. a salida mostrará el actor, el papel que hay interpretado en la
--película, así como el título, año, idioma, y duración de la misma
SELECT personal.nombre, Actua.papel, Pelicula.titulo, Pelicula.ano, Pelicula.idioma, Pelicula.duracion
FROM Actor
-- Une la tabla Actor con la tabla Actua utilizando el ID del actor
JOIN Actua ON Actor.id_actor = Actua.id_actor
-- Une la tabla Actua con la tabla Pelicula utilizando el ID de la película
JOIN Pelicula ON Actua.id_pelicula = Pelicula.id_pelicula
-- Une la tabla Actor con la tabla Personal utilizando el ID personal del actor
JOIN personal ON actor.id_personal = personal.id_personal
-- Filtra las películas en idioma japonés (código 'ja'), con duración inferior a 120 minutos
-- y cuyo año de nacimiento del actor sea inferior a 1960
WHERE Pelicula.idioma = 'ja' AND Pelicula.duracion < 120 AND personal.nacimiento < 1960;

--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------8A. Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media
-- Selecciona el título de la película, el ID de la película y la puntuación media de las críticas
SELECT pelicula.titulo, critica.id_pelicula, AVG(puntuacion) AS puntuacion_media
-- Une la tabla Critica con la tabla Pelicula utilizando el ID de la película
INNER JOIN pelicula ON pelicula.id_pelicula = critica.id_pelicula
-- Agrupa los resultados por título de la película y ID de la película
GROUP BY pelicula.titulo, critica.id_pelicula
-- Ordena los resultados por puntuación media de las críticas de forma descendente
ORDER BY puntuacion_media DESC
-- Limita el resultado a las 3 primeras filas
LIMIT 3;

-------------------8B. Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media
-- Selecciona el título de la película, el año y la puntuación media de las tres películas con la puntuación media más alta
SELECT titulo, ano, puntuacion_media
FROM (
    -- Subconsulta para obtener las tres películas con la puntuación media más alta
    SELECT id_pelicula, AVG(puntuacion) AS puntuacion_media
    FROM Critica
    GROUP BY id_pelicula
    -- Ordena las películas por puntuación media de forma descendente
    ORDER BY puntuacion_media DESC
    -- Limita el resultado a las 3 primeras filas
    LIMIT 3
) AS Top3Peliculas
-- Une la subconsulta con la tabla Pelicula para obtener los detalles de las películas
JOIN Pelicula ON Top3Peliculas.id_pelicula = Pelicula.id_pelicula;

--****************************************************************************************************************************************************************************************************--
--****************************************************************************************************************************************************************************************************--

-------------------9A. Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media.
-- Selecciona el ID del personal, el nombre del personal, el promedio de las puntuaciones de las críticas
-- y el número total de películas dirigidas por cada director.
SELECT 
    personal.id_personal, 
    personal.nombre, 
    AVG(critica.puntuacion) AS puntuacion_media, 
    COUNT(pelicula.id_pelicula) AS num_peliculas
FROM 
    Director
INNER JOIN 
    personal ON director.id_personal = personal.id_personal
INNER JOIN 
    pelicula ON director.id_director = pelicula.id_director
INNER JOIN 
    critica ON pelicula.id_pelicula = critica.id_pelicula
-- Agrupa los resultados por el ID y nombre del personal para calcular el promedio de las puntuaciones
-- y contar el número total de películas dirigidas por cada director.
GROUP BY 
    personal.id_personal, personal.nombre
-- Ordena los resultados por el promedio de las puntuaciones de las críticas, de mayor a menor.
ORDER BY 
    puntuacion_media DESC;
    --LIMIT 1;

-------------------9B. Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media.
--ELIMINANDO LOS DIRECTORES CON UNA SOLA PELICULA

-- 9B.1 Selecciona el ID del personal, el nombre del personal y la puntuación media más alta
-- de las películas dirigidas por cada director que haya dirigido más de una película.
SELECT 
    subconsulta.id_personal, 
    subconsulta.nombre, 
    MAX(subconsulta.puntuacion_media) AS puntuacion_media_alta
FROM (
    -- Subconsulta que calcula la puntuación media de las películas dirigidas por cada director
    -- y cuenta el número de películas dirigidas por cada director.
    SELECT 
        personal.id_personal, 
        personal.nombre, 
        AVG(critica.puntuacion) AS puntuacion_media, 
        COUNT(pelicula.id_pelicula) AS num_peliculas
    FROM 
        Director
    INNER JOIN 
        personal ON director.id_personal = personal.id_personal
    INNER JOIN 
        pelicula ON director.id_director = pelicula.id_director
    INNER JOIN 
        critica ON pelicula.id_pelicula = critica.id_pelicula
    GROUP BY 
        personal.nombre, personal.id_personal
) AS subconsulta
-- Filtra los resultados para incluir solo aquellos directores que hayan dirigido más de una película.
WHERE 
    num_peliculas > 1
-- Agrupa los resultados por el ID del personal y el nombre del personal
-- para garantizar que cada director se muestre solo una vez.
GROUP BY 
    subconsulta.id_personal, subconsulta.nombre
-- Ordena los resultados por la puntuación media más alta, de mayor a menor.
ORDER BY 
    puntuacion_media_alta DESC;

--LIMIT 1

-- 9B.2 Selecciona el ID del personal, el nombre del personal, la puntuación media de las críticas
-- y el número de películas dirigidas por cada director que haya dirigido más de una película.
SELECT 
    personal.id_personal, 
    personal.nombre, 
    AVG(critica.puntuacion) AS puntuacion_media, 
    COUNT(pelicula.id_pelicula) AS num_peliculas
FROM 
    Director
INNER JOIN 
    personal ON director.id_personal = personal.id_personal
INNER JOIN 
    pelicula ON director.id_director = pelicula.id_director
INNER JOIN 
    critica ON pelicula.id_pelicula = critica.id_pelicula
-- Agrupa los resultados por el nombre y el ID del personal para obtener la puntuación media
-- y contar el número de películas dirigidas por cada director.
GROUP BY 
    personal.nombre, personal.id_personal
-- Filtra los resultados para incluir solo aquellos directores que hayan dirigido más de una película.
HAVING 
    COUNT(pelicula.id_pelicula) > 1
-- Ordena los resultados por la puntuación media de las críticas, de mayor a menor.
ORDER BY 
    puntuacion_media DESC;

--LIMIT 1
