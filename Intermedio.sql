CREATE TABLE actores_pelicula_temp(
    nombre_pelicula TEXT,
    ano_pelicula TEXT,
    actor TEXT,
    nacimiento TEXT,
    fallecimiento TEXT,
    personaje TEXT
);

CREATE TABLE caratulas_temp(
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

CREATE TABLE criticas_temp(
    fecha TEXT,
    pelicula TEXT,
    nombre_critico TEXT,
    nota TEXT,
    texto TEXT,
    enlace TEXT
);

CREATE TABLE directores_peliculas_temp(
    nombre_pelicula TEXT,
    ano TEXT,
    nombre_director TEXT,
    nacimiento TEXT,
    fallecimiento TEXT
);

CREATE TABLE guionistas_peliculas_temp(
    nombre_pelicula TEXT,
    ano TEXT,
    nombre_guionista TEXT,
    nacimiento TEXT,
    fallecimiento TEXT
);

CREATE TABLE peliculas_temp(
    idIMDB TEXT,
    titulo TEXT,
    ano TEXT,
    genero TEXT,
    idioma TEXT,
    puntuacion TEXT,
    sinopsis TEXT,
    calificacion_edad TEXT
);