import psycopg2
import psycopg

db_name=""


consulta_1="""
SELECT personal.id_personal, personal.nombre, id_director, nacimiento
FROM Personal
INNER JOIN director ON personal.id_personal = director.id_personal
WHERE nacimiento = 1970;

"""
consulta_2="""
SELECT idioma, COUNT(id_pelicula) AS num_peliculas
FROM Pelicula 
GROUP BY idioma
ORDER BY num_peliculas ASC;
"""
consulta_3="""
SELECT nacimiento, COUNT(id_actor) AS num_actores 
FROM Personal
INNER JOIN Actor ON Personal.id_personal = Actor.id_personal
WHERE nacimiento BETWEEN 1970 AND 1979
GROUP BY nacimiento
ORDER BY nacimiento;

"""
consulta_4="""
SELECT critico, AVG(puntuacion) AS puntuacion_media, COUNT(*) AS num_criticas
FROM Critica 
WHERE critico = 'Oscar Gutiérrez'
GROUP BY critico;

"""

consulta_5a="""
SELECT generos, COUNT(*) AS num_peliculas FROM Pelicula
GROUP BY generos
ORDER BY num_peliculas DESC;
"""

consulta_5b="""
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
    SUM(CASE WHEN generos LIKE '%Action%' THEN 1 ELSE 0 END) AS "Action"
FROM Pelicula;
"""
consulta_5c="""
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
ORDER BY num_peliculas ASC;
"""

consulta_5d1="""
SELECT genero, COUNT(*) AS num_peliculas
FROM (
    SELECT regexp_split_to_table(generos, E'\\s*,\\s*') AS genero
    FROM Pelicula
) AS generos_pelis
GROUP BY genero
ORDER BY num_peliculas DESC;
"""

consulta_5d2="""
SELECT unnest(string_to_array(generos, ',')) AS genero, COUNT(*) AS num_peliculas
FROM Pelicula
GROUP BY genero
ORDER BY num_peliculas DESC;
"""

consulta_6="""
SELECT pelicula.titulo, pelicula.id_pelicula, COUNT(id_guionista) AS num_guionistas
FROM Dirige
INNER JOIN pelicula ON pelicula.id_pelicula = dirige.id_pelicula
GROUP BY pelicula.id_pelicula
HAVING COUNT(id_guionista) > 1
ORDER BY id_pelicula DESC;
"""

consulta_7="""
SELECT personal.nombre,personal.nacimiento, Actua.papel, Pelicula.titulo, Pelicula.ano, Pelicula.idioma, Pelicula.duracion
FROM Actor
JOIN Actua ON Actor.id_actor = Actua.id_actor
JOIN Pelicula ON Actua.id_pelicula = Pelicula.id_pelicula
JOIN personal ON actor.id_personal = personal.id_personal
WHERE Pelicula.idioma = 'ja' AND Pelicula.duracion < 120 AND personal.nacimiento < 1960;

"""

consulta_8a="""
SELECT pelicula.titulo, critica.id_pelicula, AVG(puntuacion) AS puntuacion_media
FROM critica
INNER JOIN pelicula ON pelicula.id_pelicula = critica.id_pelicula
GROUP BY pelicula.titulo, critica.id_pelicula
ORDER BY puntuacion_media DESC
LIMIT 3;
"""
consulta_8b="""
SELECT titulo, ano, puntuacion_media
FROM (
    SELECT id_pelicula, AVG(puntuacion) AS puntuacion_media
    FROM Critica
    GROUP BY id_pelicula
    ORDER BY puntuacion_media DESC
    LIMIT 3
) AS Top3Peliculas
JOIN Pelicula ON Top3Peliculas.id_pelicula = Pelicula.id_pelicula;
"""

consulta_9a="""
SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
FROM Director
INNER JOIN personal ON director.id_personal = personal.id_personal
INNER JOIN pelicula ON director.id_director = pelicula.id_director
INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
GROUP BY personal.id_personal, personal.nombre
ORDER BY puntuacion_media DESC
    --LIMIT 1
;
"""

consulta_9b1="""
SELECT subconsulta.id_personal, subconsulta.nombre, MAX(subconsulta.puntuacion_media) AS puntuacion_media_alta
FROM (
    SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
    FROM Director
    INNER JOIN personal ON director.id_personal = personal.id_personal
    INNER JOIN pelicula ON director.id_director = pelicula.id_director
    INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
    GROUP BY personal.nombre, personal.id_personal
) AS subconsulta
WHERE num_peliculas > 1
GROUP BY subconsulta.id_personal, subconsulta.nombre
ORDER BY puntuacion_media_alta DESC;

"""

consulta_9b2="""
SELECT personal.id_personal, personal.nombre, AVG(critica.puntuacion) AS puntuacion_media, COUNT(pelicula.id_pelicula) AS num_peliculas
FROM Director
INNER JOIN personal ON director.id_personal = personal.id_personal
INNER JOIN pelicula ON director.id_director = pelicula.id_director
INNER JOIN critica ON pelicula.id_pelicula = critica.id_pelicula
GROUP BY personal.nombre, personal.id_personal
HAVING COUNT(pelicula.id_pelicula) > 1
ORDER BY puntuacion_media DESC
LIMIT 1
;
"""

def ejecutar_consulta(consulta,us,contrasena):
    try:
        # Establecer la conexión con la base de datos
        conn =iniciar_sesion()
        print("Conexión exitosa")
         # Crear un cursor para ejecutar la consulta
        cursor = conn.cursor()

        # Ejecutar la consulta
        cursor.execute(consulta)

        # Obtener los nombres de las columnas
        columnas = [desc[0] for desc in cursor.description]

        # Obtener los resultados de la consulta
        resultados = cursor.fetchall()

        # Mostrar los nombres de las columnas
        for columna in columnas:
                print(columna, end=", ")
        print("\n------------------------------------------")
        
        # Mostrar los resultados
        for fila in resultados:
            print(fila)

    except psycopg2.Error as e:
        print(f"Error en la conexión o ejecución de la consulta: {e}")

    finally:
        # Cerrar el cursor y la conexión
        if conn:
            cursor.close()
            conn.close()
            print("Conexión Cerrada")



def login():
    print("===== INICIO DE SESIÓN =====")
    intentos = 3
    while intentos > 0:
        global us 
        global contrasena 
        us = input("usuario: ")
        contrasena= input("Contraseña: ")
        if iniciar_sesion()!=None:
            print("Inicio de sesión exitoso. ¡Bienvenido,", us, "!")
            return True
        else:
            intentos -= 1
            print("Credenciales incorrectas. Inténtelo de nuevo. Intentos restantes:", intentos)
    print("Se agotaron los intentos. Saliendo del programa...")
    return False

def iniciar_sesion():
    ##print("TEST:",us,contrasena)
    try:
        conn = psycopg.connect(
            dbname=db_name,
            user=us,
            password=contrasena,
            host='localhost',
            port='5432'
        )
        print("Conexión a la base de datos establecida.")
        return conn
    except psycopg.OperationalError as e:
        print(f"Error al conectar a la base de datos: {e}")
        return None

def insertar_critica():
    try:
        # Establecer la conexión con la base de datos
        conn = iniciar_sesion()

        critico=input("Inserte el nombre del crítico: ")
        texto=input("Inserte la crítica: ")
        puntuacion=input("Inserte la puntuación: ")
        id_pagweb=input("Inserte la pag_web: ")
        Fecha=input("Inserte la fecha: ")
        id_pelicula=input("Inserte la id de la película: ")

         # Crear un cursor para ejecutar la consulta
        cursor = conn.cursor()
        consulta = """
        INSERT INTO Critica (critico, Texto, Puntuacion, id_pagweb, Fecha, id_pelicula)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        consulta2="""
        SELECT *
        FROM critica
        ORDER BY id_critica DESC
        LIMIT 10
        """

        cursor.execute(consulta,(critico, texto, puntuacion, id_pagweb, Fecha, id_pelicula))
        conn.commit()
        cursor.execute(consulta2)
        resultados=cursor.fetchall()

        print("\nÚltimas 10 críticas insertadas:")
        for resultado in resultados:
            print(resultado)

    except ValueError:
        print("Error: Asegúrese de que la puntuación, la id de la página web y la id de la película sean enteros y la fecha esté en el formato correcto.")
    
    except psycopg2.Error as e:
        print(f"Error en la conexión o ejecución al insertar la crítica: {e}")

    finally:
        # Cerrar el cursor y la conexión
        if conn:
            cursor.close()
            conn.close()
            print("Conexión Cerrada")

def mostrar_menu_principal():
    print("¡Bienvenido! Por favor, seleccione una opción:")
    print("1. Insertar una nueva critica (requerimiento critico)")
    print("2. Realizar una consulta")
    print("0. Salir")

def mostrar_menu_consultas():
    print("¡Bienvenido! Por favor, selecciona una consulta:")
    print("1. Consulta 1: Mostrar el nombre de los directores nacidos en 1970.")
    print("2. Consulta 2: Mostrar todos los idiomas de las películas, junto al número de películas que hay en ese idioma. La salida debe de estar ordenada del idioma con más películas al que tiene menos.")
    print("3. Consulta 3: Mostrar el número de actores nacidos en la década de los 70 (De 1970 a 1979 inclusive)")
    print("4. Consulta 4: Mostrar cuantas críticas a realizado Oscar Gutiérrez junto a la puntuación media de todas sus críticas")
    print("5. Consulta 5a: Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos (SE ORDENAN CONTANDO EL CAMPO ENTERO)")
    print("6. Consulta 5b: Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos (EN COLUMNAS SIN ORDENAR)")
    print("7. Consulta 5c: Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos (ORDENADO Y EN FILAS UNIENDO LOS RESULTADOS)")
    print("8. Consulta 5d1: Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos (EN FILAS Y ORDENADO) con regexp_split_to_table")
    print("9. Consulta 5d2: Mostrar un listado de géneros con la cantidad de películas pertenecientes al mismo, ordenados por los que tienen más películas a los que tienen menos (EN FILAS Y ORDENADO) con unnest y string_to_array")
    print("10. Consulta 6: Mostrar todas las películas que tienen más de un guionista")
    print("11. Consulta 7: Solicitar los actores que hayan actuado en películas en idioma japonés y tengan una duración inferior a 120 minutos y cuyo año de nacimiento sea inferior a 1960. a salida mostrará el actor, el papel que hay interpretado en la película, así como el título, año, idioma, y duración de la misma")
    print("12. Consulta 8a: Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media. Selecciona el título de la película, el ID de la película y la puntuación media de las críticas")
    print("13. Consulta 8b: Mostrar el título y año de lanzamiento de las 3 películas con mayor puntuación media de entre todas las críticas. Mostrar también dicha puntuación media. Selecciona el título de la película, el año y la puntuación media de las tres películas con la puntuación media más alta")
    print("14. Consulta 9a: Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media.")
    print("15. Consulta 9b1: Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media (ELIMINANDO LOS DIRECTORES CON UNA SOLA PELICULA)")
    print("16. Consulta 9b2: Determinar el género o géneros cuyas películas tengan una puntuación media más baja. Mostrar también dicha puntuación media (ELIMINANDO LOS DIRECTORES CON UNA SOLA PELICULA)")
    print("0. Salir")

def consulta_opcion(opcion):
    consultas = {
    "1": consulta_1,
    "2": consulta_2,
    "3": consulta_3,
    "4": consulta_4,
    "5": consulta_5a,
    "6": consulta_5b,
    "7": consulta_5c,
    "8": consulta_5d1,
    "9": consulta_5d2,
    "10": consulta_6,
    "11": consulta_7,
    "12": consulta_8a,
    "13": consulta_8b,
    "14": consulta_9a,
    "15": consulta_9b1,
    "16": consulta_9b2,
}
    consulta=consultas.get(opcion)
    if consulta:
        ejecutar_consulta(consulta,us,contrasena)
    else:
        print("Opción no válida. Por favor, seleccione una opción válida.")

def main(name):
    global db_name
    db_name=name
    login()
    while True:
        mostrar_menu_principal()
        opcion = input("Ingrese el número de la opción que desea realizar (0 para salir): ")
        
        if opcion == "0":
            print("Saliendo del programa...")
            break
        elif opcion == "1":
            if(us=="critico" or us=="admin"):
                insertar_critica()
            else:
                print("usuario sin permisos ")
                break
            
        elif opcion == "2":
            mostrar_menu_consultas()
            opcion_consulta = input("Ingrese el número de la consulta que desea ejecutar (0 para volver): ")
            if opcion_consulta == "0":
                continue  # Volver al menú principal
            consulta_opcion(opcion_consulta)
               
        else:
            print("Opción no válida. Por favor, seleccione una opción válida.")

if __name__ == "__main__":
    if(db_name==""):
        db_name=input("Introduce el nombre de la Base de datos: ")
    main(db_name)