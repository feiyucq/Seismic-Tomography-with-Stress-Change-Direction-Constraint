function myans=reverseY(myjpg)%µßµ¹Í¼ÏñµÄ×Ý×ø±ê
    newMyJpg=uint8(zeros(size(myjpg)));
    mysize=size(myjpg);
    for i=1:1:mysize(1,1)
        newMyJpg(mysize(1,1)-i+1,:)=myjpg(i,:);
    end
    myans=newMyJpg;
end