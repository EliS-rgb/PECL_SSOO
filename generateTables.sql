--------------Tabla que contiene la información personal de actores, directores y guionistas--------------
CREATE TABLE Personal (
    id_personal SERIAL PRIMARY KEY, -- ID único y autoincremental para cada persona
    nombre VARCHAR(255) NOT NULL, -- Nombre de la persona
    nacimiento INT, -- Año de nacimiento
    fallecimiento INT -- Año de fallecimiento 
);

-------------- Tabla que contiene información específica de actores--------------
CREATE TABLE Actor (
    id_actor SERIAL PRIMARY KEY, -- ID único y autoincremental para cada actor
    id_personal INT NOT NULL, -- Relación con la tabla Personal
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal) -- Llave foránea a la tabla Personal
);

-------------- Tabla que contiene información específica de directores--------------
CREATE TABLE Director (
    id_director SERIAL PRIMARY KEY, -- ID único y autoincremental para cada director
    id_personal INT, -- Relación con la tabla Personal
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal) -- Llave foránea a la tabla Personal
);

-------------- Tabla que contiene información específica de guionistas--------------
CREATE TABLE Guionista (
    id_guionista SERIAL PRIMARY KEY, -- ID único y autoincremental para cada guionista
    id_personal INT NOT NULL, -- Relación con la tabla Personal
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal) -- Llave foránea a la tabla Personal
);

-------------- Tabla que contiene información de las películas--------------
CREATE TABLE Pelicula (
    id_pelicula SERIAL PRIMARY KEY, -- ID único y autoincremental para cada película
    titulo VARCHAR(255), -- Título de la película
    ano INT, -- Año de lanzamiento de la película
    generos VARCHAR(255), -- Géneros de la película
    idioma VARCHAR(255), -- Idioma de la película
    duracion INT, -- Duración de la película en minutos
    calificacion_edad VARCHAR(255), -- Calificación por edad de la película
    id_director INT, -- Relación con la tabla Director
    FOREIGN KEY (id_director) REFERENCES Director(id_director) -- Llave foránea a la tabla Director
);

-------------- Tabla que contiene información de las páginas web--------------
CREATE TABLE PagWeb (
    id_pagweb SERIAL PRIMARY KEY, -- ID único y autoincremental para cada página web
    url VARCHAR(255) NOT NULL, -- URL de la página web
    tipo VARCHAR(255) NOT NULL -- Tipo de página web (e.g., críticas, carátulas, etc.)
);

-------------- Tabla que contiene las críticas de películas--------------
CREATE TABLE Critica (
    id_critica SERIAL PRIMARY KEY, -- ID único y autoincremental para cada crítica
    critico VARCHAR(255) NOT NULL, -- Nombre del crítico
    texto TEXT NOT NULL, -- Texto de la crítica
    puntuacion FLOAT NOT NULL, -- Puntuación de la crítica
    fecha VARCHAR(10), -- Fecha de la crítica
    id_pagweb INT, -- Relación con la tabla PagWeb
    id_pelicula INT, -- Relación con la tabla Pelicula
    FOREIGN KEY (id_pagweb) REFERENCES PagWeb(id_pagweb), -- Llave foránea a la tabla PagWeb
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula) -- Llave foránea a la tabla Pelicula
);

-------------- Tabla que contiene información de las carátulas de películas--------------
CREATE TABLE Caratulas (
    id_caratula SERIAL PRIMARY KEY, -- ID único y autoincremental para cada carátula
    nombre VARCHAR(255) NOT NULL, -- Nombre de la carátula
    cp VARCHAR(255), -- Carátula pequeña
    cm VARCHAR(255), -- Carátula mediana
    cg VARCHAR(255), -- Carátula grande
    poster VARCHAR(255), -- URL del poster de la carátula (background)
    id_pelicula INT, -- Relación con la tabla Pelicula
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula) -- Llave foránea a la tabla Pelicula
);

-------------- Tabla que contiene la información de dónde están alojadas las carátulas--------------
CREATE TABLE Alojadas (
    id_caratula INT, -- Relación con la tabla Caratulas
    id_pagweb INT, -- Relación con la tabla PagWeb
    fecha TIMESTAMP, -- Fecha de alojamiento de la carátula
    FOREIGN KEY (id_caratula) REFERENCES Caratulas(id_caratula), -- Llave foránea a la tabla Caratulas
    FOREIGN KEY (id_pagweb) REFERENCES PagWeb(id_pagweb) -- Llave foránea a la tabla PagWeb
);

-------------- Tabla que relaciona actores con las películas en las que han actuado y el papel que interpretaron--------------
CREATE TABLE Actua (
    id_actor INT, -- Relación con la tabla Actor
    id_pelicula INT, -- Relación con la tabla Pelicula
    papel VARCHAR(255), -- Papel que el actor interpretó en la película
    FOREIGN KEY (id_actor) REFERENCES Actor(id_actor), -- Llave foránea a la tabla Actor
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula) -- Llave foránea a la tabla Pelicula
);

-------------- Tabla que relaciona guionistas con las películas en las que han trabajado--------------
CREATE TABLE Dirige (
    id_guionista INT, -- Relación con la tabla Guionista
    id_pelicula INT, -- Relación con la tabla Pelicula
    FOREIGN KEY (id_guionista) REFERENCES Guionista(id_guionista), -- Llave foránea a la tabla Guionista
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula) -- Llave foránea a la tabla Pelicula
);
