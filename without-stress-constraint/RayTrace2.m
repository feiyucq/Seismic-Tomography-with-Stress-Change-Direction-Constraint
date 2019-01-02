function TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)%送入的速度分布而不是图片地址
%参数配置
% c_tupian='diceng3_10_20.bmp';
% c_StartV=3000;
% c_EndV=6000;
% c_RealXLength=200;
% c_RealYLength=50;
% c_NofPoints=4;
% c_StartX=0;%实际坐标
% c_StartY=0;
% c_EndX=200;
% c_EndY=50;
%读取图片，解析为相应的速度分布，应先执行read_jpg.m选择合适的图像
% myjpg=imread(c_tupian);
% myjpg2=myjpg(:,:,2);%以此作为速度分布转换用图
myjpg2=myjpg;
%%%%%%%%%%%%%
% figure(1);%显示当前图片
% title('v distribution');
% imshow(myjpg2);%图片的（0，0）位于左上角，纵轴正方向向下，横轴正方向向右
%%%%%%%%%%%%5
clear myjpg;%清除无用变量

StartV=c_StartV;%速度范围，单位m/s，StartV对应图片中0，EndV对应图片中255，其余依次排列,StartV要大于EndV
EndV=c_EndV;
RealXLength=c_RealXLength;%实际横向长度，单位m
RealYLength=c_RealYLength;%实际纵向长度，单位m

MatrixV=im2double(myjpg2).*(EndV-StartV)+StartV;%速度矩阵，（0，0）位于左上角
[MVx MVy]=size(MatrixV);%MVx--速度矩阵行数，即纵坐标个数 MVy--速度矩阵列数，即横坐标个数
MatrixVtemp=MatrixV;
%转换坐标系，将图片的（0，0）转换到左下角
for i=1:1:MVx
    MatrixV(i,:)=MatrixVtemp(MVx-i+1,:);
end
clear MatrixVtemp;%清除临时变量
%%%%%%%%%%%%%%%%%%%%%
% figure(2);%显示速度转换后三维图
% surf(MatrixV,'DisplayName','MatrixV');figure(gcf);
%%%%%%%%%%%%%%%%
%网格数
[XNofGrid YNofGrid]=size(myjpg2);%XNofGrid--图片行数，即纵坐标个数，YNofGrid--图片列数，即横坐标个数

%每边点数
NofPoints=c_NofPoints;%不能小于2

%生成所有点的坐标及对应速度
test=zeros(((NofPoints-1)*XNofGrid+1),((NofPoints-1)*YNofGrid+1));%用于测试rtnodes中data获取的是否正确
for i=1:1:((NofPoints-1)*XNofGrid+1)%图片纵坐标循环
    for j=1:1:((NofPoints-1)*YNofGrid+1)%图片横坐标循环
        rtnodes(i,j)=rtnode();
        rtnodes(i,j).x=(j-1)*(RealXLength/((NofPoints-1)*YNofGrid));%获得每个点的实际x坐标
        rtnodes(i,j).y=(i-1)*(RealYLength/((NofPoints-1)*XNofGrid));%获得每个点的世纪y坐标
        %计算当前点对应速度，规则为向上对其，对NofPoints=3来说，如.x
        %.y=（0，0），对应速度分布（1，1），（1，0）-》（1，1），（2，0）-》（2，1），到终点附近，（199，0）-》（100，0），（200，0）-》（100，0）
        XofMatrixV=floor((j-1)/(NofPoints-1))+1;%向负无穷方向取整，即去掉小数部分，保留整数部分，获得当前坐标对应速度分布矩阵中方格坐标
        YofMatrixV=floor((i-1)/(NofPoints-1))+1;
        if XofMatrixV==YNofGrid+1
            XofMatrixV=XofMatrixV-1;
        end
        if YofMatrixV==XNofGrid+1
            YofMatrixV=YofMatrixV-1;
        end
        rtnodes(i,j).v=MatrixV(YofMatrixV,XofMatrixV);
        rtnodes(i,j).p=0;%默认所有点都不参与射线追踪计算
        %说明：图像上坐标x,y处值为z，对应rtnodes(y+1,x+1).data值为z
        test(i,j)=rtnodes(i,j).v;%用于测试rtnodes中data获取的是否正确
        
    end
end

% surf([8000 8000;8000 8000]);


%起点坐标，即实际坐标，横坐标范围0~RealXLength，纵坐标范围0~RealYLength，给入的坐标并不一定是实际用于计算的坐标，用于计算的坐标为距离给入坐标最近的rtnodes中的点
[Hangrtnodes Liertnodes]=size(rtnodes);%获得rtnodes的行数和列数
% StartX=round((RealXLength*0)/(RealXLength/(Liertnodes-1)))+1;%计算起点坐标对应rtnodes数组中的元素位置
% StartY=round((RealYLength*0)/(RealYLength/(Hangrtnodes-1)))+1;
StartX=round(c_StartX/(RealXLength/(Liertnodes-1)))+1;%计算起点坐标对应rtnodes数组中的元素位置
StartY=round(c_StartY/(RealYLength/(Hangrtnodes-1)))+1;
%终点坐标
% EndX=round((RealXLength*0.2)/(RealXLength/(Liertnodes-1)))+1;
% EndY=round((RealYLength*1)/(RealYLength/(Hangrtnodes-1)))+1;
EndX=round(c_EndX/(RealXLength/(Liertnodes-1)))+1;
EndY=round(c_EndY/(RealYLength/(Hangrtnodes-1)))+1;
% QiDianX=rtnodes(StartY,StartX).x
% QiDianY=rtnodes(StartY,StartX).y
% ZhongDianX=rtnodes(EndY,EndX).x
% ZhongDianY=rtnodes(EndY,EndX).y
%起点和终点参与射线追踪
rtnodes(StartY,StartX).p=1;
rtnodes(EndY,EndX).p=1;
%让边框上的点参与射线追踪计算
%按行找点
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
%按列找点
while(1)
    if i>Liertnodes
        break;
    end
    for j=1:1:Hangrtnodes
        rtnodes(j,i).p=1;
    end
    i=i+NofPoints-1;
end
%用于测试p设置是否正确
% testrtnode=zeros(Hangrtnodes,Liertnodes);
% for i=1:1:Hangrtnodes
%     for j=1:1:Liertnodes
%         testrtnode(i,j)=rtnodes(i,j).p;
%     end
% end
% 用于测试p设置是否正确

%2016.9.2
% tic;
MyBestPath=Dijkstra(NofPoints,rtnodes(StartY,StartX),rtnodes(EndY,EndX),rtnodes,test);
% toc;
TravalTime=MyBestPath.data;
end