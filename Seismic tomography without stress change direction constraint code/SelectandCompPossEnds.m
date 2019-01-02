function NewComputedPoint=SelectandCompPossEnds(NofPoints,Start,SelectedPoints,ComputedPoint,VMap)%选出可能的终点并更新权值，NofPoints为每边点数用于大小格子转换；Start为起点；SelectedPoints为已选点矩阵；ComputedPoint为已计算点矩阵；VMap为小格子形式的速度分布；返回值为新的已选矩阵和已计算矩阵
    XLengthofEachLattice=VMap(1,2).x;%横向上，一个格子的长度，用于转换x坐标与VMap索引
    YLengthofEachLattice=VMap(2,1).y;%纵向上，一个格子的长度，用于转换y坐标与VMap索引
    %按照四个方向，上下左右，查找当前起点对应终点的边界
    %起点对应的小格子行标，应用y坐标计算
    StartXiaoHang=Start.y/YLengthofEachLattice+1;
    %起点对应的小格子列标，应用x坐标计算
    StartXiaoLie=Start.x/XLengthofEachLattice+1;
    [YLengthofXiao XLengthofXiao]=size(VMap);%XLengthofXiao--横向小格子坐标个数 YLengthofXiao--纵向小格子坐标个数
    %起点对应的大格子行标，大格子中的点波速相同
    if StartXiaoHang==YLengthofXiao
        StartDaHang=floor((StartXiaoHang-2)/(NofPoints-1))+1;
    else
        StartDaHang=floor((StartXiaoHang-1)/(NofPoints-1))+1;
    end
    
    %起点对应的大格子列标
    if StartXiaoLie==XLengthofXiao
        StartDaLie=floor((StartXiaoLie-2)/(NofPoints-1))+1;
    else
        StartDaLie=floor((StartXiaoLie-1)/(NofPoints-1))+1;
    end
    %2016.9.6 通过当前点所在大格子判断当前点位置，用switch
    %case，考查起点是否位于边线、端点、格子中，再根据SelectedPoints确定选择哪些端点并更新对应权值，本函数应改为选择端点并计算权值，返回值为[SelectedPoints
    %ComputedPoints]，输入值应增加ComputedPoints
    [YLengthofXiao XLengthofXiao]=size(VMap);%XLengthofXiao--横向小格子坐标个数 YLengthofXiao--纵向小格子坐标个数
    XLengthofDa=(XLengthofXiao-1)/(NofPoints-1);%横向大格子个数，即速度分布图的列数，坐标数为格子数+1
    YLengthofDa=(YLengthofXiao-1)/(NofPoints-1);%纵向大格子个数，即速度分布图的行数，坐标数为格子数+1
    
    %判断起点是否在大格子内，若在，则可能的端点局限在本大格内，只有起点可能出现这种情况。若起点不在大格子内，则一定在边线上。
    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%本点所在大格最上小格子横坐标
    CurrentDaDown=CurrentDaUp-(NofPoints-1);%本点所在大格最下小格子横坐标
    
    if (StartXiaoLie>CurrentDaLeft)&&(StartXiaoLie<CurrentDaRight)&&(StartXiaoHang>CurrentDaDown)&&(StartXiaoHang<CurrentDaUp)%起点在大格子内
        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
    else%起点在大格子边线上
%         %大格子中的四个角
%         if ((StartXiaoLie==1)&&(StartXiaoHang==1))||((StartXiaoLie==1)&&(StartXiaoHang==YLengthofXiao))||((StartXiaoLie==XLengthofXiao)&&(StartXiaoHang==YLengthofXiao))||((StartXiaoLie==XLengthofXiao)&&(StartXiaoHang==1))
%             NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
%         end
        %先确定大格子是否是上、下、左、右，即最边上的大格子，是再判断当前小格子坐标落在四根边线的具体位置，顶点和边线应分别处理
        %若大个子不在边界上，则第二步判断小格子坐标的具体位置，分为边线和顶点
        DaCo=[StartDaHang StartDaLie];%构造当前大格子位置
        XiaoWhereAmI=WhereAmI(CurrentDaLeft,CurrentDaRight,CurrentDaDown,CurrentDaUp,StartXiaoLie,StartXiaoHang);%返回值为[上 下 左 右]
        if (StartDaHang==1)||(StartDaHang==YLengthofDa)||(StartDaLie==1)||(StartDaLie==XLengthofDa)%大格子在边线上            
            if DaCo==[1 1]%左下角，点位于大格的下线、左线时只计算当前大格
                if XiaoWhereAmI==[0 1 1 0]%小点位于左下，仅计算当前格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %此处应该走不到
                elseif  XiaoWhereAmI==[1 0 1 0]%左上，计算当前格和上一大格，对于起点和终点均在边线上的点，会以相邻两大格子中速度最高者计算当前权值
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%大格子上移一个
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %此处应该走不到
                elseif XiaoWhereAmI==[0 1 0 1]%右下，计算过当前格和右边格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%大格子右移一个
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %此处应该走不到
                elseif XiaoWhereAmI==[1 0 0 1]%右上，计算当前格和上、右、右上格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%大格子右移一个
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;
                    StartDaHang=StartDaHang+1;%大格子上移一个
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%大格子上移、右移一个
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);              
                else%小点位于边线上
                    if XiaoWhereAmI==[1 0 0 0]%上线，当前格和上一大格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%大格子上移一个
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%下线，当前格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%左线，当前格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%右线，当前格和右一格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%大格子右移一个
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('SandCPossEnds error 2!');
                    end
                end
            elseif DaCo==[1 XLengthofDa]%右下角
                if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格和左一格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%本点所在大格最右小格子横坐标
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%本点所在大格最左小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、左、上、左上大格需计算
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%右
                    StartDaHang=StartDaHang+1;%大格子上移一个
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左上
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%右上，当前格，上一格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%大格子上移一个
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%小点在边线上
                    if XiaoWhereAmI==[1 0 0 0]%上线，当前、上一格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%大格子上移一个
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%下线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左一格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%右线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 3!');
                    end
                end
            elseif DaCo==[YLengthofDa 1]%左上角
                if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格和下一格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%左上，当前
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、下、右、下右
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%上
                    StartDaLie=StartDaLie+1;%右
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%右下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%右上，当前格、右
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%右
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%小点在边线上
                    if XiaoWhereAmI==[1 0 0 0]%上线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下一格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%左线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%右线，当前、右
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 4!');
                    end
                end
            elseif DaCo==[YLengthofDa XLengthofDa]%右上角
                if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、左、下、左下
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%右
                    StartDaHang=StartDaHang-1;%下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左下
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、左
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、下
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%右上，当前格
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%小点在边线上
                    if XiaoWhereAmI==[1 0 0 0]%上线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下一格
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%右线，当前
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 5!');
                    end
                end
            else%在大格子的边线上，不在大格子的四个角上
                if DaCo(1,1)==1%在大格子 下 行
                    if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、左
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、左、上、左上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左上
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、右
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%右上，当前、右、上、右上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右上
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%小点在边线上
                        if XiaoWhereAmI==[1 0 0 0]%上线，当前、上
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%上
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%下线，当前
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%左
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%右线，当前、右
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%右
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 6!');
                        end
                    end
                elseif DaCo(1,1)==YLengthofDa%在大格子 上 行
                    if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、左、下、左下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左下
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、左
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、右、下、右下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右下
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%右上，当前、右
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%小点在边线上
                        if XiaoWhereAmI==[1 0 0 0]%上线，当前
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%下
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%左
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%右线，当前、右
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%右
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 7!');
                        end
                    end
                elseif DaCo(1,2)==1%在大格子 左 列
                    if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、右、下、右下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右下
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%右上，当前、右、上、右上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右上
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%小点在边线上
                        if XiaoWhereAmI==[1 0 0 0]%上线，当前、上
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%上
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%下
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%左线，当前
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%右线，当前、右
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%右
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 8!');
                        end
                    end
                elseif DaCo(1,2)==XLengthofDa%在大格子 右 列
                    if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、左、下、左下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左下
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、上、左、左上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%右
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%左上
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、下
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%下
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%右上，当前、上
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%上
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%小点在边线上
                        if XiaoWhereAmI==[1 0 0 0]%上线，当前、上
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%上
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%下
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%左
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%右线，当前
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 9!');
                        end
                    end
                else
                    error('error 10!');
                end
            end            
        else%大格子不在边线上
            if XiaoWhereAmI==[0 1 1 0]%小点位于左下，当前格、左、下、左下
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右
                StartDaHang=StartDaHang-1;%下
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左下
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[1 0 1 0]%左上，当前、上、左、左上
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右
                StartDaHang=StartDaHang+1;%上
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左上
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[0 1 0 1]%右下，当前格、下、右、右下
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左
                StartDaHang=StartDaHang-1;%下
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右下
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[1 0 0 1]%右上，当前、上、右、右上
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%左
                StartDaHang=StartDaHang+1;%上
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%右上
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            else%小点在边线上
                if XiaoWhereAmI==[1 0 0 0]%上线，当前、上
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%上
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 0]%下线，当前、下
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%下
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%大格最上小格子横坐标
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%大格最下小格子横坐标
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 0 1 0]%左线，当前、左
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%左
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 0 0 1]%右线，当前、右
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%右
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else
                    error('error 11!');
                end
            end
        end
    end 
end