%计算应力约束与不含应力约束的结果与理论结果对比
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
load('PSO_hanshuzhi_理论值.mat');
fGlobalBest_cut_thero=theoryResult;



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

vector_nopress_1=[double(reverseY(PSO_FFTtoPic(nopress_trace_1_xBest1))) double(reverseY(PSO_FFTtoPic(nopress_trace_1_xBest2)))];
vector_nopress_1=vector_nopress_1(:);
vector_nopress_2=[double(reverseY(PSO_FFTtoPic(nopress_trace_2_xBest1))) double(reverseY(PSO_FFTtoPic(nopress_trace_2_xBest2)))];
vector_nopress_2=vector_nopress_2(:);
vector_nopress_3=[double(reverseY(PSO_FFTtoPic(nopress_trace_3_xBest1))) double(reverseY(PSO_FFTtoPic(nopress_trace_3_xBest2)))];
vector_nopress_3=vector_nopress_3(:);

vector_press_1=[double(reverseY(PSO_FFTtoPic(press_trace_1_xBest1))) double(reverseY(PSO_FFTtoPic(press_trace_1_xBest2)))];
vector_press_1=vector_press_1(:);
vector_press_2=[double(reverseY(PSO_FFTtoPic(press_trace_2_xBest1))) double(reverseY(PSO_FFTtoPic(press_trace_2_xBest2)))];
vector_press_2=vector_press_2(:);
vector_press_3=[double(reverseY(PSO_FFTtoPic(press_trace_3_xBest1))) double(reverseY(PSO_FFTtoPic(press_trace_3_xBest2)))];
vector_press_3=vector_press_3(:);

vector_cut_thero_pic=[reverseY(thero_pic1) reverseY(thero_pic2)];
vector_cut_thero_pic=double(vector_cut_thero_pic(:));

thero_pic1=imread('diceng_50_50.bmp');
thero_pic2=imread('diceng_50_50_2.bmp');
vector_thero_pic=[double(reverseY(thero_pic1)) double(reverseY(thero_pic2))];
vector_thero_pic=vector_thero_pic(:);

norm_cutthero_thero=norm((vector_cut_thero_pic-vector_thero_pic),2);

norm_nopress1_cutthero=norm((vector_cut_thero_pic-vector_nopress_1),2);
norm_nopress2_cutthero=norm((vector_cut_thero_pic-vector_nopress_2),2);
norm_nopress3_cutthero=norm((vector_cut_thero_pic-vector_nopress_3),2);

norm_mean_nopress_cutthero=(norm_nopress1_cutthero+norm_nopress2_cutthero+norm_nopress3_cutthero)/3;

norm_press1_cutthero=norm((vector_cut_thero_pic-vector_press_1),2);
norm_press2_cutthero=norm((vector_cut_thero_pic-vector_press_2),2);
norm_press3_cutthero=norm((vector_cut_thero_pic-vector_press_3),2);

norm_mean_press_cutthero=(norm_press1_cutthero+norm_press2_cutthero+norm_press3_cutthero)/3;

norm_nopress1_thero=norm((vector_thero_pic-vector_nopress_1),2);
norm_nopress2_thero=norm((vector_thero_pic-vector_nopress_2),2);
norm_nopress3_thero=norm((vector_thero_pic-vector_nopress_3),2);

norm_mean_nopress_thero=(norm_nopress1_thero+norm_nopress2_thero+norm_nopress3_thero)/3;

norm_press1_thero=norm((vector_thero_pic-vector_press_1),2);
norm_press2_thero=norm((vector_thero_pic-vector_press_2),2);
norm_press3_thero=norm((vector_thero_pic-vector_press_3),2);

norm_mean_press_thero=(norm_press1_thero+norm_press2_thero+norm_press3_thero)/3;

fGlobalBest_press1=press_trace_1(1,30).fGlobalBest(30,1);
fGlobalBest_press2=press_trace_2(1,30).fGlobalBest(30,1);
fGlobalBest_press3=press_trace_3(1,30).fGlobalBest(30,1);

fGlobalBest_mean_press=(fGlobalBest_press1+fGlobalBest_press2+fGlobalBest_press3)/3;

fGlobalBest_nopress1=nopress_trace_1(1,30).fGlobalBest(30,1);
fGlobalBest_nopress2=nopress_trace_2(1,30).fGlobalBest(30,1);
fGlobalBest_nopress3=nopress_trace_3(1,30).fGlobalBest(30,1);

fGlobalBest_mean_nopress=(fGlobalBest_nopress1+fGlobalBest_nopress2+fGlobalBest_nopress3)/3;

%反演结果与原始图像、滤波后图像间对比
ans_my=[norm_cutthero_thero 0 0 0;norm_press1_thero norm_press2_thero norm_press3_thero norm_mean_press_thero;norm_press1_cutthero norm_press2_cutthero norm_press3_cutthero norm_mean_press_cutthero;norm_nopress1_thero norm_nopress2_thero norm_nopress3_thero norm_mean_nopress_thero;norm_nopress1_cutthero norm_nopress2_cutthero norm_nopress3_cutthero norm_mean_nopress_cutthero];
%计算方差
var_vector_nopress_thero=[norm_nopress1_thero norm_nopress2_thero norm_nopress3_thero ];
var_nopress_thero=var(var_vector_nopress_thero);
var_vector_press_thero=[norm_press1_thero norm_press2_thero norm_press3_thero];
var_press_thero=var(var_vector_press_thero);
var_vector_nopress_cutthero=[norm_nopress1_cutthero norm_nopress2_cutthero norm_nopress3_cutthero];
var_nopress_cutthero=var(var_vector_nopress_cutthero);
var_vector_press_cutthero=[norm_press1_cutthero norm_press2_cutthero norm_press3_cutthero];
var_press_cutthero=var(var_vector_press_cutthero);




figure(1);
bar(ans_my);

