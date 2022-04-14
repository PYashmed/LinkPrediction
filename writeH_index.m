file{1,1} = '/USAir/training.txt';
file{1,2} = '/USAir/testing.txt';
file{1,3} = '/USAir/reindex.txt';
file{1,4} = 'USAir';

file{2,1} = '/Yeast/training.txt';
file{2,2} = '/Yeast/testing.txt';
file{2,3} = '/Yeast/reindex.txt';
file{2,4} = 'Yeast';

file{3,1} = '/Food/training.txt';
file{3,2} = '/Food/testing.txt';
file{3,3} = '/Food/reindex.txt';
file{3,4} = 'Food';

file{4,1} = '/Power/training.txt';
file{4,2} = '/Power/testing.txt';
file{4,3} = '/Power/reindex.txt';
file{4,4} = 'Power';

file{5,1} = '/metabolic/training.txt';
file{5,2} = '/metabolic/testing.txt';
file{5,3} = '/metabolic/reindex.txt';
file{5,4} = 'metabolic';

file{6,1} = '/NS/training.txt';
file{6,2} = '/NS/testing.txt';
file{6,3} = '/NS/reindex.txt';
file{6,4} = 'NS';

file{7,1} = '/Jazz/training.txt';
file{7,2} = '/Jazz/testing.txt';
file{7,3} = '/Jazz/reindex.txt';
file{7,4} = 'Jazz';

file{8,1} = '/email/training.txt';
file{8,2} = '/email/testing.txt';
file{8,3} = '/email/reindex.txt';
file{8,4} = 'email';

file{9,1} = '/Slavko/training.txt';
file{9,2} = '/Slavko/testing.txt';
file{9,3} = '/Slavko/reindex.txt';
file{9,4} = 'Slavko';

file{10,1} = '/ucsocial/training.txt';
file{10,2} = '/ucsocial/testing.txt';
file{10,3} = '/ucsocial/reindex.txt';
file{10,4} = 'ucsocial';

file{11,1} = '/Infec/training.txt';
file{11,2} = '/Infec/testing.txt';
file{11,3} = '/Infec/reindex.txt';
file{11,4} = 'Infec';

file{12,1} = '/EuroSiS/training.txt';
file{12,2} = '/EuroSiS/testing.txt';
file{12,3} = '/EuroSiS/reindex.txt';
file{12,4} = 'EuroSiS';

file{13,1} = '/CE/training.txt';
file{13,2} = '/CE/testing.txt';
file{13,3} = '/CE/reindex.txt';
file{13,4} = 'CE';

file{14,1} = '/Router/training.txt';
file{14,2} = '/Router/testing.txt';
file{14,3} = '/Router/reindex.txt';
file{14,4} = 'Router';

file{15,1} = '/King Jame/training.txt';
file{15,2} = '/King Jame/testing.txt';
file{15,3} = '/King Jame/reindex.txt';
file{15,4} = 'King Jame';
for foler_index=1:30
    for index=1:15
        fid = fopen(['基本数据/data' num2str(foler_index) '/' file{index,4} '/H_index.txt'],'w+');
 

training_set = load(['基本数据/data' num2str(foler_index) '/' file{index,4} '/training.txt'],'-ascii');
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
base = repmat(sum( A_matrix),max_label,1);%节点度矩阵
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
% H=repmat(kk,max_label,1);
% M=H';
% N=H.';
% E=mean(kk);
% b=mean(kk.^2)-E^2;
% L=b/(mean(kk)^2)+1;

 for i=1:max_label
     fprintf(fid, '%d\t',kk(i));
     fprintf(fid, '\r\n');
 end
 fclose(fid);
    end
end

clear 