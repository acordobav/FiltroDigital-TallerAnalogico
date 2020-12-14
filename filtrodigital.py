lista = []

path = "/home/fagonar96/Documents/TDA - Proyecto4/data.txt"
with open(path, 'r') as file:
    #Leer cada linea
    for line in file:
        #Leer cada palabra:
        for word in line.split():
            lista.append(word)

#Funcion de suma
def suma(A, B):
    Ai = A
    Bi = B

    Ai = int(Ai,2)
    Bi = int(Bi,2)
    #print(len(A))
    #print(len(B))
    
    Sol = ""
    S = '{0:032b}'.format(Ai+Bi)
    #print(S)
    #Overflow Suma
    if((len(S) > len(A)) or (len(S) > len(B))):
        S = S[1:]
        #Overflow
        if((int(A[0]) == 0) and (int(B[0]) == 0) and (int(S[0]) == 1)):
            S = "01111111111111111111111111111111"
        #Underflow
        elif((int(A[0]) == 1) and (int(B[0]) == 1) and (int(S[0]) == 0)):
            S = "10000000000000000000000000000001"
        
    elif((int(A[0]) == 0) and (int(B[0]) == 0) and (int(S[0]) == 1)):
        S = "01111111111111111111111111111111"
    elif((int(A[0]) == 1) and (int(B[0]) == 1) and (int(S[0]) == 0)):
        S = "10000000000000000000000000000001"
    Sol = S
    return Sol

#Funcion de multiplicacion
def multiplicacion(A, B):
    Am = ""
    Bm = ""
    Result = ""
    if(A[0] == "1"):
        for i in A:
            if i == "0": Am += "1"
            else: Am += "0"
        Am = int(Am,2)+1
        Am = '{0:032b}'.format(Am)
    else:
        Am = int(A,2)
        Am = '{0:032b}'.format(Am)
    if(B[0] == "1"):
        for i in B:
            if i == "0": Bm += "1"
            else: Bm += "0"
        Bm = int(Bm,2)+1
        Bm = '{0:032b}'.format(Bm)
    else:
        Bm = int(B,2)
        Bm = '{0:032b}'.format(Bm)

    #print(Am)
    a = Am[0:len(Am)//2]
    #print(a)
    #print(int(a,2))
    b = Am[len(Am)//2:]
    #print(b)
    #print(int(b,2))
    #print(Bm)
    c = Bm[0:len(Bm)//2]
    #print(c)
    #print(int(c,2))
    d = Bm[len(Bm)//2:]
    #print(d)
    #print(int(d,2))
    #print("")
    high = int(a,2) * int(c,2)
    high = high * 65536
    #print(high)
    mid = (int(a,2) * int(d,2)) + (int(b,2) * int(c,2))
    #print(mid)
    low = int(b,2) * int(d,2)
    low = low // 65536
    #print(low)

    R = '{0:032b}'.format(high + mid + low)
    #print(R)

    #Overflow Multiplicacion
    if((len(R) > len(A)) | (len(R) > len(B))):
        R = R[-31:-1]
        if(int(A[0]) ^ int(B[0])):
            R = "10000000000000000000000000000001"
        else:
            R = "01111111111111111111111111111111"
    elif((int(A[0]) == 0) and (int(B[0]) == 0) and (int(R[0]) == 1)):
        R = "01111111111111111111111111111111"
    elif((int(A[0]) == 1) and (int(B[0]) == 1) and (int(R[0]) == 0)):
        R = "10000000000000000000000000000001"

    #Resultado con algun operando negativo
    if(int(A[0]) ^ int(B[0])):
        for i in R:
            if i == "0": Result += "1"
            else: Result += "0"
        Result = int(Result,2)+1
        Result = '{0:032b}'.format(Result)
    else: Result = R
    return Result

#Filtro IIR
def filtroDigital(datos, a1, b0, b1):
    sum_offset = "00000000001111111111111111111111" #2.5
    res_offset = "11111111110000000000000000000001" #-2.5
    wn1 = "00000000000000000000000000000000"
    resultados = []
    for i in datos:
        xn = suma(i, res_offset)
        #print("Dato: "+i)
        #print("Offset: "+res_offset)
        #print("Xn: "+xn)
        #print(" ")
        wn1_a1 = multiplicacion(wn1, a1)
        #print("wn1: "+wn1)
        #print("a1: "+a1)
        #print("wn1_a1: "+wn1_a1)
        #print(" ")
        wn = suma(xn, wn1_a1)
        #print("xn: "+xn)
        #print("wn1_a1: "+wn1_a1)
        #print("wn: "+wn)
        #print(" ")
        wn_bo = multiplicacion(wn, b0)
        #print("wn: "+wn)
        #print("b0: "+b0)
        #print("wn_bo: "+wn_bo)
        #print(" ")
        wn1_b1 = multiplicacion(wn1, b1)
        #print("wn1: "+wn1)
        #print("b1: "+b1)
        #print("wn1_b1: "+wn1_b1)
        #print(" ")
        yn = suma(wn_bo,wn1_b1)
        #print("wn_bo: "+wn_bo)
        #print("wn1_b1: "+wn1_b1)
        #print("yn: "+yn)
        #print(" ")
        resultados.append(suma(yn, sum_offset))
        #print("yn: "+yn)
        #print("offset: "+sum_offset)
        #print("result: "+suma(yn, sum_offset))
        #print(" ")
        wn1 = wn
        #print("wn1: "+wn1)
        #print(" ")
        #print(" ")
    return resultados


#Prueba 2.5 + 1.3
#print(suma("00000000001111111111111111111111", "00000000001000010100011110101101"))
#Caso Carry
#print(suma("11111111110110011001100110011001", "00000000001111111111111111111111"))
#Caso Carry Negativo
#print(suma("11111111110110011001100110011001", "10000000001111111111111111111111"))
#Prueba -2.5 + 1.3
#print(suma("11111111110000000000000000000001", "00000000001000010100011110101101"))
#Caso Overflow
#print(suma("01111111111111111111111111111111", "01111111111111111111111111111111"))
#Caso Underflow
#print(suma("10000000000000000000000000000001", "10000000000000000000000000000000"))



#Coeficientes
lowA1 = "00000000000000001111111011111111"
lowB0 = "00000000000000000000000010000000"
lowB1 = "00000000000000000000000010000000"

highA1 = "11111111111111110100011000000010"
highB0 = "00000000000000000010001100000000"
highB1 = "11111111111111111101110100000000"


#Filtro Paso Bajo
lista2 = filtroDigital(lista, lowA1, lowB0, lowB1)
f = open("lowpass.txt", "w")
for data in lista2:
    f.write(data + " ")
f.close()

#Filtro Paso Alto
lista3 = filtroDigital(lista, highA1, highB0, highB1)
f = open("highpass.txt", "w")
for data in lista3:
    f.write(data + " ")
f.close()

