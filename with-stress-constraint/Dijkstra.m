function BestPath=Dijkstra(NofPoints,Start,End,VMap,test)%BestPath返回最优路径序列，Start为起始点，类型rtnode，End为结束点，VMap为速度分布，即所有坐标点对应的速度,NofPoints为每边点数，用于转换大小方格。Start和End需是VMap中的点
    if Start==End
        Start.data=0;%起点与终点重合，权值置0
        Start.previous=Start;%起点与终点重合，最优路径指向自己
        BestPath=Start;
        return;
    end
    NewStart=Start;%新起点=当前起点
    Start.data=0;%起点的权值为0
    [YSizeVMap XSizeVMap]=size(VMap);%XSizeVMap表示VMap的列数，即横轴格子数，YXizeVMap表示VMap的行数，即纵轴格子数
    XLengthofEachLattice=VMap(1,2).x;%横向上，一个格子的长度，用于转换x坐标与VMap索引
    YLengthofEachLattice=VMap(2,1).y;%纵向上，一个格子的长度，用于转换y坐标与VMap索引
    SelectedPoint=zeros(YSizeVMap,XSizeVMap);%SelectedPoint表示已选集合，大小与VMap相同，对应位置1说明已选，为0说明未选
    SelectedPoint(round(Start.y/YLengthofEachLattice+1),round(Start.x/XLengthofEachLattice+1))=1;%当前起点放入已选集合
    ComputedPoint=zeros(YSizeVMap,XSizeVMap);%表示已有权值的点，用于选择合适的终点
    ComputedPoint(round(Start.y/YLengthofEachLattice+1),round(Start.x/XLengthofEachLattice+1))=1;%对应位置为1表示当前点已有权值
    NofWhile=0;
%     tic;
    while(1)
        NofWhile=NofWhile+1;
        ComputedPoint=SelectandCompPossEnds(NofPoints,NewStart,SelectedPoint,ComputedPoint,VMap);
        %选择合适的终点作为下一个起点。注意：是在所有已知权值的终点中找到权值最小的点
        BestEnd=SelectBestEnd(VMap,ComputedPoint,SelectedPoint);
        %选择的终点是目的终点
        if BestEnd==End
            break;
        else%选择的点不是目的终点
            NewStart=BestEnd;%更新当前起点
            SelectedPoint(round(NewStart.y/YLengthofEachLattice+1),round(NewStart.x/XLengthofEachLattice+1))=1;%将新起点加入已选点集合
        end
    end
%     toc;
    BestPath=BestEnd;
%     NofWhile=NofWhile+0
    %绘制射线路径
%     CurrentNode=BestPath;
%     while(1)
%         test(round(CurrentNode.y/YLengthofEachLattice+1),round(CurrentNode.x/XLengthofEachLattice+1))=6500;
%         if (CurrentNode.x==Start.x)&&(CurrentNode.y==Start.y)
%             break;
%         end
%         CurrentNode=CurrentNode.previous;
%     end
% 
% %用于测试rtnodes中data获取的是否正确
%     figure(3);
%     surf(test,'DisplayName','test');figure(gcf);
end