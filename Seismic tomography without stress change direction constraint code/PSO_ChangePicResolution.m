%PSOת��ͼƬ�ֱ��ʣ�ֻ֧�ֱַ�����ߣ���֧�ֽ���
clc;
clear all;
close all;
%��ת��ͼƬ
c_tupian='diceng_5_5.bmp';
%Ŀ��ֱ���
PicH=50;%Ŀ��ֱ�������
PicL=50;%Ŀ��ֱ�������
myjpg=imread(c_tupian);
sizemyjpg=size(myjpg);%sizemyjpg(1,1)�� sizemyjpg(1,2)��
LoopTimesH=0;
LoopTimesL=0;
if abs(PicH/sizemyjpg(1,1)-floor(PicH/sizemyjpg(1,1)))==0%Ŀ��ֱ��������зֱ��ʵ�������
    LoopTimesH=PicH/sizemyjpg(1,1);
else
    LoopTimesH=floor(PicH/sizemyjpg(1,1))+1;
end
if abs(PicL/sizemyjpg(1,2)-floor(PicL/sizemyjpg(1,2)))==0%Ŀ��ֱ��������зֱ��ʵ�������
    LoopTimesL=PicL/sizemyjpg(1,2);
else
    LoopTimesL=floor(PicL/sizemyjpg(1,2))+1;
end
tp=zeros(LoopTimesH*sizemyjpg(1,1),LoopTimesL*sizemyjpg(1,2));
tp=uint8(tp);
sizetp=size(tp);
for i=1:1:sizemyjpg(1,2)%��
    for j=1:1:sizemyjpg(1,1)%��
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
tppic=imread('tp.bmp');%����tp.bmp�Ժ����޸��ļ��������Ϸֱ���
figure(3);
image(tppic);







