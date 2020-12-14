clc; clear; close all;
pkg load io
pkg load signal

%Frecuencia de muestreo
fm = 40e3;
fm2 = fm / 2;
%Periodo
periodo = 1 / fm;

%Leer los datos de excel
tiempo = xlsread('data.xlsx', 'Hoja1', 'A2:A35413');

voltage = xlsread('data.xlsx', 'Hoja1', 'B2:B35413');

%Vector de tiempos muestreados
tiempoM = [tiempo(1)];
%Vector de voltajes muestreados
voltageM = [voltage(1)];

maximo = 500e-3; % Tiempo maximo 
valor  = periodo;
index = 1;
while(valor < maximo)
  if valor < tiempo(index)
    tiempoM = [tiempoM; tiempo(index)];
    voltageM = [voltageM; voltage(index)];
    valor += periodo; 
  end
  index += 1;  
endwhile

% Guardar valores muestreados
save voltageM.txt voltageM

% Calculo coheficientes
fc_1 = 25; % Frecuencia baja
fc_2 = 1.8e3; % Frecuenta alta
[b_1, a_1]= butter(1, fc_1 / fm2); % Coeficientes filtro paso bajo
[b_2, a_2]= butter(1, fc_2 / fm2, "high"); % Coeficientes filtro paso alto


n = 16; % cantidad numeros enteros
m = 16; % cantidad numeros flotantes

% Coeficientes filtro paso bajo
bin_low_b0 = erase(num2str(fix(rem(abs(b_1(1))*pow2(-(n-1):m),2)))," ");
bin_low_b1 = erase(num2str(fix(rem(abs(b_1(2))*pow2(-(n-1):m),2)))," ");
bin_low_a0 = erase(num2str(fix(rem(abs(a_1(1))*pow2(-(n-1):m),2)))," ");
bin_low_a1 = erase(num2str(fix(rem(abs(a_1(2))*pow2(-(n-1):m),2)))," ");

% Coeficientes filtro paso alto
bin_high_b0 = erase(num2str(fix(rem(abs(b_2(1))*pow2(-(n-1):m),2)))," ");
bin_high_b1 = erase(num2str(fix(rem(abs(b_2(2))*pow2(-(n-1):m),2)))," ");
bin_high_a0 = erase(num2str(fix(rem(abs(a_2(1))*pow2(-(n-1):m),2)))," ");
bin_high_a1 = erase(num2str(fix(rem(abs(a_2(2))*pow2(-(n-1):m),2)))," ");

% Escritura archivo txt con las muestras en formato binario
fid = fopen('data.txt', 'w' );
for i = 1:size(voltageM)
  vol = voltageM(i);
  if vol > 5 % Truncar valores mayores a 5
    vol = 5;
  end  
  if vol < 0 % Truncuar valores menores a 0
    vol = 0;
  end 
 
  max = 127.99999;
  number = (max/5)*vol; % float point number

  n = 7; % number bits for integer part of your number
  m = 16; % number bits for fraction part of your number

  bin = fix(rem(number*pow2(-(n-1):m),2)); % binary number
  string = erase(num2str(bin)," ");
  fprintf(fid, '000000000%s\n',string);
end 
fclose(fid);

% Obtener archivo .mif con los datos codificados
system('python -u "mif_gen.py"');