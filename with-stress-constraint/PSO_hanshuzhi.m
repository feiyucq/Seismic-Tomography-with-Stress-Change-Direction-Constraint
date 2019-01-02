function myans=PSO_hanshuzhi(x)
%检查两幅图片之间是否符合已测得的大小关系
bigOrSmall=checkPic(x);
%送入的为两张图片的随机模型，需要从中间分开，变为两个独立的模型
sizeOfX=size(x);
if sizeOfX(1,1)~=1
    error('sizeOfX(1,1)~=1');
end
x1=x(1,1:(sizeOfX(1,2)/2));%获得第一幅图片信息
x2=x(1,(sizeOfX(1,2)/2+1):sizeOfX(1,2));%获得第二幅图片信息

%对第一幅图片进行射线追踪，获得到时信息
x=x1;
%将送入的x转换为图像
x=PSO_FFTtoPic(x);
pic1=x;
%将送入的x转换为图像
%送入的x为待求解的一个个体，应取整
%x=round(x);%取整
c_tupian='diceng_50_50.bmp';
c_StartV=300;
c_EndV=600;
c_RealXLength=2000;
c_RealYLength=500;
c_NofPoints=2;%50*50图像时改为2
%TheoArrTime=0;%!!!!!!must be changed correct
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);
c_pic_hang=sizemyjpg(1,1);
c_pic_lie=sizemyjpg(1,2);
c_Map=x;%PSO送入的值列对应变量，c_Map中行对应变量，获得一幅图像
%c_Map=uint8(c_Map);
%查看理论到时是否存在，不存在报错，存在则读取
if exist('TheoArrTime_50_50.mat','file')==0%不存在
    error('no TheoArrTime.mat');
end
hofT=load('TheoArrTime_50_50.mat');
TheoArrTime=hofT.TheoArrTime;%获得理论到时
TheoArrTime_size=size(TheoArrTime);
%根据检波器和震源组合次数进行射线追踪
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            
            %sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('第一张图片第一次射线追踪用时：')
% toc
result=RealArrTime;
theo=TheoArrTime;
%图片逆时针旋转90度以后再次进行射线追踪，模拟震源和检波器垂直排列时的情形
c_Map=rotatepic_counterclockwise_90(x);
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat','file')==0%不存在
    error('no TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
TheoArrTime=hofT.TheoArrTime;%获得理论到时
TheoArrTime_size=size(TheoArrTime);
%根据检波器和震源组合次数进行射线追踪
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            
            %sprintf('raytrace rotate counterclockwise 90 num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('第一张图片第二次射线追踪用时：')
% toc
result_r=RealArrTime;
theo_r=TheoArrTime;
finalRealArrTime=[result result_r];%获得第一幅图片的实际到时
finalTheoArrTime=[theo theo_r];%获得第一幅图片的测量到时
%对第一幅图片进行射线追踪，获得到时信息


%对第二幅图片进行射线追踪，获得到时信息
x=x2;
%将送入的x转换为图像
x=PSO_FFTtoPic(x);
pic2=x;
%将送入的x转换为图像
tic;
%送入的x为待求解的一个个体，应取整
%x=round(x);%取整
c_tupian='diceng_50_50.bmp';
c_StartV=30;
c_EndV=60;
c_RealXLength=200;
c_RealYLength=50;
c_NofPoints=2;%50*50图像时改为2
%TheoArrTime=0;%!!!!!!must be changed correct
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);
c_pic_hang=sizemyjpg(1,1);
c_pic_lie=sizemyjpg(1,2);
c_Map=x;%PSO送入的值列对应变量，c_Map中行对应变量，获得一幅图像
%c_Map=uint8(c_Map);
%查看理论到时是否存在，不存在报错，存在则读取
if exist('TheoArrTime_50_50_2.mat','file')==0%不存在
    error('no TheoArrTime_2.mat');
end
hofT=load('TheoArrTime_50_50_2.mat');
TheoArrTime=hofT.TheoArrTime;%获得理论到时
TheoArrTime_size=size(TheoArrTime);
%根据检波器和震源组合次数进行射线追踪
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            
            %sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('第二张图片第一次射线追踪用时：')
% toc
result=RealArrTime;
theo=TheoArrTime;
%图片逆时针旋转90度以后再次进行射线追踪，模拟震源和检波器垂直排列时的情形
c_Map=rotatepic_counterclockwise_90(x);
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat','file')==0%不存在
    error('no TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90_2.mat');
TheoArrTime=hofT.TheoArrTime;%获得理论到时
TheoArrTime_size=size(TheoArrTime);
%根据检波器和震源组合次数进行射线追踪
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
% tic;
for NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            
            %sprintf('raytrace rotate counterclockwise 90 num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end
% sprintf('第二张图片第二次射线追踪用时：')
% toc
result_r=RealArrTime;
theo_r=TheoArrTime;
finalRealArrTime=[finalRealArrTime result result_r];%获得第一幅图片的实际到时
finalTheoArrTime=[finalTheoArrTime theo theo_r];%获得第一幅图片的测量到时
%对第二幅图片进行射线追踪，获得到时信息



arriveTimeResult=(finalRealArrTime(1,:)-finalTheoArrTime(5,:)).*(finalRealArrTime(1,:)-finalTheoArrTime(5,:));%到时计算2范数
arriveTimeResultNorm2=sqrt(sum(arriveTimeResult));
%两幅图像之间要尽可能接近
% pic1_norm=double(pic1)./2560;%归一化，以匹配到时的范数
% pic2_norm=double(pic2)./2560;
% picNorm2=norm((pic1_norm-pic2_norm),2);
% 
% myans=arriveTimeResultNorm2+picNorm2;
if bigOrSmall==1%关系正确
    myans=arriveTimeResultNorm2;
else
    myans=arriveTimeResultNorm2*2;%关系不正确，返回结果变为原来2倍
end


end