import psycopg2  # Importar el módulo psycopg2 para interactuar con PostgreSQL
from psycopg2 import sql  # Importar sql de psycopg2 para generar consultas SQL de forma segura
import tkinter as tk  # Importar tkinter para la interfaz gráfica 
from tkinter import filedialog  # Importar filedialog de tkinter para seleccionar directorios
import csv  # Importar módulo csv para trabajar con archivos CSV
import externalconnection  # Importar módulo externalconnection para las consultas de la práctica


# Variables globales
directorio_global = ""  # Variable global para almacenar el directorio seleccionado
nombre = ""  # Variable global para almacenar el nombre de la base de datos

def crear_nueva_basededatos(usuario, contrasena,nombre):
    """
    Crea una nueva base de datos en PostgreSQL.

    Args:
    - usuario: Nombre de usuario por defecto de PostgreSQL.
    - contrasena: Contraseña del usuario de PostgreSQL.
    - nombre: Nombre de la base de datos a crear.

    Returns:
    - True si la base de datos se creó correctamente, False si hubo algún error.
    """
    try:
        # Establecer la conexión con PostgreSQL (asegúrate de que el servidor esté activo y accesible)
        conn = psycopg2.connect(
            dbname='postgres',  # Conectar a la base de datos 'postgres' para ejecutar la consulta CREATE DATABASE
            user=usuario,
            password=contrasena,
            host='localhost',
            port='5432'
        )
        print("Conexión a PostgreSQL establecida.")

        conn.autocommit = True
        # Crear un cursor para ejecutar comandos SQL
        cursor = conn.cursor()

        # Comando SQL para crear una nueva base de datos
        consulta = f"CREATE DATABASE {nombre};"

        # Ejecutar el comando SQL
        cursor.execute(consulta)
        print(f"Base de datos '{nombre}' creada correctamente.")
        return True

    except psycopg2.Error as e:
        print(f"Error al crear la base de datos: {e}")
        return False

    finally:
        # Cerrar cursor y conexión
        if conn:
            cursor.close()
            conn.close()
            print("Conexión cerrada.")

def seleccionar_directorio():
    """
    Función para abrir un diálogo de selección de directorio y 
    almacenar el directorio seleccionado en una variable global.
    """
    global directorio_global  # Accedemos a la variable global

    directorio_seleccionado = filedialog.askdirectory() # Abrir el diálogo de selección de directorio
    if directorio_seleccionado:
        directorio_global = directorio_seleccionado  # Almacenamos el directorio seleccionado
        
    print("Directorio almacenado en la variable global:", directorio_global)

def iniciar_sesion(usuario,contrasena):
    """
    Función para establecer una conexión a la base de datos PostgreSQL.

    Parameters:
    - usuario: nombre de usuario de PostgreSQL
    - contrasena: contraseña del usuario de PostgreSQL

    Returns:
    - Objeto de conexión psycopg2 si la conexión se establece correctamente, None si hubo un error
    """
    try:
        conn = psycopg2.connect(
            dbname=nombre,
            user=usuario,
            password=contrasena,
            host='localhost',
            port='5432'
        )
        print("Conexión a la base de datos establecida.")
        return conn
    except psycopg2.OperationalError as e:
        print(f"Error al conectar a la base de datos: {e}")
        return None
    
def ejecutar_archivo_sql(archivo_sql, conn):
    """
    Función para ejecutar comandos SQL desde un archivo.

    Parameters:
    - archivo_sql: ruta del archivo SQL a ejecutar
    - conn: objeto de conexión psycopg2 a la base de datos

    """
    try:
        cursor = conn.cursor()

        with open(archivo_sql, 'r') as sql_file:
            sql_commands = sql_file.read()

        # Ejecutar todos los comandos SQL del archivo
        cursor.execute(sql_commands)
        print("Archivo SQL ejecutado correctamente.")

        cursor.close()
        conn.commit()

    except psycopg2.Error as e:
        print(f"Error al ejecutar archivo SQL: {e}")

def ejecutar_archivo_sql_directorio(archivo_sql, conn):
    """
    Función para ejecutar comandos SQL desde un archivo, reemplazando una cadena específica por el directorio global.

    Parameters:
    - archivo_sql: ruta del archivo SQL a ejecutar
    - conn: objeto de conexión psycopg2 a la base de datos
    """
    try:
        cursor = conn.cursor()

        with open(archivo_sql, 'r') as sql_file:
            sql_commands = sql_file.read()

        # Reemplazar 'DIRECTORIO' por directorio_global
        sql_commands = sql_commands.replace('DIRECTORIO', directorio_global.replace('\\', '/'))  # Ajustar formato de ruta


        # Ejecutar todos los comandos SQL del archivo
        cursor.execute(sql_commands)
        print("Archivo SQL ejecutado correctamente.")

        cursor.close()
        conn.commit()

    except psycopg2.Error as e:
        print(f"Error al ejecutar archivo SQL: {e}")    

def crear_tablas_intermedias(usuario,contrasena):
    """
    Función para crear tablas intermedias en la base de datos PostgreSQL.

    Parameters:
    - usuario: nombre de usuario de PostgreSQL
    - contrasena: contraseña del usuario de PostgreSQL
    """
    print(directorio_global+"/Intermedio.sql  ", nombre)
    ejecutar_archivo_sql(directorio_global+"/Intermedio.sql",iniciar_sesion(usuario,contrasena))
    checkformatocsv("/csv/peliculas")


    ejecutar_archivo_sql_directorio(directorio_global+"/intermedioFill.sql",iniciar_sesion(usuario,contrasena))

def crear_tablas_finales(usuario, contrasena):
    """
    Función para crear tablas finales en la base de datos PostgreSQL desde las tablas intermedias.

    Parameters:
    - usuario: nombre de usuario de PostgreSQL
    - contrasena: contraseña del usuario de PostgreSQL
    """
    print(directorio_global+"/generateTables.sql  ", nombre)
    ejecutar_archivo_sql(directorio_global+"/generateTables.sql",iniciar_sesion(usuario,contrasena))
    ejecutar_archivo_sql(directorio_global+"/populateTables.sql",iniciar_sesion(usuario,contrasena))

def crear_disparadores(usuario,contrasena):
    """
    Función para crear disparadores en la base de datos PostgreSQL.

    Parameters:
    - usuario: nombre de usuario de PostgreSQL
    - contrasena: contraseña del usuario de PostgreSQL
    """
    print(directorio_global+"/generateTriggers.sql  ", nombre)
    ejecutar_archivo_sql(directorio_global+"/generateTriggers.sql",iniciar_sesion(usuario,contrasena))

def checkformatocsv(directorio):
    """
    Función para verificar y corregir el formato de un archivo CSV.

    Parameters:
    - directorio: directorio donde se encuentra el archivo CSV (relativo al directorio global)
    """
    input_file = directorio_global + directorio + ".csv"
    output_file = directorio_global + directorio + "_comillas.csv"
    output_file2=directorio_global + directorio + "_corregido.csv"
    with open(input_file, newline="", encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        rows = []
        for row in reader:
            new_row = []
            for value in row:
                # Eliminar todas las comillas simples y dobles de la cadena
                value = value.replace('"', '').replace("'", '')
                new_row.append(value)
            rows.append(new_row)

    with open(output_file, "w", newline="", encoding='utf-8') as new_csvfile:
        writer = csv.writer(new_csvfile)
        writer.writerows(rows)

    print(f"Se ha creado el archivo '{output_file}' con los cambios aplicados.")
    errors_found = False

    # Verificar errores en el archivo CSV
    with open(output_file, 'r', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile, delimiter='\t')
        for i, row in enumerate(reader):
            if len(row) != 8:  # Si hay un error en la cantidad de columnas
                print(f"Error en la línea {i+1}: {row}")
                errors_found = True

    # Si se encontraron errores, dar la opción de corregir
    if errors_found:
        choice = input("Se encontraron errores. ¿Deseas corregirlos? (1 para sí, 0 para no): ")
        if choice == "1":
            with open(output_file, 'r', encoding='utf-8') as csvfile, open(output_file2, 'w', encoding='utf-8', newline='') as correctedfile:
                reader = csv.reader(csvfile, delimiter='\t')
                writer = csv.writer(correctedfile, delimiter='\t')
                for row in reader:
                    if len(row) == 7:  # Si falta una columna
                        row.append('NULL')
                    writer.writerow(row)
            print(f"Archivo corregido guardado en {output_file2}")
        elif choice == "0":
            print("No se realizaron correcciones. Saliendo...")
        else:
            print("Entrada no válida. Saliendo...")
    else:
        print("No se encontraron errores en el archivo CSV.")

def menu_principal():
    global nombre # Acceder a la variable global 'nombre' para almacenar el nombre de la base de datos
    print("¡Bienvenido! Introduce el nombre de la base de datos que desee crear")
    print("0. Salir")
    contrasena=input("Contrasena db postgres: ")
    nombre=input("Nombre Base de datos: ")
    if crear_nueva_basededatos("postgres",contrasena,nombre):
    # Si se crea la base de datos correctamente
        print("Seleccione el directorio donde esté almacenado el proyecto.")
        seleccionar_directorio()  # Permite al usuario seleccionar un directorio
        crear_tablas_intermedias("postgres", contrasena)  # Crear tablas intermedias en la base de datos
        crear_tablas_finales("postgres", contrasena)  # Crear tablas finales en la base de datos
        crear_disparadores("postgres", contrasena)  # Crear disparadores en la base de datos
        externalconnection.main(nombre)  # Llamar a una función externa con el nombre de la base de datos que realiza laas consultas 

    else:
        # Si la base de datos ya existe
        print("Base de datos ya creada. Puede realizar las siguientes funciones")
        externalconnection.main(nombre)
   
if __name__ == "__main__":
    menu_principal()