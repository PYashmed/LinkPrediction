%RA 指标：该指标的思想为资源分配，有点类似AA
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
file{4,3} = 'data/Power/Power_precision.txt';
file{4,4} = 'data/Power/Power_AUC.txt';
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
file{14,1} = 'data/Router/training.txt';
file{14,2} = 'data/Router/testing.txt';
file{14,3} = 'data/Router/Router_precision.txt';
file{14,4} = 'data/Router/Router_AUC.txt';
file{14,5} = 'data/Router/reindex.txt';
file{14,6} = 'Router';

file{15,1} = 'data/King Jame/training.txt';
file{15,2} = 'data/King Jame/testing.txt';
file{15,3} = 'data/King Jame/King Jame_precision.txt';
file{15,4} = 'data/King Jame/King Jame_AUC.txt';
file{15,5} = 'data/King Jame/reindex.txt';
file{15,6} = 'King Jame';
L=100;

precision_matrix = cell(1,13);
AUC_matrix = cell(1,13);
hit_matrix = cell(1,13);

folder_id = fopen('data/RA论文2_100_average_var_result.txt','w+');
for foler_index=1:30
    for data_index=1:13
       disp(file{data_index,1});
       fid = fopen(['data/data' num2str(foler_index) '/' file{data_index,6} '/RA_50_result.txt'],'w+');
       r_reindex = asstcoe(['data/data' num2str(foler_index) '/' file{data_index,6} '/reindex.txt']);
       r_train = asstcoe(['data/data' num2str(foler_index) '/' file{data_index,6} '/training.txt']);
       fprintf(fid, '%s\n', ['r_reindex:' num2str(r_reindex)]);
       fprintf(fid, '%s\n', ['r_train:' num2str(r_train)]);
       total_data = load(['data/data' num2str(foler_index) '/' file{data_index,6} '/reindex.txt'],'-ascii');
       total_max_label = max(max(total_data));
       fprintf(fid, '%s\n', ['total_max_node_label:' num2str(total_max_label)]);
       [t_rows,t_cols] = size(total_data);
       fprintf(fid, 'total_rows=%d, total_cols=%d\n', t_rows, t_cols);
       clear total_data
	   
       training_set = load(['data/data' num2str(foler_index) '/' file{data_index,6} '/training.txt'],'-ascii');
       max_label = max(max(training_set));
       test_set = load(['data/data' num2str(foler_index) '/' file{data_index,6} '/testing.txt'],'-ascii');
       fprintf(fid, '%s\n', ['training_max_node_label:' num2str(max_label)]);
       [rows,cols] =size(training_set);
       fprintf(fid, 'training_rows=%d, training_cols=%d\n', rows, cols);
       training_set(:,3) = 1;
       A_matrix = spconvert(training_set);
       clear training_set
       A_matrix(max_label,max_label)=0;
       %get full matrix
       A_matrix = full(A_matrix);
       A_matrix = A_matrix+A_matrix.';
       %set elements on diagonal line as 0
       A_matrix = A_matrix-diag(diag(A_matrix));%得到标准邻接矩阵
       %get row degrees vector
       base = repmat(sum(A_matrix),max_label,1);%得到节点度矩阵，记为base
       A_matrix_1 = A_matrix./base;%A_matrix_1表示的是每一个节点的邻居节点的倒数
       A_matrix_1(isnan(A_matrix_1)) = 0;
       A_matrix_1(isinf(A_matrix_1)) = 0;%规整化，把0和无穷大都置零
       clear base
       S = A_matrix_1*A_matrix;%相似性矩阵，clear A_matrix_1 
       S=S-diag(diag(S));
       S(logical(A_matrix)) = 0;
       clear A_matrix
	   
       [precision, AUC, hit]=caculate_precision_and_AUC(S,test_set,L,rows);
       fprintf(fid, 'precision=%f, AUC=%f, hit=%f\n', precision, AUC, hit);
       fclose(fid); 
       clear S test_set
       precision_matrix{data_index} = [precision_matrix{data_index}, precision];
       AUC_matrix{data_index} = [AUC_matrix{data_index}, AUC];
       hit_matrix{data_index} = [hit_matrix{data_index}, hit];
    end
end
for print_index=1:13
     mean_precision = mean(precision_matrix{print_index});
     variance_precision = sqrt((sum((precision_matrix{print_index}-mean_precision).^2))/length(precision_matrix{print_index}));
     mean_hit = mean(hit_matrix{print_index});
     variance_hit = sqrt((sum((hit_matrix{print_index}-mean_hit).^2))/length(hit_matrix{print_index}));
    
     fprintf(folder_id, '%f %f %f %f %f\n', sum(precision_matrix{print_index})/length(precision_matrix{print_index}), sum( AUC_matrix{print_index})/length( AUC_matrix{print_index}), variance_precision, sum(hit_matrix{print_index})/length(hit_matrix{print_index}),variance_hit);
%     %fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f\n', file{print_index,6}, sum(precision_matrix{print_index})/length(precision_matrix{print_index}), sum( AUC_matrix{print_index})/length( AUC_matrix{print_index}), sum(hit_matrix{print_index})/length(hit_matrix{print_index}));
end
fclose(folder_id);
clear