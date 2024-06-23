COPY temp_actores_peliculas (nombre_pelicula, ano_pelicula, actor, nacimiento, fallecimiento, personaje)
FROM 'DIRECTORIO/csv/actores_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_caratulas ( ano_pelicula, titulo, titulo_guiones, fecha_alojamiento, enlace, background, cp, cm, cg)
FROM 'DIRECTORIO/csv/caratulas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_criticas ( fecha, pelicula, nombre_critico, nota, texto, enlace)
FROM 'DIRECTORIO/csv/criticas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_directores_peliculas( nombre_pelicula, ano, nombre_director, nacimiento, fallecimiento)
FROM 'DIRECTORIO/csv/directores_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_guionistas_peliculas ( nombre_pelicula, ano, nombre_guionista, nacimiento, fallecimiento)
FROM 'DIRECTORIO/csv/guionistas_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_peliculas ( idimdb,titulo, ano, genero, idioma, duracion, sinopsis, calificacion_edad)
FROM 'DIRECTORIO/csv/peliculas_corrected.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';