% �Ŵ��㷨������Դ���ݣ�δ֪ƽ���ٶ�
clc
clear all
close all
if matlabpool('size')<=0
    matlabpool;
    matlabpool('size')
end

%% ��������ͼ
c_tupian='diceng_5_5.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=5;
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
parfor q=1:1:((c_RealXLength/c_zy_inter)+1)*((c_RealXLength/c_jbq_inter)+1)
    tic;
    TheoArrTime(5,q)=RayTrace(c_tupian,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime2(1,q),TheoArrTime2(2,q),TheoArrTime2(3,q),TheoArrTime2(4,q));
    toc;
end
clear TheoArrTime2;
%toc;
%��Ѱ�ű�������
NofVar=sizemyjpg(1,1)*sizemyjpg(1,2);
%��Ѱ�ű�������
LofVar=0;
%��Ѱ�ű�������
UofVar=255;

%% �����Ŵ��㷨����
NIND=100;        %������Ŀ
MAXGEN=100;      %����Ŵ�����
PRECI=8;       %�����Ķ�����λ��������
GGAP=0.9;      %������ÿ��ѡ�����Ÿ�����м���ĸ���=NIND*GGAP�������¸������ʱ��reins���ĸ�����Ϊ1����ʾ������Ӧ�Ƚ��в��룬���滻��ԭʼ��Ⱥ����Ӧ����͵ģ�������Ӧ����߸�����ĿΪNIND-NIND*GGAP
px=0.7;         %�������
pm=0.1;        %�������
trace=zeros(NofVar+2,MAXGEN);                        %Ѱ�Ž���ĳ�ʼֵ��ǰNofVar�ж�Ӧ���Ž�������һ�ж�ӦĿ�꺯��ֵ
% FieldD=[PRECI PRECI;lbx lby;ubx uby;1 1;0 0;1 1;1 1];                      %������������������1:�Ӵ����ȣ�2���½磻3���Ͻ磻4�����룬0Ϊ�����ƣ�1Ϊ�����룻5�������������̶ȣ�0Ϊ�����̶ȣ�6���½��Ƿ�����߽磻7���Ͻ��Ƿ�����߽�
% Chrom=crtbp(NIND,PRECI*2);                      %��ʼ��Ⱥ���˴�2�������������Ӧ�� ���������� �ṹһ�£�������
FieldD=zeros(7,NofVar);
FieldD(1,:)=PRECI;
FieldD(2,:)=LofVar;
FieldD(3,:)=UofVar;
FieldD(4,:)=0;
FieldD(5,:)=0;
FieldD(6,:)=1;
FieldD(7,:)=1;
Chrom=crtbp(NIND,PRECI*NofVar);
%% �Ż�
gen=0;                                  %��������
XY=bs2rv(Chrom,FieldD);                 %�����ʼ��Ⱥ��ʮ����ת����������Ӧ������Ŀ��������Ӧ��������
% X=XY(:,1);Y=XY(:,2);%�Ѿ���XY�ĵ�1�з�X������XY�ĵ�2�з�Y���˴�ȡ���Ĳ���Ӧ���������һ�£�������
% ObjV=Y.*sin(2*pi*X)+X.*cos(2*pi*Y);        %����Ŀ�꺯��ֵ
%����Ŀ�꺯��ֵ��2016.10.10�޸�Ŀ�꺯������
tic;
ObjV=GA_hanshuzhi(sizemyjpg(1,1),sizemyjpg(1,2),c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,XY,TheoArrTime);%������������������������������������
toc;
%�ֹ�������Ÿ���
[jy_maxobjv jy_maxindex]=max(ObjV);%�ҵ������壬׼���滻
goodjpg=myjpg;
goodjpg(5,2)=50;
goodjpg(5,3)=50;
jy_inpic=goodjpg;%ֱ�Ӳ�����ʵ�⣬������һ���жϣ����޸�
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
%�ֹ�������Ÿ���


tic;
while gen<MAXGEN
    
   FitnV=ranking(ObjV);                              %������Ӧ��ֵ
   SelCh=select('sus',Chrom,FitnV,GGAP);              %ѡ��
   SelCh=recombin('xovmp',SelCh,px);                  %����
   SelCh=mut(SelCh,pm);                               %����
   XY=bs2rv(SelCh,FieldD);               %�Ӵ������ʮ����ת������������
%    X=XY(:,1);Y=XY(:,2);                 %������������
%    ObjVSel=GA_hanshuzhi(x1,y1,x2,y2,x3,y3,x4,y4,X,Y,t12,t23,t34);            %�����Ӵ���Ŀ�꺯��ֵ������������
   ObjVSel=GA_hanshuzhi(sizemyjpg(1,1),sizemyjpg(1,2),c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,XY,TheoArrTime);
   [Chrom,ObjV]=reins(Chrom,SelCh,1,[1 1],ObjV,ObjVSel); %�ز����Ӵ����������õ�����Ⱥ
   XY=bs2rv(Chrom,FieldD);                      %��������������
   gen=gen+1                                             %������������
   %��ȡÿ�������Ž⼰����ţ�YΪ���Ž�,IΪ��������
   [Y,I]=min(ObjV);%Y��Ϊÿ����Сֵ��IΪ���ֵ��Ӧ���кţ���������
   trace(1:NofVar,gen)=XY(I,:)';                       %����ÿ��������ֵ����������
   trace(NofVar+1,gen)=Y;                               %����ÿ��������ֵ��Ŀ��ֵ��ʵ��ֵ֮���ͨ��x���������yֵ��ʵ�ʵ�yֵ֮�����������Ӧ����Խ��ԽС����������
   trace(NofVar+2,gen)=mean(ObjV);
   %����ÿ�����Ž��ͼ��
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
%����ÿ�������ŵ�
% plot(trace(1,:),trace(2,:),'o');
% plot(trace(1,end),trace(2,end),'m*');%���Ž�λ��
% hold off
% ������ͼ
% figure(1);
% plot(trace(1,:),trace(2,:),'o');
% plot(trace(1,end),trace(2,end),'m*');%���Ž�λ��
% grid on
% xlabel('x')
% ylabel('y')
% title('��������')
% figure(2);
% plot(1:MAXGEN,trace(3,:));
% grid on
% xlabel('�Ŵ�����')
% ylabel('Ŀ�꺯��ֵ')
% title('��������')
% bestX=trace(1,end);
% bestY=trace(2,end);
% %����ƽ���ٶ�
% v=abs(sqrt((x1-bestX)*(x1-bestX)+(y1-bestY)*(y1-bestY))-sqrt((x2-bestX)*(x2-bestX)+(y2-bestY)*(y2-bestY)))*1000/t12;
% %�������Ž⾭���Ĵ���
% daishuX=min(find(floor(trace(1,:)*10)/10==floor(bestX*10)/10));
% daishuY=min(find(floor(trace(2,:)*10)/10==floor(bestY*10)/10));
% fprintf(['���Ž�:\nX=',num2str(bestX),'\nY=',num2str(bestY),'\nV=',num2str(v),'\nbestx=',num2str(daishuX),'\nbesty=',num2str(daishuY),'\n']);

