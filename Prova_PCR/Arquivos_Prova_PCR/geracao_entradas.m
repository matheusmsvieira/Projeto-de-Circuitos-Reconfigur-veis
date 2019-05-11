clc
clear all
close all
N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa
% valores de entrada entre 0 e 1.0
%az = 0.5;   %limite inferior de sigmaz
%bz = 0.75;  %limite superior de sigmaz
%ak = 0.1;   %limite inferior de sigmak
%bk = 0.25;  %limite superior de sigmak
%sigma_k=0.1;
%sigma_z=0.5;

%floatsz = fopen('floatsz.txt','w');
%floatsk = fopen('floatsk.txt','w');
floatx_IR = fopen('floatx_IR.txt','w');
floatx_UL = fopen('floatx_UL.txt','w');

%binsz = fopen('sz.txt','w');
%binsk = fopen('sk.txt','w');
binx_IR = fopen('x_IR.txt','w');
binx_UL = fopen('x_UL.txt','w');
binx_IR_coe = fopen('x_IR_coe.txt','w');
binx_UL_coe = fopen('x_UL_coe.txt','w');

% rand('seed',06111991); % seed for random number generator 
rand('twister',140155546); % seed for random number generator (Matricula)
                            
for i=1:N                   %Fórmula para range => r=(b-a)*[0 1] + a;
    %sz=(bz-az)*rand() + az; % range sigmaz = [0.5 0.75]
    %sk=(bk-ak)*rand() + ak; % range sigmak = [0.1 0.25]
    x_IR=100 + sigma_z*randn();
    x_UL=100 + sigma_k*randn();
    
    %szbin=float2bin(EW,FW,sz);
    %skbin=float2bin(EW,FW,sk);
    x_IRbin=float2bin(EW,FW,x_IR);
    x_ULbin=float2bin(EW,FW,x_UL);  
    
    %fprintf(floatsz,'%f\n',sz);
    %fprintf(floatsk,'%f\n',sk);
    fprintf(floatx_IR,'%f\n',x_IR);
    fprintf(floatx_UL,'%f\n',x_UL);
    
    %fprintf(binsz,'%s\n',szbin);
    %fprintf(binsk,'%s\n',skbin);
    fprintf(binx_IR,'%s\n',x_IRbin);
    fprintf(binx_UL,'%s\n',x_ULbin);
    fprintf(binx_IR_coe,'%s,\n',x_IRbin); %gravar no arquivo .coe
    fprintf(binx_UL_coe,'%s,\n',x_ULbin); %gravar no arquivo .coe

end

fclose('all');
% fclose(floatsz);
% fclose(floatsk);
% 
% fclose(binsz);
% fclose(binsz);
