%测试开方运算的速度
clc;
clear all;
close all;
tic;
for i=1:1:100000000
    temp=sqrt(255);
end
toc
tic;
for i=1:1:100000000
    temp=255+1;
end
toc