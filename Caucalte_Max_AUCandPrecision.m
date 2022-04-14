% made by YB %
%计算一种模型数据集的最大precision和AUC 并与其他文件比较
clc;
clear;

%载入数据集
total_data=zeros(9,28);
for r = 2:15
    if (r == 2)
    total_data = load(['基本数据/1SRW_ME10为底部_var_average_result_walk=' num2str(2) ' .txt' ],'-ascii');
    else
    total_data = cat(2,total_data,load(['基本数据/1SRW_ME10为底部_var_average_result_walk=' num2str(r) ' .txt' ],'-ascii'));
    end
end

%分别获得AUC和precision
precision=zeros(9,14);
AUC=zeros(9,14);
for r = 1:14
  precision(:,r) = total_data(:,2*r-1);
  AUC(:,r) = total_data(:,2*r);
end
AUC=AUC.';
precision=precision.'

%得到最大AUC和precision和它们的列索引
% [PreMaxnum,PreQuene] = max(precision,[],2);
% [AUCMaxnum,AUCQuene] = max(total_data,[],2);


%如果想要把PreMaxnm/AUCMaxnum跟之前模型数据X矩阵比对 示例
%输出逻辑矩阵 满足条件位置为1
%X = load(['文件名'],'-ascii');
%L = logical(PreMaxnum>=X);
%找到为1的位置 只输出行数
%[BiggerLine,~] = find(L);
    