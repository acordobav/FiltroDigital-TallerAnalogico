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


%{
%Señal muestreada
data = [tiempoM, voltageM];

%Tamaño de ventana
windowSize = 32; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%Filtro media movil
y = filter(b,a,data);

subplot(2, 1, 1)
plot(data(:,2), ";Entrada;");
xlim([0 3000]);
hold on
subplot(2, 1, 2)
plot(y(:,2), ";Filtro media movil;")
xlim([0 3000]);
%}