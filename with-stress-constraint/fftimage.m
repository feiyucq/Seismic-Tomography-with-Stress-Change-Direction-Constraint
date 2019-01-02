%查看图片的频谱,图片为彩色
clc;
clear all;
close all;
myimage=imread('diceng_50_50.bmp');
% myimage1=myimage(:,:,1);%取数组的第一页
fft_myimage1=fftshift(fft2(myimage));%取二维傅里叶变换
abs_fft_myimage1=abs(fft_myimage1);%取模
angle_fft_myimage1=angle(fft_myimage1);%取幅角
figure(1);
surf(abs_fft_myimage1);%显示幅度频谱
title('abs-fft-myimage1');
grid on;

figure(2);
surf(angle_fft_myimage1);%显示相位谱
title('angle-fft-myimage1');
grid on;

figure(4);
image(myimage);

fft_myimage2=fft_myimage1;
% newimag=uint8(real(ifft2(ifftshift(fft_myimage1))));
% figure(3);
% image(newimag);

fft_myimage2=fftshift(fft2(newimag));%取二维傅里叶变换
abs_fft_myimage2=abs(fft_myimage2);%取模
angle_fft_myimage2=angle(fft_myimage2);%取幅角
figure(4);
surf(abs_fft_myimage2);%显示幅度频谱
title('abs-fft-myimage2');
grid on;

figure(5);
surf(angle_fft_myimage2);%显示相位谱
title('angle-fft-myimage2');
grid on;
% figure(3);
% imshow(myimage1);
% title('myimage1');
% %保留频谱中45-55部分，其余置0
% cut_fft_myimage1=zeros(100,100);
% cut_fft_myimage1(45:55,45:55)=fft_myimage1(45:55,45:55);
% figure(4);
% grid on;
% surf(abs(cut_fft_myimage1));
% title('spec of cut-fft-myimage1');
% 
% cutimag=uint8(real(ifft2(ifftshift(cut_fft_myimage1))));
% figure(5);
% % imshow(myimage1);
% imshow(cutimag);
% title('cut-fft-myimage1');

%取幅度谱的二维傅里叶变换
% fft_abs_fft_myimage1=fftshift(fft2(abs_fft_myimage1));%取幅度谱的二维傅里叶变换
% abs_fft_abs_fft_myimage1=abs(fft_abs_fft_myimage1);%取幅度谱的二维傅里叶变换的幅度谱
% figure(4);
% surf(abs_fft_abs_fft_myimage1);%显示幅度频谱
% grid on;