%clc; clear; close all;

x = 0.00235;

max = 127.99999;
number = x;%(max/5)*x;

n = 7;
m = 16;

% number: your float point number
% n:      number bits for integer part of your number      
% m:      number bits for fraction part of your number
% bin:    binary number

bin = fix(rem(number*pow2(-(n-1):m),2));
a = erase(num2str(bin)," ");

%d2b = [1 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 1 0 1 1 1 1];
b2d = bin*pow2(n-1:-1:-m).' / (127.99999/5);