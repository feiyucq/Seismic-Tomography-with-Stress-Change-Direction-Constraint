function myans=d2b(D)%��ʮ��������ת��Ϊ������������DΪʮ����ֵ��Χ0~255����,1*N����
    Dsize=size(D);
    myans=zeros(1,Dsize(1,2)*8);
    for i=1:1:Dsize(1,2)
        mystring1='00000000';
        mystring=dec2bin(D(1,i));%���ʮ���Ƶ������Ƶ�ת��
        mystringsize=size(mystring);
        k=8;
        
        for j=mystringsize(1,2):-1:1
            if mystring(1,j)=='1'
                mystring1(1,k)='1';
            end
            k=k-1;
        end
        mystring=mystring1;
        mystringsize=size(mystring);
        for j=1:1:mystringsize(1,2)
            ansindex=(i-1)*8+j;
            if mystring(1,j)=='1'
                myans(1,ansindex)=1;
            end
        end
    end
end