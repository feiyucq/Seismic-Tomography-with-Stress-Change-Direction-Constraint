%test raytrace
clc;
clear all;
close all;
c_tupian='diceng3_10_20.bmp';
c_StartV=3000;
c_EndV=6000;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=4;
c_StartX=0;%Êµ¼Ê×ø±ê
c_StartY=0;
c_EndX=200;
c_EndY=50;
tic;
besttime=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY);%c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY
toc;