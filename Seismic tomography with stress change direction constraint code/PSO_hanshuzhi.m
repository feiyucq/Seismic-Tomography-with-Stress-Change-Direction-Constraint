function myans=PSO_hanshuzhi(x)
%�������ͼƬ֮���Ƿ�����Ѳ�õĴ�С��ϵ
bigOrSmall=checkPic(x);
%�����Ϊ����ͼƬ�����ģ�ͣ���Ҫ���м�ֿ�����Ϊ����������ģ��
sizeOfX=size(x);
if sizeOfX(1,1)~=1
    error('sizeOfX(1,1)~=1');
end
x1=x(1,1:(sizeOfX(1,2)/2));%��õ�һ��ͼƬ��Ϣ
x2=x(1,(sizeOfX(1,2)/2+1):sizeOfX(1,2));%��õڶ���ͼƬ��Ϣ

%�Ե�һ��ͼƬ��������׷�٣���õ�ʱ��Ϣ
x=x1;
%�������xת��Ϊͼ��
x=PSO_FFTtoPic(x);
pic1=x;
%�������xת��Ϊͼ��
%�����xΪ������һ�����壬Ӧȡ��
%x=round(x);%ȡ��
c_tupian='diceng_50_50.bmp';
c_StartV=300;
c_EndV=600;
c_RealXLength=2000;
c_RealYLength=500;
c_NofPoints=2;%50*50ͼ��ʱ��Ϊ2
%TheoArrTime=0;%!!!!!!must be changed correct
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);
c_pic_hang=sizemyjpg(1,1);
c_pic_lie=sizemyjpg(1,2);
c_Map=x;%PSO�����ֵ�ж�Ӧ������c_Map���ж�Ӧ���������һ��ͼ��
%c_Map=uint8(c_Map);
%�鿴���۵�ʱ�Ƿ���ڣ������ڱ����������ȡ
if exist('TheoArrTime_50_50.mat','file')==0%������
    error('no TheoArrTime.mat');
end
hofT=load('TheoArrTime_50_50.mat');
TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
TheoArrTime_size=size(TheoArrTime);
%���ݼ첨������Դ��ϴ�����������׷��
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            
            %sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('��һ��ͼƬ��һ������׷����ʱ��')
% toc
result=RealArrTime;
theo=TheoArrTime;
%ͼƬ��ʱ����ת90���Ժ��ٴν�������׷�٣�ģ����Դ�ͼ첨����ֱ����ʱ������
c_Map=rotatepic_counterclockwise_90(x);
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat','file')==0%������
    error('no TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
TheoArrTime_size=size(TheoArrTime);
%���ݼ첨������Դ��ϴ�����������׷��
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            
            %sprintf('raytrace rotate counterclockwise 90 num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('��һ��ͼƬ�ڶ�������׷����ʱ��')
% toc
result_r=RealArrTime;
theo_r=TheoArrTime;
finalRealArrTime=[result result_r];%��õ�һ��ͼƬ��ʵ�ʵ�ʱ
finalTheoArrTime=[theo theo_r];%��õ�һ��ͼƬ�Ĳ�����ʱ
%�Ե�һ��ͼƬ��������׷�٣���õ�ʱ��Ϣ


%�Եڶ���ͼƬ��������׷�٣���õ�ʱ��Ϣ
x=x2;
%�������xת��Ϊͼ��
x=PSO_FFTtoPic(x);
pic2=x;
%�������xת��Ϊͼ��
tic;
%�����xΪ������һ�����壬Ӧȡ��
%x=round(x);%ȡ��
c_tupian='diceng_50_50.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=2;%50*50ͼ��ʱ��Ϊ2
%TheoArrTime=0;%!!!!!!must be changed correct
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);
c_pic_hang=sizemyjpg(1,1);
c_pic_lie=sizemyjpg(1,2);
c_Map=x;%PSO�����ֵ�ж�Ӧ������c_Map���ж�Ӧ���������һ��ͼ��
%c_Map=uint8(c_Map);
%�鿴���۵�ʱ�Ƿ���ڣ������ڱ����������ȡ
if exist('TheoArrTime_50_50_2.mat','file')==0%������
    error('no TheoArrTime_2.mat');
end
hofT=load('TheoArrTime_50_50_2.mat');
TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
TheoArrTime_size=size(TheoArrTime);
%���ݼ첨������Դ��ϴ�����������׷��
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            
            %sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('�ڶ���ͼƬ��һ������׷����ʱ��')
% toc
result=RealArrTime;
theo=TheoArrTime;
%ͼƬ��ʱ����ת90���Ժ��ٴν�������׷�٣�ģ����Դ�ͼ첨����ֱ����ʱ������
c_Map=rotatepic_counterclockwise_90(x);
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat','file')==0%������
    error('no TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat');
TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
TheoArrTime_size=size(TheoArrTime);
%���ݼ첨������Դ��ϴ�����������׷��
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            
            %sprintf('raytrace rotate counterclockwise 90 num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('�ڶ���ͼƬ�ڶ�������׷����ʱ��')
% toc
result_r=RealArrTime;
theo_r=TheoArrTime;
finalRealArrTime=[finalRealArrTime result result_r];%��õ�һ��ͼƬ��ʵ�ʵ�ʱ
finalTheoArrTime=[finalTheoArrTime theo theo_r];%��õ�һ��ͼƬ�Ĳ�����ʱ
%�Եڶ���ͼƬ��������׷�٣���õ�ʱ��Ϣ



arriveTimeResult=(finalRealArrTime(1,:)-finalTheoArrTime(5,:)).*(finalRealArrTime(1,:)-finalTheoArrTime(5,:));%��ʱ����2����
arriveTimeResultNorm2=sqrt(sum(arriveTimeResult));
%����ͼ��֮��Ҫ�����ܽӽ�
% pic1_norm=double(pic1)./2560;%��һ������ƥ�䵽ʱ�ķ���
% pic2_norm=double(pic2)./2560;
% picNorm2=norm((pic1_norm-pic2_norm),2);
% 
% myans=arriveTimeResultNorm2+picNorm2;
if bigOrSmall==1%��ϵ��ȷ
    myans=arriveTimeResultNorm2;
else
    myans=arriveTimeResultNorm2*2;%��ϵ����ȷ�����ؽ����Ϊԭ��2��
end


end