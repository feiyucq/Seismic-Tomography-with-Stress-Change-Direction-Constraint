function NewComputedPoint=SelectandCompPossEnds(NofPoints,Start,SelectedPoints,ComputedPoint,VMap)%ѡ�����ܵ��յ㲢����Ȩֵ��NofPointsΪÿ�ߵ������ڴ�С����ת����StartΪ��㣻SelectedPointsΪ��ѡ�����ComputedPointΪ�Ѽ�������VMapΪС������ʽ���ٶȷֲ�������ֵΪ�µ���ѡ������Ѽ������
    XLengthofEachLattice=VMap(1,2).x;%�����ϣ�һ�����ӵĳ��ȣ�����ת��x������VMap����
    YLengthofEachLattice=VMap(2,1).y;%�����ϣ�һ�����ӵĳ��ȣ�����ת��y������VMap����
    %�����ĸ������������ң����ҵ�ǰ����Ӧ�յ�ı߽�
    %����Ӧ��С�����б꣬Ӧ��y�������
    StartXiaoHang=Start.y/YLengthofEachLattice+1;
    %����Ӧ��С�����б꣬Ӧ��x�������
    StartXiaoLie=Start.x/XLengthofEachLattice+1;
    [YLengthofXiao XLengthofXiao]=size(VMap);%XLengthofXiao--����С����������� YLengthofXiao--����С�����������
    %����Ӧ�Ĵ�����б꣬������еĵ㲨����ͬ
    if StartXiaoHang==YLengthofXiao
        StartDaHang=floor((StartXiaoHang-2)/(NofPoints-1))+1;
    else
        StartDaHang=floor((StartXiaoHang-1)/(NofPoints-1))+1;
    end
    
    %����Ӧ�Ĵ�����б�
    if StartXiaoLie==XLengthofXiao
        StartDaLie=floor((StartXiaoLie-2)/(NofPoints-1))+1;
    else
        StartDaLie=floor((StartXiaoLie-1)/(NofPoints-1))+1;
    end
    %2016.9.6 ͨ����ǰ�����ڴ�����жϵ�ǰ��λ�ã���switch
    %case����������Ƿ�λ�ڱ��ߡ��˵㡢�����У��ٸ���SelectedPointsȷ��ѡ����Щ�˵㲢���¶�ӦȨֵ��������Ӧ��Ϊѡ��˵㲢����Ȩֵ������ֵΪ[SelectedPoints
    %ComputedPoints]������ֵӦ����ComputedPoints
    [YLengthofXiao XLengthofXiao]=size(VMap);%XLengthofXiao--����С����������� YLengthofXiao--����С�����������
    XLengthofDa=(XLengthofXiao-1)/(NofPoints-1);%�������Ӹ��������ٶȷֲ�ͼ��������������Ϊ������+1
    YLengthofDa=(YLengthofXiao-1)/(NofPoints-1);%�������Ӹ��������ٶȷֲ�ͼ��������������Ϊ������+1
    
    %�ж�����Ƿ��ڴ�����ڣ����ڣ�����ܵĶ˵�����ڱ�����ڣ�ֻ�������ܳ����������������㲻�ڴ�����ڣ���һ���ڱ����ϡ�
    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������ڴ������С���Ӻ�����
    
    if (StartXiaoLie>CurrentDaLeft)&&(StartXiaoLie<CurrentDaRight)&&(StartXiaoHang>CurrentDaDown)&&(StartXiaoHang<CurrentDaUp)%����ڴ������
        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
    else%����ڴ���ӱ�����
%         %������е��ĸ���
%         if ((StartXiaoLie==1)&&(StartXiaoHang==1))||((StartXiaoLie==1)&&(StartXiaoHang==YLengthofXiao))||((StartXiaoLie==XLengthofXiao)&&(StartXiaoHang==YLengthofXiao))||((StartXiaoLie==XLengthofXiao)&&(StartXiaoHang==1))
%             NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
%         end
        %��ȷ��������Ƿ����ϡ��¡����ң�������ϵĴ���ӣ������жϵ�ǰС�������������ĸ����ߵľ���λ�ã�����ͱ���Ӧ�ֱ���
        %������Ӳ��ڱ߽��ϣ���ڶ����ж�С��������ľ���λ�ã���Ϊ���ߺͶ���
        DaCo=[StartDaHang StartDaLie];%���쵱ǰ�����λ��
        XiaoWhereAmI=WhereAmI(CurrentDaLeft,CurrentDaRight,CurrentDaDown,CurrentDaUp,StartXiaoLie,StartXiaoHang);%����ֵΪ[�� �� �� ��]
        if (StartDaHang==1)||(StartDaHang==YLengthofDa)||(StartDaLie==1)||(StartDaLie==XLengthofDa)%������ڱ�����            
            if DaCo==[1 1]%���½ǣ���λ�ڴ������ߡ�����ʱֻ���㵱ǰ���
                if XiaoWhereAmI==[0 1 1 0]%С��λ�����£������㵱ǰ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %�˴�Ӧ���߲���
                elseif  XiaoWhereAmI==[1 0 1 0]%���ϣ����㵱ǰ�����һ��񣬶��������յ���ڱ����ϵĵ㣬������������������ٶ�����߼��㵱ǰȨֵ
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%���������һ��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %�˴�Ӧ���߲���
                elseif XiaoWhereAmI==[0 1 0 1]%���£��������ǰ����ұ߸�
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%���������һ��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                %�˴�Ӧ���߲���
                elseif XiaoWhereAmI==[1 0 0 1]%���ϣ����㵱ǰ����ϡ��ҡ����ϸ�
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%���������һ��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;
                    StartDaHang=StartDaHang+1;%���������һ��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%��������ơ�����һ��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);              
                else%С��λ�ڱ�����
                    if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ�����һ���
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%���������һ��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ�����һ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%���������һ��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('SandCPossEnds error 2!');
                    end
                end
            elseif DaCo==[1 XLengthofDa]%���½�
                if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����һ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;%�������ڴ������С���Ӻ�����
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);%�������ڴ������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ�����ϡ����ϴ�������
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%��
                    StartDaHang=StartDaHang+1;%���������һ��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%����
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ����һ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%���������һ��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%С���ڱ�����
                    if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ����һ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%���������һ��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����һ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 3!');
                    end
                end
            elseif DaCo==[YLengthofDa 1]%���Ͻ�
                if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����һ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ���¡��ҡ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%��
                    StartDaLie=StartDaLie+1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%����
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%С���ڱ�����
                    if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����һ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 4!');
                    end
                end
            elseif DaCo==[YLengthofDa XLengthofDa]%���Ͻ�
                if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����¡�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%��
                    StartDaHang=StartDaHang-1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%����
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ��
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                else%С���ڱ�����
                    if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����һ��
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else
                        error('error 5!');
                    end
                end
            else%�ڴ���ӵı����ϣ����ڴ���ӵ��ĸ�����
                if DaCo(1,1)==1%�ڴ���� �� ��
                    if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ�����ϡ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ���ҡ��ϡ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%С���ڱ�����
                        if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 6!');
                        end
                    end
                elseif DaCo(1,1)==YLengthofDa%�ڴ���� �� ��
                    if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����¡�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ���ҡ��¡�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%С���ڱ�����
                        if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 7!');
                        end
                    end
                elseif DaCo(1,2)==1%�ڴ���� �� ��
                    if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ���ҡ��¡�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ���ҡ��ϡ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%С���ڱ�����
                        if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie+1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 8!');
                        end
                    end
                elseif DaCo(1,2)==XLengthofDa%�ڴ���� �� ��
                    if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����¡�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ���ϡ�������
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%��
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie+1;%��
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaLie=StartDaLie-1;%����
                        CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                        CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang-1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        ComputedPoint=NewComputedPoint;
                        StartDaHang=StartDaHang+1;%��
                        CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                        CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                        NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    else%С���ڱ�����
                        if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang+1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaHang=StartDaHang-1;%��
                            CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                            CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                            ComputedPoint=NewComputedPoint;
                            StartDaLie=StartDaLie-1;%��
                            CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                            CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ
                            NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                        else
                            error('error 9!');
                        end
                    end
                else
                    error('error 10!');
                end
            end            
        else%����Ӳ��ڱ�����
            if XiaoWhereAmI==[0 1 1 0]%С��λ�����£���ǰ�����¡�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%��
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%��
                StartDaHang=StartDaHang-1;%��
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%����
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[1 0 1 0]%���ϣ���ǰ���ϡ�������
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%��
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%��
                StartDaHang=StartDaHang+1;%��
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%����
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[0 1 0 1]%���£���ǰ���¡��ҡ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%��
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%��
                StartDaHang=StartDaHang-1;%��
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%����
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            elseif XiaoWhereAmI==[1 0 0 1]%���ϣ���ǰ���ϡ��ҡ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%��
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie-1;%��
                StartDaHang=StartDaHang+1;%��
                CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                ComputedPoint=NewComputedPoint;
                StartDaLie=StartDaLie+1;%����
                CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
            else%С���ڱ�����
                if XiaoWhereAmI==[1 0 0 0]%���ߣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang+1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 1 0 0]%���ߣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaHang=StartDaHang-1;%��
                    CurrentDaUp=StartDaHang*(NofPoints-1)+1;%�������С���Ӻ�����
                    CurrentDaDown=CurrentDaUp-(NofPoints-1);%�������С���Ӻ�����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 0 1 0]%���ߣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie-1;%��
                    CurrentDaRight=StartDaLie*(NofPoints-1)+1;
                    CurrentDaLeft=CurrentDaRight-(NofPoints-1);
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                elseif XiaoWhereAmI==[0 0 0 1]%���ߣ���ǰ����
                    NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,CurrentDaLeft,CurrentDaRight,CurrentDaUp,CurrentDaDown,VMap(CurrentDaDown+1,CurrentDaLeft+1).v,Start,VMap);
                    ComputedPoint=NewComputedPoint;
                    StartDaLie=StartDaLie+1;%��
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