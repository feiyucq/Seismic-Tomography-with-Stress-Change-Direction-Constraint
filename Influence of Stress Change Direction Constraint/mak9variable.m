%根据一副图片构造9个变量，用于测试PSO_hanshuzhi
clc;
clear all;
close all;
myimage=imread('diceng_50_50.bmp');
fft_myimage1=fftshift(fft2(myimage));

cut_fft_myimage=fft_myimage1;

mo=abs(cut_fft_myimage);
fujiao=angle(cut_fft_myimage)*180/pi;

x1=[mo(25,25) fujiao(25,25) mo(25,26) fujiao(25,26) mo(26,25) fujiao(2,25) mo(26,26) fujiao(26,26) mo(25,27) fujiao(25,27)];

myimage=imread('diceng_50_50_2.bmp');
fft_myimage1=fftshift(fft2(myimage));

cut_fft_myimage=fft_myimage1;

mo=abs(cut_fft_myimage);
fujiao=angle(cut_fft_myimage)*180/pi;

x2=[mo(25,25) fujiao(25,25) mo(25,26) fujiao(25,26) mo(26,25) fujiao(2,25) mo(26,26) fujiao(26,26) mo(25,27) fujiao(25,27)];
x=[x1 x2];
theoryResult=PSO_hanshuzhi(x);



