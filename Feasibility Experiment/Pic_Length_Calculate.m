%����ͼƬ��ľ��룬�������۷��ݽ��������ֵ֮��Ľӽ��̶�
clc;
clear all;
close all;
load('trace.mat')
xGlobalBestSize=size(trace(1,1).xGlobalBest);
xGlobalBestSizeY=xGlobalBestSize(1,2);

xBest1=trace(1,1).xGlobalBest(1,1:(xGlobalBestSizeY/2));
xBest2=trace(1,1).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
pic1_generation_1=double(reverseY(PSO_FFTtoPic(xBest1)));
pic2_generation_1=double(reverseY(PSO_FFTtoPic(xBest2)));

xBest1=trace(1,10).xGlobalBest(1,1:(xGlobalBestSizeY/2));
xBest2=trace(1,10).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
pic1_generation_10=double(reverseY(PSO_FFTtoPic(xBest1)));
pic2_generation_10=double(reverseY(PSO_FFTtoPic(xBest2)));

xBest1=trace(1,20).xGlobalBest(1,1:(xGlobalBestSizeY/2));
xBest2=trace(1,20).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
pic1_generation_20=double(reverseY(PSO_FFTtoPic(xBest1)));
pic2_generation_20=double(reverseY(PSO_FFTtoPic(xBest2)));

xBest1=trace(1,30).xGlobalBest(1,1:(xGlobalBestSizeY/2));
xBest2=trace(1,30).xGlobalBest(1,((xGlobalBestSizeY/2)+1):xGlobalBestSizeY);
pic1_generation_30=double(reverseY(PSO_FFTtoPic(xBest1)));
pic2_generation_30=double(reverseY(PSO_FFTtoPic(xBest2)));

real_pic1=double(reverseY(imread('diceng_50_50.bmp')));
real_pic2=double(reverseY(imread('diceng_50_50_2.bmp')));

load('cutimag_50_50_9unknow.mat')
cut_fft_pic1=double(reverseY(newimag));
load('cutimag_50_50__2_9unknow.mat')
cut_fft_pic2=double(reverseY(newimag));

%��ͨ�˲�����ԭͼ���norm
vector_cut_fft_pic1=cut_fft_pic1(:);
vector_cut_fft_pic2=cut_fft_pic2(:);
vector_cut_fft_pic=[vector_cut_fft_pic1;vector_cut_fft_pic2];

vector_form_pic1=real_pic1(:);
vector_form_pic2=real_pic2(:);
vector_form_pic=[vector_form_pic1;vector_form_pic2];

ans_cut_to_form=norm(vector_cut_fft_pic-vector_form_pic,2);

%��1�����ݽ����ԭͼ��
vector_pic1_generation1=pic1_generation_1(:);
vector_pic2_generation1=pic2_generation_1(:);
vector_pic_generation1=[vector_pic1_generation1;vector_pic2_generation1];
ans_gen1_to_form=norm((vector_pic_generation1-vector_form_pic),2);
%��1�����ݽ�����˲���ͼ��
ans_gen1_to_cut=norm(vector_pic_generation1-vector_cut_fft_pic,2);

%��10�����ݽ����ԭͼ��
vector_pic1_generation10=pic1_generation_10(:);
vector_pic2_generation10=pic2_generation_10(:);
vector_pic_generation10=[vector_pic1_generation10;vector_pic2_generation10];
ans_gen10_to_form=norm(vector_pic_generation10-vector_form_pic,2);
%��10�����ݽ�����˲���ͼ��
ans_gen10_to_cut=norm(vector_pic_generation10-vector_cut_fft_pic,2);

%��20�����ݽ����ԭͼ��
vector_pic1_generation20=pic1_generation_20(:);
vector_pic2_generation20=pic2_generation_20(:);
vector_pic_generation20=[vector_pic1_generation20;vector_pic2_generation20];
ans_gen20_to_form=norm(vector_pic_generation20-vector_form_pic,2);
%��20�����ݽ�����˲���ͼ��
ans_gen20_to_cut=norm(vector_pic_generation20-vector_cut_fft_pic,2);

%��30�����ݽ����ԭͼ��
vector_pic1_generation30=pic1_generation_30(:);
vector_pic2_generation30=pic2_generation_30(:);
vector_pic_generation30=[vector_pic1_generation30;vector_pic2_generation30];
ans_gen30_to_form=norm(vector_pic_generation30-vector_form_pic,2);
%��30�����ݽ�����˲���ͼ��
ans_gen30_to_cut=norm(vector_pic_generation30-vector_cut_fft_pic,2);

result=[ans_cut_to_form 0 0 0;ans_gen1_to_form ans_gen10_to_form ans_gen20_to_form ans_gen30_to_form ;ans_gen1_to_cut ans_gen10_to_cut ans_gen20_to_cut ans_gen30_to_cut];
