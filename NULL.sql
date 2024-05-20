-- Verifica los datos nulos en las tablas temporales
SELECT * FROM public.actores_pelicula_temp
WHERE (nombre_pelicula='NULL'
	   OR ano_pelicula='NULL'
	   OR actor='NULL'
	   OR nacimiento='NULL'
	   OR fallecimiento='NULL'
	   OR personaje= 'NULL');

SELECT * FROM public.caratulas_temp
WHERE (titulo='NULL'
	   OR ano_pelicula='NULL'
	   OR titulo_guiones='NULL'
	   OR fecha_alojamiento='NULL'
	   OR enlace='NULL'
	   OR background='NULL'
	   OR cp='NULL'
	   OR cm='NULL'
	   OR cg='NULL');

SELECT * FROM public.criticas_temp
WHERE (fecha ='NULL'
	   OR pelicula ='NULL'
	   OR nombre_critico ='NULL'
	   OR nota ='NULL'
	   OR texto ='NULL'
	   OR enlace = 'NULL');

SELECT * FROM public.directores_peliculas_temp
WHERE (nombre_pelicula ='NULL'
	   OR ano ='NULL'
	   OR nombre_director ='NULL'
	   OR nacimiento ='NULL'
	   OR fallecimiento = 'NULL');

SELECT * FROM public.guionistas_peliculas_temp
WHERE (nombre_pelicula ='NULL'
	   OR ano ='NULL'
	   OR nombre_guionista ='NULL'
	   OR nacimiento ='NULL'
	   OR fallecimiento  = 'NULL');

SELECT * FROM public.peliculas_temp
WHERE (idimdb='NULL'
	   OR titulo='NULL'
	   OR ano='NULL'
	   OR genero='NULL'
	   OR idioma='NULL'
	   OR puntuacion='NULL'
	   OR sinopsis='NULL' 
	   OR calificacion_edad='NULL' );
