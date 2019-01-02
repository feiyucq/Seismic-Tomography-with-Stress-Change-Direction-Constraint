%∆µ”Ú«–Õº∆¨
clc;
clear all;
close all;
myimage=imread('diceng_50_50_2.bmp');
fft_myimage=fftshift(fft2(myimage));
cut_fft_myimage=fft_myimage;

mo=abs(cut_fft_myimage);
fujiao=angle(cut_fft_myimage);
newimag=uint8(real(ifft2(ifftshift(cut_fft_myimage))));