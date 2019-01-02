function myans=PSO_hanshuzhi_test(x)
%!echo PSO_hanshuzhi
%将送入的x转换为图像
%x=PSO_FFTtoPic(x);
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
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat','file')==0%不存在
    error('no TheoArrTime.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
TheoArrTime=hofT.TheoArrTime;%获得理论到时
TheoArrTime_size=size(TheoArrTime);
%根据检波器和震源组合次数进行射线追踪
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
if matlabpool('size')<=0
    matlabpool;
end
parfor NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            
            sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end

% result=RealArrTime;
% theo=TheoArrTime;
% %图片逆时针旋转90度以后再次进行射线追踪，模拟震源和检波器垂直排列时的情形
% c_Map=rotatepic_counterclockwise_90(x);
% if exist('TheoArrTime_counterclockwise_90.mat','file')==0%不存在
%     error('no TheoArrTime_counterclockwise_90.mat');
% end
% hofT=load('TheoArrTime_counterclockwise_90.mat');
% TheoArrTime=hofT.TheoArrTime;%获得理论到时
% TheoArrTime_size=size(TheoArrTime);
% %根据检波器和震源组合次数进行射线追踪
% RealArrTime=zeros(1,TheoArrTime_size(1,2));
% c_pic=c_Map;
% parfor NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
%             
%             sprintf('raytrace rotate counterclockwise 90 num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
%             RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
%             %sprintf('trace time=%d',toc)
%             
% end
% result_r=RealArrTime;
% theo_r=TheoArrTime;
% RealArrTime=[result,result_r];
% TheoArrTime=[theo,theo_r];
mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%计算2范数
%mytemp=(RealArrTime(1,:)-RealArrTime(1,:)).*(RealArrTime(1,:)-RealArrTime(1,:));
%mytemp=(RealArrTime(1,:)-RealArrTime2(1,:)).*(RealArrTime(1,:)-RealArrTime2(1,:));
myans=sqrt(sum(mytemp));
%sprintf('PSO_hanshuzhi run time=%d',toc)
% %********************************************************************
%     c_Map_size=size(c_Map);
%     NofIndividual=c_Map_size(1,1);%种群中个体个数
%     TheoArrTime_size=size(TheoArrTime);
%     %取出c_Map中内容，生成速度分布，根据TheoArrTime中震源坐标和检波器坐标计算理论到时，将理论到时与实测到时的2范数作为每个个体的返回值送出
%     test_ans=zeros(NofIndividual,1);   
%     for i=1:1:NofIndividual%parfor
%         
%         %k=1;
% %         c_pic=zeros(c_pic_hang,c_pic_lie);
% %         c_pic=uint8(c_pic);
% %         %将个体内容转换为图片
% %         for m=1:1:c_pic_hang
% %             for n=1:1:c_pic_lie
% %                 c_pic(m,n)=c_Map(i,k);%出错，未进行向量和矩阵转换
% %                 k=k+1;
% %             end
% %         end
% %         c_pic=uint8(c_pic);%格式转换
%          c_pic=c_Map;
%         %TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)
%         RealArrTime=zeros(1,TheoArrTime_size(1,2));
%         %tic;
%         for NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
%             !echo start raytrace
%             tic;
%             RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
%             toc;
%             !echo stop raytrace
%         end
%         %toc;
%         mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%计算2范数
%         test_ans(i,1)=sqrt(sum(mytemp));
%     end
%     myans=test_ans';
%     toc;
end