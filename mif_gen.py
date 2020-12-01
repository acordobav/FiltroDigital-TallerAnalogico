def readData(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    data = fileObject.read().split("\n")

    return data

def mif_gen(elements, filename):
    """
    Funcion para almacenar el mensaje codificado en un archivo .mif
    :param encoded_message: Mensaje codificado, string donde cada
    :param filename: nombre del archivo .mif
    en el caso del corrimiento circular a la cantidad de bits de la rotacion
    :return:
    """
    f = open(filename + '.mif', "w") # Apertura del archivo .mif

    # Contenido inicial del archivo .mif
    initial_data = "WIDTH=32;\n" \
                   "DEPTH=32768;\n" \
                   "\n" \
                   "ADDRESS_RADIX=HEX;\n" \
                   "DATA_RADIX=HEX;\n" \
                   "\n" \
                   "CONTENT BEGIN\n"
    f.write(initial_data)
    num_element = 0

    # Escritura del mensaje codificado
    for element in elements:
        el = hex(num_element).replace('0x', '') # Numero de elemento
        data = hex(int(element, 2)).replace('0x', '') # Dato que debe ser escrito
        f.write("\t" + el + "   :   " + data + ";\n")
        num_element += 1

    # Contenido final del archivo .mif
    final_data = "\t[" + hex(num_element).replace('0x', '') +"..7FFF]  :   0;\n" \
                 "END;"
    f.write(final_data)
    f.close()


data = readData('data.txt')
data.pop()  # Eliminar ultimo elemento, es un espacio vacio

mif_gen(data, 'src/simulation/modelsim/data')
mif_gen(data, 'src/data')