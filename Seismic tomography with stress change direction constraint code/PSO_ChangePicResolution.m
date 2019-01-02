%PSO转换图片分辨率，只支持分辨率提高，不支持降低
clc;
clear all;
close all;
%待转换图片
c_tupian='diceng_5_5.bmp';
%目标分辨率
PicH=50;%目标分辨率行数
PicL=50;%目标分辨率列数
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);%sizemyjpg(1,1)行 sizemyjpg(1,2)列
LoopTimesH=0;
LoopTimesL=0;
if abs(PicH/sizemyjpg(1,1)-floor(PicH/sizemyjpg(1,1)))==0%目标分辨率是现有分辨率的整数倍
    LoopTimesH=PicH/sizemyjpg(1,1);
else
    LoopTimesH=floor(PicH/sizemyjpg(1,1))+1;
end
if abs(PicL/sizemyjpg(1,2)-floor(PicL/sizemyjpg(1,2)))==0%目标分辨率是现有分辨率的整数倍
    LoopTimesL=PicL/sizemyjpg(1,2);
else
    LoopTimesL=floor(PicL/sizemyjpg(1,2))+1;
end
tp=zeros(LoopTimesH*sizemyjpg(1,1),LoopTimesL*sizemyjpg(1,2));
tp=uint8(tp);
sizetp=size(tp);
for i=1:1:sizemyjpg(1,2)%列
    for j=1:1:sizemyjpg(1,1)%行
        tphu=j*LoopTimesH;
        tphl=tphu-(LoopTimesH-1);
        tplu=i*LoopTimesL;
        tpll=tplu-(LoopTimesL-1);
        for h=tphl:1:tphu
            for l=tpll:1:tplu
                tp(h,l)=myjpg(j,i);
            end
        end
        
    end
end
figure(1);
image(myjpg);
figure(2);
image(tp);
imwrite(tp,'tp.bmp','bmp');
tppic=imread('tp.bmp');%生成tp.bmp以后需修改文件名，带上分辨率
figure(3);
image(tppic);







