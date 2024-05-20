CREATE TABLE Personal (
    id_personal SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    nacimiento INT,
    fallecimiento INT
);

CREATE TABLE Actor (
    id_actor SERIAL PRIMARY KEY,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Director (
    id_director SERIAL PRIMARY KEY,
    id_personal INT,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);
CREATE TABLE Guionista (
    id_guionista SERIAL PRIMARY KEY,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Pelicula (
    id_pelicula SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    ano INT ,
    generos VARCHAR(255) ,
    idioma VARCHAR(255),
    duracion INT,
    calificacion_edad VARCHAR(255),
    id_director INT,
    FOREIGN KEY (id_director) REFERENCES Director(id_director)
);

CREATE TABLE PagWeb (
    id_pagweb SERIAL PRIMARY KEY,
    url VARCHAR(255) NOT NULL,
    tipo VARCHAR(255) NOT NULL
);

CREATE TABLE Critica (
    id_crítica SERIAL PRIMARY KEY,
    critico VARCHAR(255) NOT NULL,
    texto TEXT NOT NULL,
    puntuacion FLOAT NOT NULL,
    id_pagweb INT,
    id_pelicula INT,
    FOREIGN KEY (id_pagweb) REFERENCES PagWeb(id_pagweb),
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);

CREATE TABLE Caratulas (
    id_carátula SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    cp VARCHAR(255),
    cm VARCHAR(255),
    cg VARCHAR(255),
    poster VARCHAR(255),
    id_pelicula INT,
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);



CREATE TABLE Alojadas (
    id_carátula INT,
    id_pagweb INT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_carátula) REFERENCES Caratulas(id_carátula),
    FOREIGN KEY (id_pagweb) REFERENCES PagWeb(id_pagweb)
);

CREATE TABLE Actua (
    id_actor INT,
    id_pelicula INT,
    papel VARCHAR(255),
    FOREIGN KEY (id_actor) REFERENCES Actor(id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);

CREATE TABLE Dirige (
    id_guionista INT,
    id_pelicula INT,
    FOREIGN KEY (id_guionista) REFERENCES Guionista(id_guionista),
    FOREIGN KEY (id_pelicula) REFERENCES Pelicula(id_pelicula)
);