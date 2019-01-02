function myans=d2b(D)%将十进制向量转换为二进制向量，D为十进制值范围0~255整数,1*N向量
    Dsize=size(D);
    myans=zeros(1,Dsize(1,2)*8);
    for i=1:1:Dsize(1,2)
        mystring1='00000000';
        mystring=dec2bin(D(1,i));%获得十进制到二进制的转换
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