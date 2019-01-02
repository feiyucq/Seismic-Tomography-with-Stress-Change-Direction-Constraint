% 基于diceng_50_50.bmp制作新的图片，仅改动部分位置
clc;
clear all;
close all;
c_tupian='diceng_50_50_counterclockwise_90.bmp';
myjpg=imread(c_tupian);
c_tupian2='diceng_50_50_counterclockwise_90_2.bmp';
myjpg2=imread(c_tupian2);
% 示例
% imshow(uint8(test));%显示图像
% imwrite(uint8(test),'diceng_5_10.bmp','bmp');

% 执行此步骤之前手工改变图片
imwrite(uint8(myjpg2),'diceng_50_50_counterclockwise_90_2.bmp','bmp');
