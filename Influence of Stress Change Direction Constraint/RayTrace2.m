function TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)%������ٶȷֲ�������ͼƬ��ַ
%��������
% c_tupian='diceng3_10_20.bmp';
% c_StartV=3000;
% c_EndV=6000;
% c_RealXLength=200;
% c_RealYLength=50;
% c_NofPoints=4;
% c_StartX=0;%ʵ������
% c_StartY=0;
% c_EndX=200;
% c_EndY=50;
%��ȡͼƬ������Ϊ��Ӧ���ٶȷֲ���Ӧ��ִ��read_jpg.mѡ����ʵ�ͼ��
% myjpg=imread(c_tupian);
% myjpg2=myjpg(:,:,2);%�Դ���Ϊ�ٶȷֲ�ת����ͼ
myjpg2=myjpg;
%%%%%%%%%%%%%
% figure(1);%��ʾ��ǰͼƬ
% title('v distribution');
% imshow(myjpg2);%ͼƬ�ģ�0��0��λ�����Ͻǣ��������������£���������������
%%%%%%%%%%%%5
clear myjpg;%������ñ���

StartV=c_StartV;%�ٶȷ�Χ����λm/s��StartV��ӦͼƬ��0��EndV��ӦͼƬ��255��������������,StartVҪ����EndV
EndV=c_EndV;
RealXLength=c_RealXLength;%ʵ�ʺ��򳤶ȣ���λm
RealYLength=c_RealYLength;%ʵ�����򳤶ȣ���λm

MatrixV=im2double(myjpg2).*(EndV-StartV)+StartV;%�ٶȾ��󣬣�0��0��λ�����Ͻ�
[MVx MVy]=size(MatrixV);%MVx--�ٶȾ�������������������� MVy--�ٶȾ��������������������
MatrixVtemp=MatrixV;
%ת������ϵ����ͼƬ�ģ�0��0��ת�������½�
for i=1:1:MVx
    MatrixV(i,:)=MatrixVtemp(MVx-i+1,:);
end
clear MatrixVtemp;%�����ʱ����
%%%%%%%%%%%%%%%%%%%%%
% figure(2);%��ʾ�ٶ�ת������άͼ
% surf(MatrixV,'DisplayName','MatrixV');figure(gcf);
%%%%%%%%%%%%%%%%
%������
[XNofGrid YNofGrid]=size(myjpg2);%XNofGrid--ͼƬ�������������������YNofGrid--ͼƬ�����������������

%ÿ�ߵ���
NofPoints=c_NofPoints;%����С��2

%�������е�����꼰��Ӧ�ٶ�
test=zeros(((NofPoints-1)*XNofGrid+1),((NofPoints-1)*YNofGrid+1));%���ڲ���rtnodes��data��ȡ���Ƿ���ȷ
for i=1:1:((NofPoints-1)*XNofGrid+1)%ͼƬ������ѭ��
    for j=1:1:((NofPoints-1)*YNofGrid+1)%ͼƬ������ѭ��
        rtnodes(i,j)=rtnode();
        rtnodes(i,j).x=(j-1)*(RealXLength/((NofPoints-1)*YNofGrid));%���ÿ�����ʵ��x����
        rtnodes(i,j).y=(i-1)*(RealYLength/((NofPoints-1)*XNofGrid));%���ÿ���������y����
        %���㵱ǰ���Ӧ�ٶȣ�����Ϊ���϶��䣬��NofPoints=3��˵����.x
        %.y=��0��0������Ӧ�ٶȷֲ���1��1������1��0��-����1��1������2��0��-����2��1�������յ㸽������199��0��-����100��0������200��0��-����100��0��
        XofMatrixV=floor((j-1)/(NofPoints-1))+1;%�������ȡ������ȥ��С�����֣������������֣���õ�ǰ�����Ӧ�ٶȷֲ������з�������
        YofMatrixV=floor((i-1)/(NofPoints-1))+1;
        if XofMatrixV==YNofGrid+1
            XofMatrixV=XofMatrixV-1;
        end
        if YofMatrixV==XNofGrid+1
            YofMatrixV=YofMatrixV-1;
        end
        rtnodes(i,j).v=MatrixV(YofMatrixV,XofMatrixV);
        rtnodes(i,j).p=0;%Ĭ�����е㶼����������׷�ټ���
        %˵����ͼ��������x,y��ֵΪz����Ӧrtnodes(y+1,x+1).dataֵΪz
        test(i,j)=rtnodes(i,j).v;%���ڲ���rtnodes��data��ȡ���Ƿ���ȷ
        
    end
end

% surf([8000 8000;8000 8000]);


%������꣬��ʵ�����꣬�����귶Χ0~RealXLength�������귶Χ0~RealYLength����������겢��һ����ʵ�����ڼ�������꣬���ڼ��������Ϊ����������������rtnodes�еĵ�
[Hangrtnodes Liertnodes]=size(rtnodes);%���rtnodes������������
% StartX=round((RealXLength*0)/(RealXLength/(Liertnodes-1)))+1;%������������Ӧrtnodes�����е�Ԫ��λ��
% StartY=round((RealYLength*0)/(RealYLength/(Hangrtnodes-1)))+1;
StartX=round(c_StartX/(RealXLength/(Liertnodes-1)))+1;%������������Ӧrtnodes�����е�Ԫ��λ��
StartY=round(c_StartY/(RealYLength/(Hangrtnodes-1)))+1;
%�յ�����
% EndX=round((RealXLength*0.2)/(RealXLength/(Liertnodes-1)))+1;
% EndY=round((RealYLength*1)/(RealYLength/(Hangrtnodes-1)))+1;
EndX=round(c_EndX/(RealXLength/(Liertnodes-1)))+1;
EndY=round(c_EndY/(RealYLength/(Hangrtnodes-1)))+1;
% QiDianX=rtnodes(StartY,StartX).x
% QiDianY=rtnodes(StartY,StartX).y
% ZhongDianX=rtnodes(EndY,EndX).x
% ZhongDianY=rtnodes(EndY,EndX).y
%�����յ��������׷��
rtnodes(StartY,StartX).p=1;
rtnodes(EndY,EndX).p=1;
%�ñ߿��ϵĵ��������׷�ټ���
%�����ҵ�
i=1;
while(1)
    if i>Hangrtnodes
        break;
    end
    for j=1:1:Liertnodes
        rtnodes(i,j).p=1;
    end
    i=i+NofPoints-1;
end
i=1;
%�����ҵ�
while(1)
    if i>Liertnodes
        break;
    end
    for j=1:1:Hangrtnodes
        rtnodes(j,i).p=1;
    end
    i=i+NofPoints-1;
end
%���ڲ���p�����Ƿ���ȷ
% testrtnode=zeros(Hangrtnodes,Liertnodes);
% for i=1:1:Hangrtnodes
%     for j=1:1:Liertnodes
%         testrtnode(i,j)=rtnodes(i,j).p;
%     end
% end
% ���ڲ���p�����Ƿ���ȷ

%2016.9.2
% tic;
MyBestPath=Dijkstra(NofPoints,rtnodes(StartY,StartX),rtnodes(EndY,EndX),rtnodes,test);
% toc;
TravalTime=MyBestPath.data;
end