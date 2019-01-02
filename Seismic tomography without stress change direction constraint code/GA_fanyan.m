% 遗传算法进行震源反演，未知平均速度
clc
clear all
close all
if matlabpool('size')<=0
    matlabpool;
    matlabpool('size')
end

%% 画出函数图
c_tupian='diceng_5_5.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=5;
c_StartY=0;
c_EndY=50;
c_zy_inter=40;%震源坐标间隔，使用实际距离
c_jbq_inter=20;%检波器坐标间隔
myjpg=imread(c_tupian);
figure(1);
image(myjpg);figure(gcf);
sizemyjpg=size(myjpg);
%生成到时的理论值
TheoArrTime=zeros(5,((c_RealXLength/c_zy_inter)+1)*((c_RealXLength/c_jbq_inter)+1));
q=1;
%tic;
for i=0:c_zy_inter:c_RealXLength%震源横坐标
    for j=0:c_jbq_inter:c_RealXLength%检波器横坐标
        TheoArrTime(1,q)=i;
        TheoArrTime(2,q)=c_StartY;
        TheoArrTime(3,q)=j;
        TheoArrTime(4,q)=c_EndY;
%         tic;
%         TheoArrTime(5,q)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,q),TheoArrTime(2,q),TheoArrTime(3,q),TheoArrTime(4,q));
%         toc;
        q=q+1;
    end
end
TheoArrTime2=TheoArrTime;
parfor q=1:1:((c_RealXLength/c_zy_inter)+1)*((c_RealXLength/c_jbq_inter)+1)
    tic;
    TheoArrTime(5,q)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime2(1,q),TheoArrTime2(2,q),TheoArrTime2(3,q),TheoArrTime2(4,q));
    toc;
end
clear TheoArrTime2;
%toc;
%待寻优变量个数
NofVar=sizemyjpg(1,1)*sizemyjpg(1,2);
%待寻优变量下限
LofVar=0;
%待寻优变量上限
UofVar=255;

%% 定义遗传算法参数
NIND=100;        %个体数目
MAXGEN=100;      %最大遗传代数
PRECI=8;       %变量的二进制位数！！！
GGAP=0.9;      %代沟，每次选出最优个体进行计算的个数=NIND*GGAP，进行新个体插入时，reins第四个参数为1，表示按照适应度进行插入，即替换掉原始种群中适应度最低的，保留适应度最高个体数目为NIND-NIND*GGAP
px=0.7;         %交叉概率
pm=0.1;        %变异概率
trace=zeros(NofVar+2,MAXGEN);                        %寻优结果的初始值，前NofVar行对应最优结果，最后一行对应目标函数值
% FieldD=[PRECI PRECI;lbx lby;ubx uby;1 1;0 0;1 1;1 1];                      %区域描述器！！！！1:子串长度；2：下界；3：上界；4：编码，0为二进制，1为格雷码；5：对数或算数刻度，0为算数刻度；6：下届是否包含边界；7：上届是否包含边界
% Chrom=crtbp(NIND,PRECI*2);                      %初始种群，此处2代表变量个数，应与 区域描述器 结构一致！！！！
FieldD=zeros(7,NofVar);
FieldD(1,:)=PRECI;
FieldD(2,:)=LofVar;
FieldD(3,:)=UofVar;
FieldD(4,:)=0;
FieldD(5,:)=0;
FieldD(6,:)=1;
FieldD(7,:)=1;
Chrom=crtbp(NIND,PRECI*NofVar);
%% 优化
gen=0;                                  %代计数器
XY=bs2rv(Chrom,FieldD);                 %计算初始种群的十进制转换，行数对应个体数目，列数对应变量个数
% X=XY(:,1);Y=XY(:,2);%把矩阵XY的第1列放X，矩阵XY的第2列放Y，此处取出的参数应与变量个数一致！！！！
% ObjV=Y.*sin(2*pi*X)+X.*cos(2*pi*Y);        %计算目标函数值
%计算目标函数值，2016.10.10修改目标函数计算
tic;
ObjV=GA_hanshuzhi(sizemyjpg(1,1),sizemyjpg(1,2),c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,XY,TheoArrTime);%！！！！！！！！！！！！！！！！！！
toc;
%手工插入较优个体
[jy_maxobjv jy_maxindex]=max(ObjV);%找到最差个体，准备替换
goodjpg=myjpg;
goodjpg(5,2)=50;
goodjpg(5,3)=50;
jy_inpic=goodjpg;%直接插入真实解，可在下一行中断，以修改
jy_inpic=double(jy_inpic);
jy_inpicsize=size(jy_inpic);
jy_indata=zeros(1,jy_inpicsize(1,1)*jy_inpicsize(1,2));
jy_k=1;
for jy_i=1:1:jy_inpicsize(1,1)
    for jy_j=1:1:jy_inpicsize(1,2)
        jy_indata(1,jy_k)=jy_inpic(jy_i,jy_j);
        jy_k=jy_k+1;
    end
end
jy_indatabin=d2b(jy_indata);
Chrom(jy_maxindex,:)=jy_indatabin;
XY=bs2rv(Chrom,FieldD);
ObjV=GA_hanshuzhi(sizemyjpg(1,1),sizemyjpg(1,2),c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,XY,TheoArrTime);
%手工插入较优个体


tic;
while gen<MAXGEN
    
   FitnV=ranking(ObjV);                              %分配适应度值
   SelCh=select('sus',Chrom,FitnV,GGAP);              %选择
   SelCh=recombin('xovmp',SelCh,px);                  %重组
   SelCh=mut(SelCh,pm);                               %变异
   XY=bs2rv(SelCh,FieldD);               %子代个体的十进制转换！！！！！
%    X=XY(:,1);Y=XY(:,2);                 %！！！！！！
%    ObjVSel=GA_hanshuzhi(x1,y1,x2,y2,x3,y3,x4,y4,X,Y,t12,t23,t34);            %计算子代的目标函数值！！！！！！
   ObjVSel=GA_hanshuzhi(sizemyjpg(1,1),sizemyjpg(1,2),c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,XY,TheoArrTime);
   [Chrom,ObjV]=reins(Chrom,SelCh,1,[1 1],ObjV,ObjVSel); %重插入子代到父代，得到新种群
   XY=bs2rv(Chrom,FieldD);                      %！！！！！！！
   gen=gen+1                                             %代计数器增加
   %获取每代的最优解及其序号，Y为最优解,I为个体的序号
   [Y,I]=min(ObjV);%Y中为每列最小值，I为最大值对应的行号！！！！！
   trace(1:NofVar,gen)=XY(I,:)';                       %记下每代的最优值！！！！！
   trace(NofVar+1,gen)=Y;                               %记下每代的最优值的目标值与实际值之差，即通过x计算出来的y值和实际的y值之间的误差，这个误差应该是越来越小！！！！！
   trace(NofVar+2,gen)=mean(ObjV);
   %画出每代最优解的图像
   test_pic=zeros(sizemyjpg(1,1),sizemyjpg(1,2));
   k=1;
   for m=1:1:sizemyjpg(1,1)
      for n=1:1:sizemyjpg(1,2)
          test_pic(m,n)=XY(I,k);
          k=k+1;
      end
   end
   test_pic=uint8(test_pic);
   figure(2);
   clf;
   image(test_pic);figure(gcf); 
   figure(3);
   clf;
   plot(trace(NofVar+1,1:100),'DisplayName','trace(26,1:100)','YDataSource','trace(26,1:100)');figure(gcf)
   figure(4);
   clf;
   plot(trace(NofVar+2,1:100),'DisplayName','trace(26,1:100)','YDataSource','trace(26,1:100)');figure(gcf)
   
end
toc;
%画出每代的最优点
% plot(trace(1,:),trace(2,:),'o');
% plot(trace(1,end),trace(2,end),'m*');%最优解位置
% hold off
% 画进化图
% figure(1);
% plot(trace(1,:),trace(2,:),'o');
% plot(trace(1,end),trace(2,end),'m*');%最优解位置
% grid on
% xlabel('x')
% ylabel('y')
% title('进化过程')
% figure(2);
% plot(1:MAXGEN,trace(3,:));
% grid on
% xlabel('遗传代数')
% ylabel('目标函数值')
% title('进化过程')
% bestX=trace(1,end);
% bestY=trace(2,end);
% %计算平均速度
% v=abs(sqrt((x1-bestX)*(x1-bestX)+(y1-bestY)*(y1-bestY))-sqrt((x2-bestX)*(x2-bestX)+(y2-bestY)*(y2-bestY)))*1000/t12;
% %到达最优解经过的代数
% daishuX=min(find(floor(trace(1,:)*10)/10==floor(bestX*10)/10));
% daishuY=min(find(floor(trace(2,:)*10)/10==floor(bestY*10)/10));
% fprintf(['最优解:\nX=',num2str(bestX),'\nY=',num2str(bestY),'\nV=',num2str(v),'\nbestx=',num2str(daishuX),'\nbesty=',num2str(daishuY),'\n']);

