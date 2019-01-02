%cqpso 反演两幅图片，增加两幅图片间的约束
clc;
clear all;
close all;
%add toolbox
addpath([pwd '/sdnchen-psomatlab-b4c4a1e']);
addpath([pwd '/sdnchen-psomatlab-b4c4a1e/private']);
addpath([pwd '/sdnchen-psomatlab-b4c4a1e/testfcns']);
%MakeTheoArrTime;%break here first time
%****************************************************************************************************
c_tupian='diceng_50_50.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
%c_NofPoints=5;
c_StartY=0;
c_EndY=50;
c_zy_inter=20;%震源坐标间隔，使用实际距离
c_jbq_inter=10;%检波器坐标间隔
myjpg=imread(c_tupian);
% figure(2);
% image(myjpg);figure(gcf);
sizemyjpg=size(myjpg);


%根据fft要求重置变量个数及上下限
%待寻优变量个数
% NofVar=sizemyjpg(1,1)*sizemyjpg(1,2);
%单机时受限于计算机条件，仅反演5个参数，即说明中的1
NofVar=5*2;%反演5个坐标，每个坐标2参数，分别为模和幅角
%待寻优变量下限
% LofVar=0;
%待寻优变量上限
% UofVar=255;
temp=zeros(2,NofVar);
for i=1:1:NofVar
%     temp(1,i)=LofVar;
%     temp(2,i)=UofVar;
    if (i/2-floor(i/2))==0%可以被2整除，对应幅角范围
        temp(1,i)=-180;
        temp(2,i)=180;
    else%不能被2整除，对应模范围
        temp(1,i)=1000;
        temp(2,i)=20000;
    end
end
%规定fftmatrix中参数排列顺序对应为[x1.mod x1.ang x2.mod x2.ang x3.mod x3.ang x4.mod x4.ang x5.mod x5.ang]
%[(25,25) (25,26) (26,25) (26,26) (25,27)]，因此x4的幅角范围应为0此处应根据图片尺寸修改
temp(1,8)=0;
temp(2,8)=0;
temp(1,1)=0;
temp(2,1)=100000;
temp(1,3)=0;
temp(2,3)=100000;
temp(1,5)=0;
temp(2,5)=100000;
temp(1,7)=150000;
temp(2,7)=300000;
temp(1,9)=0;
temp(2,9)=100000;


f.options.PopInitRange =[temp temp];%初始化个体寻优范围


%f.options.PopInitRange = [-14, -14,-14;14, 14, 14] ;%初始化个体的变量范围，行数一定为2，列数与变量个数相同
%f.options.PlotFcns ={@psoplotbestf,@psoplotswarmsurf};%超过二维不要绘制群的图
f.options.PlotFcns ={@psoplotbestf};
f.options.HybridFcn = {} ;
f.options.Generations = 100 ;%迭代次数
f.options.UseParallel='always';%可选 always or never以启动并行计算，需要相应修改工具箱中的PSO.m文件

%f.options.KnownMin = [0,0,0] ;%已知的最小点，绘图用，0对应x坐标，1对应y坐标
f.options.PopulationSize=32;%PSO粒子数
%f.LB = [-1,-2,-3] ;%输入参数的左届，第一个是x，第二个是y
%f.UB = [1,2,3] ;%输入参数的右界，第一个是x，第二个是y


f.nvars=NofVar*2;%变量个数


temp=zeros(1,NofVar);
for i=1:1:NofVar
    if (i/2-floor(i/2))==0%可以被2整除，对应幅角范围下限
        temp(i)=-180;
    else%不能被2整除，对应模范围下限
        temp(i)=1000;
    end
end
temp(8)=0;
temp(1)=0;
temp(3)=0;
temp(5)=0;
temp(7)=150000;
temp(9)=0;


f.LB =[temp temp];


temp=zeros(1,NofVar);
for i=1:1:NofVar
    if (i/2-floor(i/2))==0%可以被2整除，对应幅角范围上限
        temp(i)=180;
    else%不能被2整除，对应模范围上限
        temp(i)=20000;
    end
end
temp(8)=0;
temp(1)=100000;
temp(3)=100000;
temp(5)=100000;
temp(7)=300000;
temp(9)=100000;


f.UB =[temp temp];


 f.fitnessfcn=str2func('PSO_hanshuzhi');%待优化函数
%f.fitnessfcn=str2func('cqfunc');
%f.options.DemoMode = 'pretty' ;
f.Aeq = [] ; 
f.beq = [] ;
f.Aineq = [] ; 
f.bineq = [] ;
f.nonlcon = [] ;
f.options.Vectorized='off';
%******************************************************************************************************************
psostarttime=clock
[xOpt,fval,exitflag,output,population,scores]=pso(f);
psostoptime=clock
resultpic=PSO_FFTtoPic(xOpt);
figure(3);
image(resultpic);

