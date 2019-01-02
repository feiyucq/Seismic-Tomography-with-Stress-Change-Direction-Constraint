classdef rtnode < handle%用于射线追踪的点ray trace node，包含本点x坐标、y坐标、上一个点指针、本点权值
    properties
        x;%当前点x坐标
        y;%当前点y坐标
        previous;%当前点上一点
        data;%当前点权值
        v;%当前点波速
        p;%当前点是否参与射线追踪，参与为1，否则为0
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