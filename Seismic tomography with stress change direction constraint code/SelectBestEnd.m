function MyBestEnd=SelectBestEnd(VMap,ComputedPoint,SelectedPoint)
    [XComputedPoint YComputedPoint]=size(ComputedPoint);
    Condition=1;
    for i=1:1:XComputedPoint
        if Condition==0
            break;
        end
        for j=1:1:YComputedPoint
            if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%����˵��ǿ��ܵ��յ��Ҳ�������ѡ�㷶Χ
                MyBestEnd=VMap(i,j);%�ҵ�һ�����ܵĵ㣬������ֵָ�������
                Condition=0;
                break;
            end
        end
    end
    %�ҵ�Ȩֵ��С���յ㲢����
    ToSelectPoint=ComputedPoint-SelectedPoint;
    XStart=0;
    XEnd=0;
    for i=1:1:XComputedPoint%���в��Ҵ���Ѱ��Χ
        if max(ComputedPoint(i,:))==1
            if XStart==0
                XStart=i;
                XEnd=i;
            else
                XEnd=XEnd+1;
            end
        end
    end
    
    YStart=0;
    YEnd=0;
    for i=1:1:YComputedPoint%���в��Ҵ���Ѱ��Χ
        if max(ComputedPoint(:,i))==1
            if YStart==0
                YStart=i;
                YEnd=i;
            else
                YEnd=YEnd+1;
            end
        end
    end
    
    for i=XStart:1:XEnd
        for j=YStart:1:YEnd
            if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%����˵��ǿ��ܵ��յ��Ҳ�������ѡ�㷶Χ
                if MyBestEnd.data>VMap(i,j).data
                    MyBestEnd=VMap(i,j);
                end
            end
        end
    end
    
    
    
    
%     for i=1:1:XComputedPoint
%         for j=1:1:YComputedPoint
%             if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%����˵��ǿ��ܵ��յ��Ҳ�������ѡ�㷶Χ
%                 if MyBestEnd.data>VMap(i,j).data
%                     MyBestEnd=VMap(i,j);
%                 end
%             end
%         end
%     end

end