function NewComputedPoint=CompNode(ComputedPoint,SelectedPoints,Left,Right,Up,Down,V,Start,VMap)%������㵽Left��Right��Up��Down�涨�ķ�Χ�ڵ��Ȩֵ�����£�L R U DΪС�������꣬VΪ���ڼ�����ٶ�
    NewComputedPoint=ComputedPoint;
    for i=Left:1:Right%iΪ�����꣬��Ӧ�б�
        for j=Down:1:Up%jΪ�����꣬��Ӧ�б�
            if (VMap(j,i).x==Start.x)&&(VMap(j,i).y==Start.y)%������غϣ�������
                continue;
            end
            %����㲻�غϣ������Ǳ߿��ϵĵ㣬���������
            if VMap(j,i).p==0
                continue;
            end
            %�Ǳ߿��ϵ㣬������㲻�غϣ���������ѡ�㼯
            if SelectedPoints(j,i)==1
                continue;
            end
            %���������ĵ㣬����Ȩֵ���뵱ǰֵ�ȽϺ󣬿����Ƿ����Ȩֵ�뷴��ָ��
            newdata=sqrt((VMap(j,i).x-Start.x)*(VMap(j,i).x-Start.x)+(VMap(j,i).y-Start.y)*(VMap(j,i).y-Start.y))/V;
            if ComputedPoint(j,i)==0%��ǰ���ǵ�һ�μ���
                VMap(j,i).data=newdata+Start.data;%����Ȩֵ
                VMap(j,i).previous=Start;%����ָ��ָ�����
                NewComputedPoint(j,i)=1;
            else%��ǰ�㲻�ǵ�һ�μ��㣬��Ƚϴ�С
                if VMap(j,i).data>(newdata+Start.data)%�µ�Ȩֵ�Ƚ�С�������
                    VMap(j,i).data=newdata+Start.data;%����Ȩֵ!!!!!�˴������⣬��Ҫ������һ·��Ȩֵ
                    VMap(j,i).previous=Start;%���·���ָ��
                end
            end
            
        end
    end            
end