%需要debug
clc;
clear all;
close all;
% load('trace-2018.1.29-160个体-1代.mat')
% load('trace_contrast.mat')
load('trace.mat')
xGlobalBestSize=size(trace(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);

xBest1=trace(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
xBest2=trace(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
figure(2);
surf(double(reverseY(PSO_FFTtoPic(xBest1))));
colormap jet;
caxis([0,255]);
colorbar;
figure(3);
surf(double(reverseY(PSO_FFTtoPic(xBest2))));
colormap jet;
caxis([0,255]);
colorbar;

fGlobalBest=trace(1,30).fGlobalBest(1:1:30,:);
meanBest=zeros(30,1);
for i=1:1:30
    meanBest(i,1)=mean(trace(1,i).Score);
end
figure(4);
plot(1:1:30,fGlobalBest,'r-*');
grid on;
hold on;
plot(1:1:30,meanBest,'g-o');












% xBest1=trace(1,47).xGlobalBest(1,1:(xGlobalBestSizeY/2));
% xBest2=trace(1,47).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
% 
% % xBest1=trace(1,2).xLocalBests(2,1:(xGlobalBestSizeY/2));
% % xBest2=trace(1,2).xLocalBests(2,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
% 
% figure(4);
% 
% surf(double(reverseY(PSO_FFTtoPic(xBest1))));
% title('newest pic1');
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(5);
% surf(double(reverseY(PSO_FFTtoPic(xBest2))));
% title('newest pic2');
% colormap jet;
% caxis([0,255]);
% colorbar;
% nocons_pic1=double(reverseY(PSO_FFTtoPic(xBest1)));
% nocons_pic2=double(reverseY(PSO_FFTtoPic(xBest2)));
% 
% 
% 
% load('trace-2018.2.1.11点-80个体-83代-增加时间约束-限制上下限.mat')
% xGlobalBestSize=size(trace(1,1).xGlobalBest);
% xGlobalBestSizeY=xGlobalBestSize(1,2);
% 
% 
% xBest1=trace(1,50).xGlobalBest(1,1:(xGlobalBestSizeY/2));
% xBest2=trace(1,50).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
% figure(7);
% surf(double(reverseY(PSO_FFTtoPic(xBest1))));
% title('有时间相关约束 pic1');
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(8);
% surf(double(reverseY(PSO_FFTtoPic(xBest2))));
% title('有时间相关约束 pic2');
% colormap jet;
% caxis([0,255]);
% colorbar;
% cons_pic1=double(reverseY(PSO_FFTtoPic(xBest1)));
% cons_pic2=double(reverseY(PSO_FFTtoPic(xBest2)));
% 
% 
% load('cutimag_50_50_9unknow.mat')
% image1=newimag;
% load('cutimag_50_50__2_9unknow.mat')
% image2=newimag;
% figure(9);
% surf(double(reverseY(image1)));
% title('原图频谱截断后 pic1');
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(10);
% surf(double(reverseY(image2)));
% title('原图频谱截断后 pic2');
% colormap jet;
% caxis([0,255]);
% colorbar;
% 
% 
% 
% % real_pic1=double(reverseY(image1));
% % real_pic2=double(reverseY(image2));
% % 
% real_pic1=double(reverseY(imread('diceng_50_50.bmp')));
% real_pic2=double(reverseY(imread('diceng_50_50_2.bmp')));
% figure(11);
% surf(real_pic1);
% title('real-pic1');
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(12);
% surf(real_pic2);
% title('real-pic2');
% colormap jet;
% caxis([0,255]);
% colorbar;
% 
% 
% abs_real_nonpic1=abs((nocons_pic1-real_pic1));
% abs_real_nonpic2=abs((nocons_pic2-real_pic2));
% 
% figure(9);
% surf(abs_real_nonpic1);
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(10);
% surf(abs_real_nonpic2);
% colormap jet;
% caxis([0,255]);
% colorbar;
% 
% abs_real_conspic1=abs(cons_pic1-real_pic1);
% abs_real_conspic2=abs(cons_pic2-real_pic2);
% 
% figure(11);
% surf(abs_real_conspic1);
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(12);
% surf(abs_real_conspic2);
% colormap jet;
% caxis([0,255]);
% colorbar;
% 
% non_to_real_pic1_norm=norm((nocons_pic1-real_pic1),2)
% non_to_real_pic2_norm=norm((nocons_pic2-real_pic2),2)
% 
% cons_to_real_pic1_norm=norm((cons_pic1-real_pic1),2)
% cons_to_real_pic2_norm=norm((cons_pic2-real_pic2),2)







