%����trace��ȫ������б�ʣ�����仯���
close all;
clear all;
% load('trace-2018.2.1.11��-80����-83��-����ʱ��Լ��-����������.mat');
load('trace.mat');
newTrace=trace;
load('trace-80����-δ���κ�Լ��.mat');
noConsTrace=trace;
sizeOfNewTrace=size(newTrace);%�˴����Ǹ�matά��С�����ĸ�
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