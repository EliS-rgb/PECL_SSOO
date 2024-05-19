import csv

input_file = 'C:\\Users\\elisg\\Desktop\\csv\\peliculas.csv'
output_file = 'C:\\Users\\elisg\\Desktop\\csv\\peliculas_corrected.csv'

errors_found = False

# Verificar errores en el archivo CSV
with open(input_file, 'r', encoding='utf-8') as csvfile:
    reader = csv.reader(csvfile, delimiter='\t')
    for i, row in enumerate(reader):
        if len(row) != 8:  # Si hay un error en la cantidad de columnas
            print(f"Error en la línea {i+1}: {row}")
            errors_found = True

# Si se encontraron errores, dar la opción de corregir
if errors_found:
    choice = input("Se encontraron errores. ¿Deseas corregirlos? (1 para sí, 0 para no): ")
    if choice == "1":
        with open(input_file, 'r', encoding='utf-8') as csvfile, open(output_file, 'w', encoding='utf-8', newline='') as correctedfile:
            reader = csv.reader(csvfile, delimiter='\t')
            writer = csv.writer(correctedfile, delimiter='\t')
            for row in reader:
                if len(row) == 7:  # Si falta una columna
                    row.append('NULL')
                writer.writerow(row)
        print(f"Archivo corregido guardado en {output_file}")
    elif choice == "0":
        print("No se realizaron correcciones. Saliendo...")
    else:
        print("Entrada no válida. Saliendo...")
else:
    print("No se encontraron errores en el archivo CSV.")
