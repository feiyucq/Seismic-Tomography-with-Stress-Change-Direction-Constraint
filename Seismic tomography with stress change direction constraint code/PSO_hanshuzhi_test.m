function myans=PSO_hanshuzhi_test(x)
%!echo PSO_hanshuzhi
%�������xת��Ϊͼ��
%x=PSO_FFTtoPic(x);
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
if exist('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat','file')==0%������
    error('no TheoArrTime.mat');
end
hofT=load('TheoArrTime_counterclockwise_90_50_50_counterclockwise_90.mat');
TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
TheoArrTime_size=size(TheoArrTime);
%���ݼ첨������Դ��ϴ�����������׷��
RealArrTime=zeros(1,TheoArrTime_size(1,2));
c_pic=c_Map;
if matlabpool('size')<=0
    matlabpool;
end
parfor NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            
            sprintf('raytrace num=%d,total=%d',NofArr,TheoArrTime_size(1,2))
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            %sprintf('trace time=%d',toc)
            
end

% result=RealArrTime;
% theo=TheoArrTime;
% %ͼƬ��ʱ����ת90���Ժ��ٴν�������׷�٣�ģ����Դ�ͼ첨����ֱ����ʱ������
% c_Map=rotatepic_counterclockwise_90(x);
% if exist('TheoArrTime_counterclockwise_90.mat','file')==0%������
%     error('no TheoArrTime_counterclockwise_90.mat');
% end
% hofT=load('TheoArrTime_counterclockwise_90.mat');
% TheoArrTime=hofT.TheoArrTime;%������۵�ʱ
% TheoArrTime_size=size(TheoArrTime);
% %���ݼ첨������Դ��ϴ�����������׷��
% RealArrTime=zeros(1,TheoArrTime_size(1,2));
% c_pic=c_Map;
% parfor NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
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
mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%����2����
%mytemp=(RealArrTime(1,:)-RealArrTime(1,:)).*(RealArrTime(1,:)-RealArrTime(1,:));
%mytemp=(RealArrTime(1,:)-RealArrTime2(1,:)).*(RealArrTime(1,:)-RealArrTime2(1,:));
myans=sqrt(sum(mytemp));
%sprintf('PSO_hanshuzhi run time=%d',toc)
% %********************************************************************
%     c_Map_size=size(c_Map);
%     NofIndividual=c_Map_size(1,1);%��Ⱥ�и������
%     TheoArrTime_size=size(TheoArrTime);
%     %ȡ��c_Map�����ݣ������ٶȷֲ�������TheoArrTime����Դ����ͼ첨������������۵�ʱ�������۵�ʱ��ʵ�⵽ʱ��2������Ϊÿ������ķ���ֵ�ͳ�
%     test_ans=zeros(NofIndividual,1);   
%     for i=1:1:NofIndividual%parfor
%         
%         %k=1;
% %         c_pic=zeros(c_pic_hang,c_pic_lie);
% %         c_pic=uint8(c_pic);
% %         %����������ת��ΪͼƬ
% %         for m=1:1:c_pic_hang
% %             for n=1:1:c_pic_lie
% %                 c_pic(m,n)=c_Map(i,k);%����δ���������;���ת��
% %                 k=k+1;
% %             end
% %         end
% %         c_pic=uint8(c_pic);%��ʽת��
%          c_pic=c_Map;
%         %TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)
%         RealArrTime=zeros(1,TheoArrTime_size(1,2));
%         %tic;
%         for NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
%             !echo start raytrace
%             tic;
%             RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
%             toc;
%             !echo stop raytrace
%         end
%         %toc;
%         mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%����2����
%         test_ans(i,1)=sqrt(sum(mytemp));
%     end
%     myans=test_ans';
%     toc;
end