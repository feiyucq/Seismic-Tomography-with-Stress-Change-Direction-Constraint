function BestPath=Dijkstra(NofPoints,Start,End,VMap,test)%BestPath��������·�����У�StartΪ��ʼ�㣬����rtnode��EndΪ�����㣬VMapΪ�ٶȷֲ���������������Ӧ���ٶ�,NofPointsΪÿ�ߵ���������ת����С����Start��End����VMap�еĵ�
    if Start==End
        Start.data=0;%������յ��غϣ�Ȩֵ��0
        Start.previous=Start;%������յ��غϣ�����·��ָ���Լ�
        BestPath=Start;
        return;
    end
    NewStart=Start;%�����=��ǰ���
    Start.data=0;%����ȨֵΪ0
    [YSizeVMap XSizeVMap]=size(VMap);%XSizeVMap��ʾVMap���������������������YXizeVMap��ʾVMap�������������������
    XLengthofEachLattice=VMap(1,2).x;%�����ϣ�һ�����ӵĳ��ȣ�����ת��x������VMap����
    YLengthofEachLattice=VMap(2,1).y;%�����ϣ�һ�����ӵĳ��ȣ�����ת��y������VMap����
    SelectedPoint=zeros(YSizeVMap,XSizeVMap);%SelectedPoint��ʾ��ѡ���ϣ���С��VMap��ͬ����Ӧλ��1˵����ѡ��Ϊ0˵��δѡ
    SelectedPoint(round(Start.y/YLengthofEachLattice+1),round(Start.x/XLengthofEachLattice+1))=1;%��ǰ��������ѡ����
    ComputedPoint=zeros(YSizeVMap,XSizeVMap);%��ʾ����Ȩֵ�ĵ㣬����ѡ����ʵ��յ�
    ComputedPoint(round(Start.y/YLengthofEachLattice+1),round(Start.x/XLengthofEachLattice+1))=1;%��Ӧλ��Ϊ1��ʾ��ǰ������Ȩֵ
    NofWhile=0;
%     tic;
    while(1)
        NofWhile=NofWhile+1;
        ComputedPoint=SelectandCompPossEnds(NofPoints,NewStart,SelectedPoint,ComputedPoint,VMap);
        %ѡ����ʵ��յ���Ϊ��һ����㡣ע�⣺����������֪Ȩֵ���յ����ҵ�Ȩֵ��С�ĵ�
        BestEnd=SelectBestEnd(VMap,ComputedPoint,SelectedPoint);
        %ѡ����յ���Ŀ���յ�
        if BestEnd==End
            break;
        else%ѡ��ĵ㲻��Ŀ���յ�
            NewStart=BestEnd;%���µ�ǰ���
            SelectedPoint(round(NewStart.y/YLengthofEachLattice+1),round(NewStart.x/XLengthofEachLattice+1))=1;%������������ѡ�㼯��
        end
    end
%     toc;
    BestPath=BestEnd;
%     NofWhile=NofWhile+0
    %��������·��
%     CurrentNode=BestPath;
%     while(1)
%         test(round(CurrentNode.y/YLengthofEachLattice+1),round(CurrentNode.x/XLengthofEachLattice+1))=6500;
%         if (CurrentNode.x==Start.x)&&(CurrentNode.y==Start.y)
%             break;
%         end
%         CurrentNode=CurrentNode.previous;
%     end
% 
% %���ڲ���rtnodes��data��ȡ���Ƿ���ȷ
%     figure(3);
%     surf(test,'DisplayName','test');figure(gcf);
end