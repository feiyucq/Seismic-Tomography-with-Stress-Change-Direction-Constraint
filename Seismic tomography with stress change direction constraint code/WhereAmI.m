function Where=WhereAmI(Left,Right,Down,Up,StartX,StartY)%�жϵ�ǰ���ڴ���ӵ�ʲôλ�ã�����Ĳ���Ϊ���������꣬��ʵ�����꣬����ֵΪ[�� �� �� ��]����ʾ��ǰ���ڲ��ڱ������ϣ���Ϊ1������Ϊ0
    Where=[0 0 0 0];
    if (StartX>Left)&&(StartX<Right)%һ������������һ��������������
        if StartY==Up%��������
            Where(1,1)=1;
        elseif StartY==Down%��������
            Where(1,2)=1;
        else
            error('WhereAmI error 1!');
        end
    end
    if (StartY>Down)&&(StartY<Up)%һ�����������ϣ�һ��������������
        if StartX==Left%��������
            Where(1,3)=1;
        elseif StartX==Right%��������
            Where(1,4)=1;
        else
            error('WhereAmI error 2!');
        end
    end
    if (StartX==Left)&&(StartY==Down)
        Where(1,2)=1;
        Where(1,3)=1;
    elseif (StartX==Left)&&(StartY==Up)
        Where(1,1)=1;
        Where(1,3)=1;
    elseif (StartX==Right)&&(StartY==Down)
        Where(1,2)=1;
        Where(1,4)=1;
    elseif (StartX==Right)&&(StartY==Up)
        Where(1,1)=1;
        Where(1,4)=1;
    end        
end