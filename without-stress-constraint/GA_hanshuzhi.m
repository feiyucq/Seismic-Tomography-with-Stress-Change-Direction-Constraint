% % �Ŵ��㷨������Դ���ݣ�δ֪ƽ���ٶ�,Ŀ�꺯��
function test_ans = GA_hanshuzhi(c_pic_hang,c_pic_lie,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_Map,TheoArrTime)%c_MapΪ��������ٶȷֲ���TheoArrTimeΪʵ�⵽ʱ
   
    c_Map_size=size(c_Map);
    NofIndividual=c_Map_size(1,1);%��Ⱥ�и������
    TheoArrTime_size=size(TheoArrTime);
    %ȡ��c_Map�����ݣ������ٶȷֲ�������TheoArrTime����Դ����ͼ첨������������۵�ʱ�������۵�ʱ��ʵ�⵽ʱ��2������Ϊÿ������ķ���ֵ�ͳ�
    test_ans=zeros(NofIndividual,1);   
    for i=1:1:NofIndividual%parfor
        
        k=1;
        c_pic=zeros(c_pic_hang,c_pic_lie);
        %����������ת��ΪͼƬ
        for m=1:1:c_pic_hang
            for n=1:1:c_pic_lie
                c_pic(m,n)=c_Map(i,k);
                k=k+1;
            end
        end
        c_pic=uint8(c_pic);%��ʽת��
        %TravalTime=RayTrace2(myjpg,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,c_StartX,c_StartY,c_EndX,c_EndY)
        RealArrTime=zeros(1,TheoArrTime_size(1,2));
        %tic;
        parfor NofArr=1:1:TheoArrTime_size(1,2)%���в���forѭ�� parfor
            tic;
            RealArrTime(1,NofArr)=RayTrace2(c_pic,c_StartV,c_EndV,c_RealXLength,c_RealYLength,c_NofPoints,TheoArrTime(1,NofArr),TheoArrTime(2,NofArr),TheoArrTime(3,NofArr),TheoArrTime(4,NofArr));
            toc;
        end
        %toc;
        mytemp=(RealArrTime(1,:)-TheoArrTime(5,:)).*(RealArrTime(1,:)-TheoArrTime(5,:));%����2����
        test_ans(i,1)=sqrt(sum(mytemp));
    end
    
end