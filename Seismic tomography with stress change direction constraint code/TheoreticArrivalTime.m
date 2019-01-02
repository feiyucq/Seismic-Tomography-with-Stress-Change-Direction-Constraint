clc;
clear all;
close all;
c_tupian='diceng3_10_20.bmp';
c_StartV=3000;
c_EndV=6000;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=4;
% c_StartX=0;%实际坐标
c_StartY=0;
% c_EndX=200;
c_EndY=50;
% c_StartX=100;
% c_StartY=0;
TheoArrTime=zeros(5,231);
q=1
for i=0:20:200%震源横坐标
%     TheoArrTime(1,j)=i;
%     TheoArrTime(2,j)=50;
%     tic;
%     TheoArrTime(3,j)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,TheoArrTime(1,j),TheoArrTime(2,j));
%     toc;
%     j=j+1;
    for j=0:10:200%检波器横坐标
        TheoArrTime(1,q)=i;
        TheoArrTime(2,q)=c_StartY;
        TheoArrTime(3,q)=j;
        TheoArrTime(4,q)=c_EndY;
        tic;
        TheoArrTime(5,q)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,q),TheoArrTime(2,q),TheoArrTime(3,q),TheoArrTime(4,q));
        toc;
        q=q+1
    end
end