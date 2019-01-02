% % 遗传算法进行震源反演，未知平均速度,目标函数
function test_ans = GA_hanshuzhi(c_pic_hang,c_pic_lie,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_Map,TheoArrTime)%c_Map为待计算的速度分布，TheoArrTime为实测到时
   
    c_Map_size=size(c_Map);
    NofIndividual=c_Map_size(1,1);%种群中个体个数
    TheoArrTime_size=size(TheoArrTime);
    %取出c_Map中内容，生成速度分布，根据TheoArrTime中震源坐标和检波器坐标计算理论到时，将理论到时与实测到时的2范数作为每个个体的返回值送出
    test_ans=zeros(NofIndividual,1);   
    for i=1:1:NofIndividual%parfor
        
        k=1;
        c_pic=zeros(c_pic_hang,c_pic_lie);
        %将个体内容转换为图片
        for m=1:1:c_pic_hang
            for n=1:1:c_pic_lie
                c_pic(m,n)=c_Map(i,k);
                k=k+1;
            end
        end
        c_pic=uint8(c_pic);%格式转换
        %TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)
        RealArrTime=zeros(1,TheoArrTime_size(1,2));
        %tic;
        parfor NofArr=1:1:TheoArrTime_size(1,2)%进行并行for循环 parfor
            tic;
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            toc;
        end
        %toc;
        mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%计算2范数
        test_ans(i,1)=sqrt(sum(mytemp));
    end
    
end