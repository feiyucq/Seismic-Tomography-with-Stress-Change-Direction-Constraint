% ����diceng_50_50.bmp�����µ�ͼƬ�����Ķ�����λ��
clc;
clear all;
close all;
c_tupian='diceng_50_50_counterclockwise_90.bmp';
myjpg=imread(c_tupian);
c_tupian2='diceng_50_50_counterclockwise_90_2.bmp';
myjpg2=imread(c_tupian2);
% ʾ��
% imshow(uint8(test));%��ʾͼ��
% imwrite(uint8(test),'diceng_5_10.bmp','bmp');

% ִ�д˲���֮ǰ�ֹ��ı�ͼƬ
imwrite(uint8(myjpg2),'diceng_50_50_counterclockwise_90_2.bmp','bmp');
