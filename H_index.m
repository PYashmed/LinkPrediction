clear;
clc;
%coefficient of weak tie
L = 100;
%% 记录下数据文件的目录地址
%相关文件
file{1,1} = 'data/test/training.txt';
file{1,2} = 'data/Yeast/testing.txt';
file{1,3} = 'data/Yeast/Yeast_precision.txt';
file{1,4} = 'data/Yeast/Yeast_AUC.txt';
file{1,5} = 'data/Yeast/reindex.txt';
file{1,6} = 'Yeast';

folder_id = fopen(['data/H_indexceshi .txt'],'w+');
 
% training_set = load(file{1,1},'-ascii');
training_set = load(['data/data' num2str(1) '/' file{1,6} '/training.txt'],'-ascii');
max_label = max(max(training_set))

k=zeros(1,max_label);
kk=zeros(1,max_label);

[rows, cols] =size(training_set);
training_set(:,3) = 1;%在训练集中补一列1（方便转换为稀疏矩阵）
A_matrix = spconvert(training_set);%将训练集中数据转换为稀疏矩阵形式
clear training_set
%get full matrix
A_matrix = full(A_matrix);%将稀疏矩阵转换为全矩阵
A_matrix(max_label,max_label)=0;%将矩阵最后一个数字置为0
A_matrix = A_matrix+A_matrix.';%补全连线关系，将上三角矩阵对称
%set elements on diagonal line as 0
A_matrix = A_matrix-diag(diag(A_matrix));
base = repmat(sum( A_matrix),1,max_label);%节点度矩阵
ki= A_matrix.*base;
%for i=1:max_label
%    for j=1:max_label
%        fprintf(folder_id, '%d\t',ki(i,j));
%    end
%    fprintf(folder_id, '\r\n');
%end
    
for i=1:max_label
     for m=1:max_label
          for j=1:max_label
              if ki(i,j)>=m
                 k(i)=k(i)+1;
              end
          end
          if k(i)>=m
             kk(i)=m;
          end
          k(i)=0;
     end 
end
H=repmat(kk,max_label,1);
M=H';
N=H.';
E=mean(kk);
b=mean(kk.^2)-E^2;
L=b/(mean(kk)^2)+1;

 for i=1:max_label
     fprintf(folder_id, '%d\t',kk(i));
     fprintf(folder_id, '\r\n');
 end
 fclose(folder_id);
clear 





