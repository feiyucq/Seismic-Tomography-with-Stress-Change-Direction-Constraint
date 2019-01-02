%计算trace的全局最优斜率，考查变化情况
close all;
clear all;
% load('trace-2018.2.1.11点-80个体-83代-增加时间约束-限制上下限.mat');
load('trace.mat');
newTrace=trace;
load('trace-80个体-未加任何约束.mat');
noConsTrace=trace;
sizeOfNewTrace=size(newTrace);%此处，那个mat维数小就填哪个
newTraceGlobalBest=newTrace(sizeOfNewTrace(1,2)).fGlobalBest;
noConsTraceGlobalBest=noConsTrace(sizeOfNewTrace(1,2)).fGlobalBest;
rateOfNewTraceGlobalBest=zeros(sizeOfNewTrace(1,2)-1,1);
rateOfNoConsTraceGlobalBest=zeros(sizeOfNewTrace(1,2)-1,1);
for i=1:1:sizeOfNewTrace(1,2)-1
    rateOfNewTraceGlobalBest(i,1)=abs(newTraceGlobalBest(i+1,1)-newTraceGlobalBest(i,1));
    rateOfNoConsTraceGlobalBest(i,1)=abs(noConsTraceGlobalBest(i+1,1)-noConsTraceGlobalBest(i,1));
end
close all;
figure(1);
plot(rateOfNewTraceGlobalBest,'-g*');
hold on;
plot(rateOfNoConsTraceGlobalBest,'-r+');
legend('rateOfNewTraceGlobalBest','rateOfNoConsTraceGlobalBest');
meanRateOfNewTraceGlobalBest=mean(rateOfNewTraceGlobalBest)
meanRateOfNoConsTraceGlobalBest=mean(rateOfNoConsTraceGlobalBest)