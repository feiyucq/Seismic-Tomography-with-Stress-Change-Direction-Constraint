%将频谱转换为图像
function mypic=PSO_FFTtoPic(fftmatrix)%传入参数为一组模和幅角，格式[x1.mod x1.ang x2.mod x2.ang.....]，需要将其填充到图片频谱的确定位置
    c_tupian='diceng_50_50.bmp';
    myjpg=imread(c_tupian);
    sizemyjpg=size(myjpg);%获得图片矩阵和fft矩阵大小
    newfftmx=zeros(sizemyjpg(1,1),sizemyjpg(1,2));
    
    fftmxsize=size(fftmatrix);
    if (fftmxsize(1,2)/2)~=5
        error('PSO_FFTtoPic error!');
    end
    newtemp=zeros(2,fftmxsize(1,2)/2);
    for j=1:1:(fftmxsize(1,2)/2)
        ang=fftmatrix(1,j*2);%取幅角
        mo=fftmatrix(1,j*2-1);%取模
        ang=ang*pi/180;%角度转为弧度
        %规定fftmatrix中参数排列顺序对应为[x1.mod x1.ang x2.mod x2.ang x3.mod x3.ang x4.mod x4.ang x5.mod x5.ang]
        %[(25,25) (26,25) (25,26) (26,26) (25,27)]
        myreal=mo*cos(ang);
        myinscriber=mo*sin(ang)*1i;
        newtemp(1,j)=myreal+myinscriber;%第一行放正
        newtemp(2,j)=myreal-myinscriber;%第二行放共轭复数
    end
    %获得fft矩阵
    newfftmx(25,25)=newtemp(1,1);
    newfftmx(25,26)=newtemp(1,2);
    newfftmx(27,25)=newtemp(2,5);
    newfftmx(26,25)=newtemp(1,3);
    newfftmx(26,26)=newtemp(1,4);
    newfftmx(26,27)=newtemp(2,3);
    newfftmx(25,27)=newtemp(1,5);
    newfftmx(27,26)=newtemp(2,2);
    newfftmx(27,27)=newtemp(2,1);
    %获得对应的图像
    newimag=uint8(real(ifft2(ifftshift(newfftmx))));
    mypic=newimag;
    
    
    
    
end