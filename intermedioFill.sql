COPY temp_actores_peliculas (nombre_pelicula, ano_pelicula, actor, nacimiento, fallecimiento, personaje)
FROM 'C:\Users\elisg\Desktop\csv\actores_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_caratulas ( ano_pelicula, titulo, titulo_guiones, fecha_alojamiento, enlace, background, cp, cm, cg)
FROM 'C:\Users\elisg\Desktop\csv\caratulas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_criticas ( fecha, pelicula, nombre_critico, nota, texto, enlace)
FROM 'C:\Users\elisg\Desktop\csv\criticas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_directores_peliculas( nombre_pelicula, ano, nombre_director, nacimiento, fallecimiento)
FROM 'C:\Users\elisg\Desktop\csv\directores_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_guionistas_peliculas ( nombre_pelicula, ano, nombre_guionista, nacimiento, fallecimiento)
FROM 'C:\Users\elisg\Desktop\csv\guionistas_peliculas.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
ESCAPE '''';

COPY temp_peliculas ( idimdb,titulo, ano, genero, idioma, duracion, sinopsis, calificacion_edad)
FROM 'C:\Users\elisg\Desktop\csv\peliculas_corrected.csv'
DELIMITER E'\t'
CSV ENCODING 'UTF8'
QUOTE '"'
