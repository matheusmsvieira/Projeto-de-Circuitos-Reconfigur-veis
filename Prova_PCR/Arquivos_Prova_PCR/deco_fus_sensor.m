% Estima-se o MSE usando a funcao my_fus_sensor como modelo de referencia

close all
clc
clear all
N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa

bin_outfusao=textread('res_FS.txt', '%s');
xIR=textread('floatx_IR.txt', '%f');
xUL=textread('floatx_UL.txt', '%f');

sk=0.1;
sz=0.5;

result_hw=zeros(N,1);
result_sw=zeros(N,1);

for i=1:N-1
    result_hw(i,1)=bin2float(cell2mat(bin_outfusao(i)),EW,FW);
    gkmais1 = sk/(sk+sz);
    result_sw(i) = my_fus_sensor(xIR(i), xUL(i), gkmais1);
    sk = sk-(gkmais1*sk);
    erro(i) = sum((result_hw(i,:) - result_sw(i,:)).^2);
end

result_hw(1:10,:)
result_sw(1:10,:)
MSE = sum(erro)/N
plot(erro)

