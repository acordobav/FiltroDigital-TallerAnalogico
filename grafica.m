clc; clear; close all;

system('python -u "processFiles.py"');

lowpass = load("-ascii", "lowpass-octave.txt");
highpass = load("-ascii", "highpass-octave.txt");
lenght = size(lowpass)(1); 

n = 7; % Cantidad de digitos enteros
m = 16; % Cantidad de digitos flotantes

lowpass_result  = zeros(lenght, 1);
highpass_result = zeros(lenght, 1);

for i = 1:lenght
  % Obtencion del elemento a convertir
  low_element  = lowpass(i,:);
  high_element = highpass(i,:);
  
  lowpass_result(i,1)  = low_element(10:32)*pow2(n-1:-1:-m).' / (127.99999/5);
  highpass_result(i,1) = high_element(10:32)*pow2(n-1:-1:-m).' / (127.99999/5);
end 
figure
plot(lowpass_result);
xlim([0 4000]);

figure
plot(highpass_result);
xlim([0 4000]);