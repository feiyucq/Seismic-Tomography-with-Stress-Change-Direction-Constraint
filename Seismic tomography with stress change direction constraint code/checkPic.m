% 检查两幅图片的大小关系是否正确
function myans=checkPic(x)
    sizeOfX=size(x);
    if sizeOfX(1,1)~=1
        error('sizeOfX(1,1)~=1');
    end
    x1=x(1,1:(sizeOfX(1,2)/2));%获得第一幅图片信息
    x2=x(1,(sizeOfX(1,2)/2+1):sizeOfX(1,2));%获得第二幅图片信息
    pic1=PSO_FFTtoPic(x1);
    pic2=PSO_FFTtoPic(x2);
    v1=[pic1(10,27) pic1(10,28) pic1(10,29) pic1(10,30) pic1(10,31) pic1(10,32) pic1(10,33) pic1(10,34) pic1(10,35) pic1(10,36) pic1(10,37) pic1(10,38) pic1(10,39) pic1(10,40) pic1(11,27) pic1(11,28) pic1(11,29) pic1(11,30) pic1(11,31) pic1(11,32) pic1(11,33) pic1(11,34) pic1(11,35) pic1(11,36) pic1(11,37) pic1(11,38) pic1(11,39) pic1(11,40)];
    v2=[pic2(10,27) pic2(10,28) pic2(10,29) pic2(10,30) pic2(10,31) pic2(10,32) pic2(10,33) pic2(10,34) pic2(10,35) pic2(10,36) pic2(10,37) pic2(10,38) pic2(10,39) pic2(10,40) pic2(11,27) pic2(11,28) pic2(11,29) pic2(11,30) pic2(11,31) pic2(11,32) pic2(11,33) pic2(11,34) pic2(11,35) pic2(11,36) pic2(11,37) pic2(11,38) pic2(11,39) pic2(11,40)];
  %     v1应该大于v2
    sizeOfv1=size(v2);
    for i=1:1:sizeOfv1(1,2)
        if(v1(1,i)<v2(1,i))
            break;
        end
    end
    if(i==sizeOfv1(1,2))
        myans=1;
    else
        myans=0;
    end
    
end