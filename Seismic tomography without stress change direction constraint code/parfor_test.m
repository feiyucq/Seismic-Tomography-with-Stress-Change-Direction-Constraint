clc
clear all
close all
tic;
a=0;
for i=1:1:10
a=toc+a;
end



for i=1:1024000
  A(i) = sin(i*2*pi/1024);
end
plot(A)

toc;
if matlabpool('size')<=0
    matlabpool('open','local',2);
    matlabpool('size')
end
tic;
parfor i=1:1024000
  A(i) = sin(i*2*pi/1024);
end
plot(A)
toc;