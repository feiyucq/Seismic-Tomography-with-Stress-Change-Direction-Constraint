function Where=WhereAmI(Left,Right,Down,Up,StartX,StartY)%判断当前点在大格子的什么位置，送入的参数为矩阵下坐标，非实际坐标，返回值为[上 下 左 右]，表示当前点在不在本边线上，在为1，不在为0
    Where=[0 0 0 0];
    if (StartX>Left)&&(StartX<Right)%一定在上下线上一定不在左右线上
        if StartY==Up%在上线上
            Where(1,1)=1;
        elseif StartY==Down%在下线上
            Where(1,2)=1;
        else
            error('WhereAmI error 1!');
        end
    end
    if (StartY>Down)&&(StartY<Up)%一定在左右线上，一定不在上下线上
        if StartX==Left%在左线上
            Where(1,3)=1;
        elseif StartX==Right%在右线上
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