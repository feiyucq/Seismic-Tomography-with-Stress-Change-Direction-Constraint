%ͼ����ʱ����ת90�Ⱥ��������۵�ʱ����������PSOִ��
%��ͬ�ķֱ��ʼ���������۵�ʱ�ǳ��ӽ�����ѡ��diceng_20_20����������۵�ʱ
clc;
clear all;
close all;
c_tupian='diceng_50_50_counterclockwise_90.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=2;
c_StartY=0;
c_EndY=50;
c_zy_inter=40;%��Դ��������ʹ��ʵ�ʾ���
c_jbq_inter=20;%�첨��������
myjpg=imread(c_tupian);
figure(1);
image(myjpg);figure(gcf);
sizemyjpg=size(myjpg);
%���ɵ�ʱ������ֵ
TheoArrTime=zeros(5,((c_RealXLength/c_zy_inter)+1)*((c_RealXLength/c_jbq_inter)+1));
q=1;
%tic;
for i=0:c_zy_inter:c_RealXLength%��Դ������
    for j=0:c_jbq_inter:c_RealXLength%�첨��������
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
if isempty(gcp('nocreate'))
    parpool;
end
parfor q=1:1:((c_RealXLength/c_zy_inter)+1)*((c_RealXLength/c_jbq_inter)+1)
    tic;
    TheoArrTime(5,q)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime2(1,q),TheoArrTime2(2,q),TheoArrTime2(3,q),TheoArrTime2(4,q));
    toc;
end
clear TheoArrTime2;
save TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat TheoArrTime;
% clc;
% clear all;
% close all;