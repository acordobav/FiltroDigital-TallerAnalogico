def readData(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    data = fileObject.read().split(" ")

    return data

def processFile(filename, outputname):
    f = open(outputname, "w") # Apertura del archivo de escritura
    data = readData(filename)
    data.pop() # Eliminar ultimo elemento, es nulo
    
    """
    header = \
        "# Created by Octave 5.2.0, Mon Nov 30 21:47:55 2020 GMT <unknown@DESKTOP-01LM6L0> \
        # name: lowpass \
        # type: matrix \
        # rows: " + str(len(data)) + " \
        # columns: 32"*/
    """

    for element in data:
        numbers = list(element)
        for number in numbers:
            f.write(" " + number)
        f.write("\n") # Escribir salto de linea





processFile("src/simulation/modelsim/lowpass.txt", "lowpass-octave.txt")
processFile("src/simulation/modelsim/highpass.txt", "highpass-octave.txt")