clc;
clear;

file{1,1} = 'data/USAir/training.txt';
file{1,2} = 'data/USAir/testing.txt';
file{1,3} = 'data/USAir/USAir_precision.txt';
file{1,4} = 'data/USAir/USAir_AUC.txt';
file{1,5} = 'data/USAir/reindex.txt';
file{1,6} = 'USAir';

file{2,1} = 'data/Yeast/training.txt';
file{2,2} = 'data/Yeast/testing.txt';
file{2,3} = 'data/Yeast/Yeast_precision.txt';
file{2,4} = 'data/Yeast/Yeast_AUC.txt';
file{2,5} = 'data/Yeast/reindex.txt';
file{2,6} = 'Yeast';

file{3,1} = 'data/Food/training.txt';
file{3,2} = 'data/Food/testing.txt';
file{3,3} = 'data/Food/Food_precision.txt';
file{3,4} = 'data/Food/Food_AUC.txt';
file{3,5} = 'data/Food/reindex.txt';
file{3,6} = 'Food';

file{4,1} = 'data/Power/training.txt';
file{4,2} = 'data/Power/testing.txt';
file{4,3} = 'data/Power/Jazz_precision.txt';
file{4,4} = 'data/Power/Jazz_AUC.txt';
file{4,5} = 'data/Power/reindex.txt';
file{4,6} = 'Power';

file{5,1} = 'data/metabolic/training.txt';
file{5,2} = 'data/metabolic/testing.txt';
file{5,3} = 'data/metabolic/metabolic_precision.txt';
file{5,4} = 'data/metabolic/metabolic_AUC.txt';
file{5,5} = 'data/metabolic/reindex.txt';
file{5,6} = 'metabolic';

file{6,1} = 'data/NS/training.txt';
file{6,2} = 'data/NS/testing.txt';
file{6,3} = 'data/NS/NS_precision.txt';
file{6,4} = 'data/NS/NS_AUC.txt';
file{6,5} = 'data/NS/reindex.txt';
file{6,6} = 'NS';

file{7,1} = 'data/Jazz/training.txt';
file{7,2} = 'data/Jazz/testing.txt';
file{7,3} = 'data/Jazz/Jazz_precision.txt';
file{7,4} = 'data/Jazz/Jazz_AUC.txt';
file{7,5} = 'data/Jazz/reindex.txt';
file{7,6} = 'Jazz';

file{8,1} = 'data/email/training.txt';
file{8,2} = 'data/email/testing.txt';
file{8,3} = 'data/email/email_precision.txt';
file{8,4} = 'data/email/email_AUC.txt';
file{8,5} = 'data/email/reindex.txt';
file{8,6} = 'email';

file{9,1} = 'data/Slavko/training.txt';
file{9,2} = 'data/Slavko/testing.txt';
file{9,3} = 'data/Slavko/Slavko_precision.txt';
file{9,4} = 'data/Slavko/Slavko_AUC.txt';
file{9,5} = 'data/Slavko/reindex.txt';
file{9,6} = 'Slavko';

file{10,1} = 'data/ucsocial/training.txt';
file{10,2} = 'data/ucsocial/testing.txt';
file{10,3} = 'data/ucsocial/ucsocial_precision.txt';
file{10,4} = 'data/ucsocial/ucsocial_AUC.txt';
file{10,5} = 'data/ucsocial/reindex.txt';
file{10,6} = 'ucsocial';

file{11,1} = 'data/Infec/training.txt';
file{11,2} = 'data/Infec/testing.txt';
file{11,3} = 'data/Infec/Infec_precision.txt';
file{11,4} = 'data/Infec/Infec_AUC.txt';
file{11,5} = 'data/Infec/reindex.txt';
file{11,6} = 'Infec';

file{12,1} = 'data/EuroSiS/training.txt';
file{12,2} = 'data/EuroSiS/testing.txt';
file{12,3} = 'data/EuroSiS/EuroSiS_precision.txt';
file{12,4} = 'data/EuroSiS/EuroSiS_AUC.txt';
file{12,5} = 'data/EuroSiS/reindex.txt';
file{12,6} = 'EuroSiS';

file{13,1} = 'data/CE/training.txt';
file{13,2} = 'data/CE/testing.txt';
file{13,3} = 'data/CE/CE_precision.txt';
file{13,4} = 'data/CE/CE_AUC.txt';
file{13,5} = 'data/CE/reindex.txt';
file{13,6} = 'CE';

file{14,6} = 'King Jame';
file{15,6} = 'CS phd';
file{16,6} = 'Geom';
file{17,6} = 'EVA';

% file{16,6} = 'Email-Enron';

% file{17,6} = 'Amazon';

degree_correlation=zeros(1,17)


 for index= 1:17
        %fid = fopen(['data/ 'file{index,6}同配性系数.txt'],'w+');
      
        training_set = load(['基本数据/data' num2str(1) '/' file{index,6} '/reindex.txt'],'-ascii');
        max_label = max(max(training_set))%maximmum node label
        
        [rows cols] =size(training_set);
        
        A_matrix = zeros(max_label,max_label);
        for row_index = 1:rows 
            A_matrix(training_set(row_index,1), training_set(row_index,2)) = 1;
            A_matrix(training_set(row_index,2), training_set(row_index,1)) = 1;
        end
        degree_correlation(1,index) =get_r(A_matrix)
 end

function [ r ] = get_r(A_matrix)
%该函数用来求网络的度-度相关性
%  当 r > 0 度-度正相关 assortativeness
%  当 r = 0 度-度没有相关 nonassortativeness
%  当 r < 0 度-度负相关 disassortativeness
% 输入参数是一个网络的邻接矩阵
%基于Pearson算法求
B = triu(A_matrix);
M = size(find(B==1),1);
sum1=0;
sum2=0;
sum3=0;
A1 = find(B==1);
length = size(A1,1);
for i=1:length
  
    [x y]=ind2sub(size(B),A1(i));
    sum1 = sum1+get_degree(A_matrix,x)*get_degree(A_matrix,y);
    sum2 = sum2+get_degree(A_matrix,x)+get_degree(A_matrix,y);
    sum3 = sum3+get_degree(A_matrix,x)^2+get_degree(A_matrix,y)^2;
end

x1 = sum1/M-(sum2/(2*M))^2;
y1 = sum3/(2*M)-(sum2/(2*M))^2;
r=x1/y1;
end


