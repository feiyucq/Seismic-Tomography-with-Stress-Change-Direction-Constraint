classdef rtnode < handle%��������׷�ٵĵ�ray trace node����������x���ꡢy���ꡢ��һ����ָ�롢����Ȩֵ
    properties
        x;%��ǰ��x����
        y;%��ǰ��y����
        previous;%��ǰ����һ��
        data;%��ǰ��Ȩֵ
        v;%��ǰ�㲨��
        p;%��ǰ���Ƿ��������׷�٣�����Ϊ1������Ϊ0
    end
    methods
        function mynode=rtnode(rtnodeex)
            if nargin==1
                mynode.x=rtnodeex.x;
                mynode.y=rtnodeex.y;
                mynode.previous=rtnodeex.previous;
                mynode.data=rtnodeex.data;
                mynode.v=rtnodeex.v;
                mynode.p=rtnodeex.p;
            else
                mynode.x=nan;
                mynode.y=nan;
                mynode.previous=nan;
                mynode.data=nan;
                mynode.v=nan;
                mynode.p=nan;
            end      
        end
    end
end