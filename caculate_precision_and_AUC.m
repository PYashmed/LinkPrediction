%评价链路预测算法的2个指标：precision(精确度) AUC
function [precisoin, AUC, hit, RMSE] = caculate_precision_and_AUC(degree_matrix,test_line_matrix,L,exist_lines)
%CACULATE_PRECISION_AND_AUC Summary of this function goes
%here，这个函数叫caculate_precision_and_AUC,就是计算准确度和AUC的函数。四个参数分别是(度矩阵，测试矩阵，连着的边(简称连边))
%   Detailed explanation goes here

total = degree_matrix;
clear degree_matrix close_matrix between_matrix;
total = triu(total,0);%triu函数是matlab中提取矩阵上三角矩阵的函数。triu(X)产生X矩阵的上三角矩阵，其余元素补0
[n_row, ~] = size(total);
non_zeros = sum(sum(total>0));%sum(x)是竖向相加，求每列的和，结果是行向量  non_zeros=total中所有数的和，即得到的相似性的总和
line_count = (n_row*(n_row-1))/2;%最大可能连边数（n个点能组成n*(n-1)/2条边）
line_count = line_count - non_zeros-exist_lines;%为什么减去相似性的总和？？
%{
这段中有三个变量：1、total是degree_matrix的上三角矩阵 2、non_aeros是total所有元素总和
3、line_count是和最大连边数有关的东西
%}

pred_matrix = total;         %预测矩阵
test_value_array = [];
[m , ~] = size(test_line_matrix);  %m、n分别为测试集的行、列
[~, pos_degree] =  sort(total(:),'descend');%sort(A)若A是向量不管是列还是行向量，默认都是对A进行升序排列。sort(A)是默认的升序，而sort(A,'descend')是降序排序。 
                                                   %pos_degree是每个数值对应的位置。L_degree是按照降序后排列的数组 
total(pos_degree(L+1:end)) = 0; %total矩阵中只保留前L个最大的数，其余全部置为零。
correct_number = 0;
%{
这段中有三个变量：1、pred_matrix和total一致 2、m,n为测试集行列数
3、total矩阵中保留前L最大的数，其余置零
%}

for index3 = 1:m   
   coordinate = test_line_matrix(index3,:);% coordinate每次循环中均表示测试集中的某一行，即得到测试集中连边的两个端点
   test_value_array = [test_value_array,pred_matrix(coordinate(1),coordinate(2))];%pred_matrix(coordinate(1),coordinate(2)表示测试集中连边在相似性矩阵中对应的相似性。此步什么意思？？
   pred_matrix(coordinate(1),coordinate(2))=-1;
   if total(coordinate(1),coordinate(2)) ~= 0 %判断测试集中的连边是否预测出来，有相似性值，预测出了correct_number加1，correct_number最后为测试集中所有连边被预测出来的条数
       correct_number =correct_number +1;
   end
end

precisoin = correct_number/L;  %输出值1，叫做精确率(a/a+c),就是所有预测为正的当中正确的比例
hit = correct_number/m;        %参数3
pred_array = pred_matrix(pred_matrix>0);
pred_array = [pred_array;zeros(line_count, 1)];%？？？
clear pred_matrix total coordinate correct_number;

total_count = 1000000;
%n_bigger = 0;  这两个是因为提示没用到所以注释掉
%n_equal = 0;
cols_of_test = length(test_value_array);
cols_of_pred = length(pred_array);

%下面为计算AUC的过程
 value_test = test_value_array(randi(cols_of_test,1,total_count));%每次随机从测试集中抽取一条连边，共抽取10万次
 value_pred = pred_array(randi(cols_of_pred,1,total_count));%随机从原先无连边集合中抽取一条连边
 n_bigger = sum(value_test>value_pred.');%统计来自测试集的连边可能性大于来自E-的连边的总数
 n_equal = sum(value_test==value_pred.');%统计两者相等的总数

AUC = (n_bigger+0.5*n_equal)/total_count;    %参数2
% disp(['precision锟斤拷:' num2str(precisoin) ',AUC锟斤拷:' num2str(AUC)]);


%下面为计算RMSE的过程
average_value = sum(test_value_array)/length(test_value_array);
normalized_test_value = test_value_array./average_value;

RMSE_1 = (normalized_test_value - 1).*(normalized_test_value - 1);
RMSE  = sqrt((sum(RMSE_1))/length(test_value_array));   %参数4



% signal_vector = (test_value_array - average_value).*(test_value_array - average_value);
% signal = sum(signal_vector)/length(signal_vector);
% t0 = 0;
% t1 = 1;
% 
% t = 0;
% 
% while signal>1
%     s1_vector = (test_value_array - t0).*(test_value_array - t0);
%     s1 = sum(s1_vector)/length(s1_vector);
%     s2_vector = (test_value_array - t1).*(test_value_array - t1);
%     s2 = sum(s2_vector)/length(s2_vector);
%     if s1>=s2
%         t0 = (t0+t1)/2
%         signal = s2;
%     else
%         t1 = (t0+t1)/2;
%         signal = s1;
%     end  
%  t = t+1  ; 
% end
% RMSE = sqrt(signal);

clear test_value_array pred_array cols_of_test cols_of_pred;
end

