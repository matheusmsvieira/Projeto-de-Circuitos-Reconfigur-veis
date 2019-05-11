% PCR 2019
% Engenharia Eletrônica
% Universidade de Brasilia
% 
% funcao my_fus_sensor.m para N entradas
% recebe vetor de entradas x_IR, x_UL

clc
clear all
close all
N=100;
%Gerador de sigmas aleatórios
%az = 0.5;   %limite inferior de sigmaz
%bz = 0.75;  %limite superior de sigmaz
%ak = 0.1;   %limite inferior de sigmak
%bk = 0.25;  %limite superior de sigmak
%sz=(bz-az)*rand() + az; % range sigmaz = [0.5 0.75]
%sk=(bk-ak)*rand() + ak; % range sigmak = [0.1 0.25]
sz=0.5;
sk0=0.1;
xUL=importdata('floatx_UL.txt');
xIR=importdata('floatx_IR.txt');

x_fus = zeros(N,1);
gkmais1 = zeros(N,1);
sk = sk0;

for i=1:1:N
    gkmais1(i) = sk/(sk+sz);
    x_fus(i) = xUL(i) + gkmais1(i)*(xIR(i) - xUL(i));
    sk = sk - gkmais1(i)*sk;
end

x_fus_float = fopen('x_fus_float.txt', 'w');
fprintf(x_fus_float,'%f\n', x_fus);
fclose('all');
close all;


