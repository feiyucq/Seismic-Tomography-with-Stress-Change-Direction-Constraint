%�鿴ͼƬ��Ƶ��,ͼƬΪ��ɫ
clc;
clear all;
close all;
myimage=imread('diceng_50_50.bmp');
% myimage1=myimage(:,:,1);%ȡ����ĵ�һҳ
fft_myimage1=fftshift(fft2(myimage));%ȡ��ά����Ҷ�任
abs_fft_myimage1=abs(fft_myimage1);%ȡģ
angle_fft_myimage1=angle(fft_myimage1);%ȡ����
figure(1);
surf(abs_fft_myimage1);%��ʾ����Ƶ��
title('abs-fft-myimage1');
grid on;

figure(2);
surf(angle_fft_myimage1);%��ʾ��λ��
title('angle-fft-myimage1');
grid on;

figure(4);
image(myimage);

fft_myimage2=fft_myimage1;
% newimag=uint8(real(ifft2(ifftshift(fft_myimage1))));
% figure(3);
% image(newimag);

fft_myimage2=fftshift(fft2(newimag));%ȡ��ά����Ҷ�任
abs_fft_myimage2=abs(fft_myimage2);%ȡģ
angle_fft_myimage2=angle(fft_myimage2);%ȡ����
figure(4);
surf(abs_fft_myimage2);%��ʾ����Ƶ��
title('abs-fft-myimage2');
grid on;

figure(5);
surf(angle_fft_myimage2);%��ʾ��λ��
title('angle-fft-myimage2');
grid on;
% figure(3);
% imshow(myimage1);
% title('myimage1');
% %����Ƶ����45-55���֣�������0
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

%ȡ�����׵Ķ�ά����Ҷ�任
% fft_abs_fft_myimage1=fftshift(fft2(abs_fft_myimage1));%ȡ�����׵Ķ�ά����Ҷ�任
% abs_fft_abs_fft_myimage1=abs(fft_abs_fft_myimage1);%ȡ�����׵Ķ�ά����Ҷ�任�ķ�����
% figure(4);
% surf(abs_fft_abs_fft_myimage1);%��ʾ����Ƶ��
% grid on;