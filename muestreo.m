clc; clear; close all;
pkg load io
pkg load signal

%Frecuencia de muestreo
fm = 40e3;
fm2 = fm / 2;
%Periodo
periodo = 1 / fm;
%Frecuencia de corte
fc = 10e3;

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

save tiempoM.txt tiempoM;

% Calculo coheficientes
fc_1 = 30; % Frecuencia baja
fc_2 = 19e3; % Frecuenta alta
[b_1, a_1]= butter(1, fc_1 / fm2); % Coheficientes filtro paso bajo
[b_2, a_2]= butter(1, fc_2 / fm2 , "high"); % Coheficientes filtro paso alto