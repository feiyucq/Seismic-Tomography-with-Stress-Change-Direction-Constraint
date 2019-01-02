%cqpso ��������ͼƬ����������ͼƬ���Լ��
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
c_zy_inter=20;%��Դ��������ʹ��ʵ�ʾ���
c_jbq_inter=10;%�첨��������
myjpg=imread(c_tupian);
% figure(2);
% image(myjpg);figure(gcf);
sizemyjpg=size(myjpg);


%����fftҪ�����ñ���������������
%��Ѱ�ű�������
% NofVar=sizemyjpg(1,1)*sizemyjpg(1,2);
%����ʱ�����ڼ����������������5����������˵���е�1
NofVar=5*2;%����5�����꣬ÿ������2�������ֱ�Ϊģ�ͷ���
%��Ѱ�ű�������
% LofVar=0;
%��Ѱ�ű�������
% UofVar=255;
temp=zeros(2,NofVar);
for i=1:1:NofVar
%     temp(1,i)=LofVar;
%     temp(2,i)=UofVar;
    if (i/2-floor(i/2))==0%���Ա�2��������Ӧ���Ƿ�Χ
        temp(1,i)=-180;
        temp(2,i)=180;
    else%���ܱ�2��������Ӧģ��Χ
        temp(1,i)=1000;
        temp(2,i)=20000;
    end
end
%�涨fftmatrix�в�������˳���ӦΪ[x1.mod x1.ang x2.mod x2.ang x3.mod x3.ang x4.mod x4.ang x5.mod x5.ang]
%[(25,25) (25,26) (26,25) (26,26) (25,27)]�����x4�ķ��Ƿ�ΧӦΪ0�˴�Ӧ����ͼƬ�ߴ��޸�
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


f.options.PopInitRange =[temp temp];%��ʼ������Ѱ�ŷ�Χ


%f.options.PopInitRange = [-14, -14,-14;14, 14, 14] ;%��ʼ������ı�����Χ������һ��Ϊ2�����������������ͬ
%f.options.PlotFcns ={@psoplotbestf,@psoplotswarmsurf};%������ά��Ҫ����Ⱥ��ͼ
f.options.PlotFcns ={@psoplotbestf};
f.options.HybridFcn = {} ;
f.options.Generations = 100 ;%��������
f.options.UseParallel='always';%��ѡ always or never���������м��㣬��Ҫ��Ӧ�޸Ĺ������е�PSO.m�ļ�

%f.options.KnownMin = [0,0,0] ;%��֪����С�㣬��ͼ�ã�0��Ӧx���꣬1��Ӧy����
f.options.PopulationSize=32;%PSO������
%f.LB = [-1,-2,-3] ;%�����������죬��һ����x���ڶ�����y
%f.UB = [1,2,3] ;%����������ҽ磬��һ����x���ڶ�����y


f.nvars=NofVar*2;%��������


temp=zeros(1,NofVar);
for i=1:1:NofVar
    if (i/2-floor(i/2))==0%���Ա�2��������Ӧ���Ƿ�Χ����
        temp(i)=-180;
    else%���ܱ�2��������Ӧģ��Χ����
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
    if (i/2-floor(i/2))==0%���Ա�2��������Ӧ���Ƿ�Χ����
        temp(i)=180;
    else%���ܱ�2��������Ӧģ��Χ����
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


 f.fitnessfcn=str2func('PSO_hanshuzhi');%���Ż�����
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

