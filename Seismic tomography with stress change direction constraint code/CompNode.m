function NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,Left,Right,Up,Down,V,Start,VMap)%计算起点到Left、Right、Up、Down规定的范围内点的权值并更新，L R U D为小格子坐标，V为用于计算的速度
    NewComputedPoint=ComputedPoint;
    for i=Left:1:Right%i为横坐标，对应列标
        for j=Down:1:Up%j为纵坐标，对应行标
            if (VMap(j,i).x==Start.x)&&(VMap(j,i).y==Start.y)%与起点重合，不计算
                continue;
            end
            %与起点不重合，但不是边框上的点，不参与计算
            if VMap(j,i).p==0
                continue;
            end
            %是边框上点，且与起点不重合，但属于已选点集
            if SelectedPoints(j,i)==1
                continue;
            end
            %符合条件的点，计算权值，与当前值比较后，考虑是否更新权值与反向指针
            newdata=sqrt((VMap(j,i).x-Start.x)*(VMap(j,i).x-Start.x)+(VMap(j,i).y-Start.y)*(VMap(j,i).y-Start.y))/V;
            if ComputedPoint(j,i)==0%当前点是第一次计算
                VMap(j,i).data=newdata+Start.data;%更新权值
                VMap(j,i).previous=Start;%反向指针指向起点
                NewComputedPoint(j,i)=1;
            else%当前点不是第一次计算，需比较大小
                if VMap(j,i).data>(newdata+Start.data)%新的权值比较小，则更新
                    VMap(j,i).data=newdata+Start.data;%更新权值!!!!!此处有问题，需要加上上一路径权值
                    VMap(j,i).previous=Start;%更新反向指针
                end
            end
            
        end
    end            
end