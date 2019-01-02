function MyBestEnd=SelectBestEnd(VMap,ComputedPoint,SelectedPoint)
    [XComputedPoint YComputedPoint]=size(ComputedPoint);
    Condition=1;
    for i=1:1:XComputedPoint
        if Condition==0
            break;
        end
        for j=1:1:YComputedPoint
            if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%如果此点是可能的终点且不属于已选点范围
                MyBestEnd=VMap(i,j);%找到一个可能的点，将返回值指向这个点
                Condition=0;
                break;
            end
        end
    end
    %找到权值最小的终点并返回
    ToSelectPoint=ComputedPoint-SelectedPoint;
    XStart=0;
    XEnd=0;
    for i=1:1:XComputedPoint%按行查找待搜寻范围
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
    for i=1:1:YComputedPoint%按列查找待搜寻范围
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
            if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%如果此点是可能的终点且不属于已选点范围
                if MyBestEnd.data>VMap(i,j).data
                    MyBestEnd=VMap(i,j);
                end
            end
        end
    end
    
    
    
    
%     for i=1:1:XComputedPoint
%         for j=1:1:YComputedPoint
%             if (ComputedPoint(i,j)==1)&&(SelectedPoint(i,j)~=1)%如果此点是可能的终点且不属于已选点范围
%                 if MyBestEnd.data>VMap(i,j).data
%                     MyBestEnd=VMap(i,j);
%                 end
%             end
%         end
%     end

end