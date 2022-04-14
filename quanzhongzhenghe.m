clc;
clear;

%载入数据集
total_data=zeros(1,11);
for k = 0:0.01:0.1
    if (k== 0)
    total_data = load(['data/EMAIL core权重=' num2str(0) ' .txt' ],'-ascii');
    else
    total_data = cat(2,total_data,load(['data/EMAIL core权重=' num2str(k) ' .txt' ],'-ascii'));
    end
end

%分别获得AUC和precision
precision=zeros(1,11);
AUC=zeros(1,11);
for r= 1:11
  precision(:,r) = total_data(:,2*r-1);
  AUC(:,r) = total_data(:,2*r);
end
AUC=AUC.';
precision=precision.'


    