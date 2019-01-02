%需要debug
clc;
clear all;
close all;
% load('trace-2018.1.29-160个体-1代.mat')
% load('trace_contrast.mat')
load('trace1.mat');
press_trace_1=trace;
load('trace2.mat');
press_trace_2=trace;
load('trace3.mat');
press_trace_3=trace;
load('trace_contrast1.mat');
nopress_trace_1=trace;
load('trace_contrast2.mat');
nopress_trace_2=trace;
load('trace_contrast3.mat');
nopress_trace_3=trace;
load('cutimag_50_50_9unknow.mat');
thero_pic1=newimag;
load('cutimag_50_50__2_9unknow.mat');
thero_pic2=newimag;


close all;


xGlobalBestSize=size(press_trace_1(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
press_trace_1_xBest1=press_trace_1(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
press_trace_1_xBest2=press_trace_1(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

xGlobalBestSize=size(press_trace_2(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
press_trace_2_xBest1=press_trace_2(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
press_trace_2_xBest2=press_trace_2(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

xGlobalBestSize=size(press_trace_3(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
press_trace_3_xBest1=press_trace_3(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
press_trace_3_xBest2=press_trace_3(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

xGlobalBestSize=size(nopress_trace_1(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
nopress_trace_1_xBest1=nopress_trace_1(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
nopress_trace_1_xBest2=nopress_trace_1(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

xGlobalBestSize=size(nopress_trace_2(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
nopress_trace_2_xBest1=nopress_trace_2(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
nopress_trace_2_xBest2=nopress_trace_2(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

xGlobalBestSize=size(nopress_trace_3(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);
nopress_trace_3_xBest1=nopress_trace_3(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
nopress_trace_3_xBest2=nopress_trace_3(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);

figure(1);
surf(double(reverseY(PSO_FFTtoPic(press_trace_1_xBest1))));
% title('press-trace-1-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(2);
surf(double(reverseY(PSO_FFTtoPic(press_trace_1_xBest2))));
% title('press-trace-1-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(3);
surf(double(reverseY(PSO_FFTtoPic(press_trace_2_xBest1))));
% title('press-trace-2-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(4);
surf(double(reverseY(PSO_FFTtoPic(press_trace_2_xBest2))));
% title('press-trace-2-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(5);
surf(double(reverseY(PSO_FFTtoPic(press_trace_3_xBest1))));
% title('press-trace-3-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(6);
surf(double(reverseY(PSO_FFTtoPic(press_trace_3_xBest2))));
% title('press-trace-3-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(7);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_1_xBest1))));
% title('nopress-trace-1-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(8);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_1_xBest2))));
% title('nopress-trace-1-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(9);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_2_xBest1))));
% title('nopress-trace-2-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(10);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_2_xBest2))));
% title('nopress-trace-2-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(11);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_3_xBest1))));
% title('nopress-trace-3-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(12);
surf(double(reverseY(PSO_FFTtoPic(nopress_trace_3_xBest2))));
% title('nopress-trace-3-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

figure(13);
surf(double(reverseY(thero_pic1)));
% title('nopress-trace-3-xBest1');
colormap jet;
caxis([0,255]);
colorbar;
figure(14);
surf(double(reverseY(thero_pic2)));
% title('nopress-trace-3-xBest2');
colormap jet;
caxis([0,255]);
colorbar;

% load('trace.mat')
% xGlobalBestSize=size(trace(1,1).xGlobalBest);
% xGlobalBestSizeY=xGlobalBestSize(1,2);
% 
% xBest1=trace(1,1).xGlobalBest(1,1:(xGlobalBestSizeY/2));
% xBest2=trace(1,1).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
% figure(2);
% surf(double(reverseY(PSO_FFTtoPic(xBest1))));
% colormap jet;
% caxis([0,255]);
% colorbar;
% figure(3);
% surf(double(reverseY(PSO_FFTtoPic(xBest2))));
% colormap jet;
% caxis([0,255]);
% colorbar;
% 
% 
% 
% 
% 
% 
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







