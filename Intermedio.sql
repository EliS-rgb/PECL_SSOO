--Crea las tablas temporales de acorde a los archivos csv proporcionados
CREATE TABLE temp_actores_peliculas(
    nombre_pelicula TEXT,
    ano_pelicula TEXT,
    actor TEXT,
    nacimiento TEXT,
    fallecimiento TEXT,
    personaje TEXT
);

CREATE TABLE temp_caratulas_(
    ano_pelicula TEXT,
    titulo TEXT,
    titulo_guiones TEXT,
    fecha_alojamiento TEXT,
    enlace TEXT,
    background TEXT,
    cp TEXT,
    cm TEXT,
    cg TEXT
);

CREATE TABLE temp_criticas(
    fecha TEXT,
    pelicula TEXT,
    nombre_critico TEXT,
    nota TEXT,
    texto TEXT,
    enlace TEXT
);

CREATE TABLE temp_directores_peliculas(
    nombre_pelicula TEXT,
    ano TEXT,
    nombre_director TEXT,
    nacimiento TEXT,
    fallecimiento TEXT
);

CREATE TABLE temp_guionistas_peliculas(
    nombre_pelicula TEXT,
    ano TEXT,
    nombre_guionista TEXT,
    nacimiento TEXT,
    fallecimiento TEXT
);

CREATE TABLE temp_peliculas(
    idIMDB TEXT,
    titulo TEXT,
    ano TEXT,
    genero TEXT,
    idioma TEXT,
    duracion TEXT,
    sinopsis TEXT,
    calificacion_edad TEXT
);