clc
clear
pkg load signal

% sf = Frecuencia de muestreo
sf = 40e3; sf2 = sf / 2;
fc_1 = 25; %160; % Paso bajo
fc_2 = 1.8e3; %160; % paso alto

%Leer los datos de excel
tiempo = xlsread('data.xlsx', 'Hoja1', 'A2:A35413');

voltage = xlsread('data.xlsx', 'Hoja1', 'B2:B35413');

%Vector de tiempos muestreados
tiempoM = [tiempo(1)];
%Vector de voltajes muestreados
voltageM = [voltage(1)];

periodo = 1 / sf;
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

% Frecuencia de corte = Frec. corte real / sf2
data = voltageM;
[b_1 , a_1]= butter(1, fc_1 / sf2);
filtered_1 = filter(b_1, a_1, voltageM);
[b_2, a_2]= butter(1, fc_2 / sf2 , "high");
filtered_2 = filter(b_2, a_2, voltageM) ;
clf
subplot(4, 1, 1)
plot(data, ";Entrada;");
axis([0 4000])
subplot(4, 1, 2);
plot(filtered_1(:, 1), ";Filtro pasa bajas;")
axis([0 4000])
subplot(4, 1, 3)
plot(filtered_2(:, 1 ), "; Filtro pasa altas;")
axis([0 8000])
subplot(4, 1, 4)
plot(filtered_2(:, 1 ), "; Filtro pasa altas;")
axis([0 4000])