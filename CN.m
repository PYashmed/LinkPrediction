clear;
clc;
%coefficient of weak tie

%% 记录下数据文件的目录地址
%USAir的相关文件
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

%CN算法
%% 算5个数据
precision_matrix = cell(1,13);
AUC_matrix = cell(1,13);
hit_matrix = cell(1,13);

L =100;

folder_id = fopen('data/CN论文2_100_average_var_result.txt','w+');
for foler_index=1:30
    for index1 = 1:13
       fid = fopen(['data/data' num2str(foler_index) '/' file{index1,6} '/CN_result.txt'],'w+');
       r_reindex = asstcoe(['data/data' num2str(1) '/' file{index1,6} '/reindex.txt']);
       r_train = asstcoe(['data/data' num2str(foler_index) '/' file{index1,6} '/training.txt']);
       fprintf(fid, '%s\n', ['r_reindex:' num2str(r_reindex)]);
       fprintf(fid, '%s\n', ['r_train:' num2str(r_train)]);
       total_data = load(['data/data' num2str(1) '/' file{index1,6} '/reindex.txt'],'-ascii');
       total_max_label = max(max(total_data));
       fprintf(fid, '%s\n', ['total_max_node_label:' num2str(total_max_label)]);
       [t_rows, t_cols] = size(total_data);
       fprintf(fid, 'total_rows=%d, total_cols=%d\n', t_rows, t_cols);
       clear total_data
	   
       training_set = load(['data/data' num2str(foler_index) '/' file{index1,6} '/training.txt'],'-ascii');
       max_label = max(max(training_set));
       fprintf(fid, '%s\n', ['training_max_node_label:' num2str(max_label)]);
       [rows, cols] =size(training_set);
       fprintf(fid, 'training_rows=%d, training_cols=%d\n', rows, cols);
       sn = zeros(max_label,max_label);
       for row_index = 1:rows  
           sn(training_set(row_index,1), training_set(row_index,2)) = 1;
           sn(training_set(row_index,2), training_set(row_index,1)) = 1;
       end
       disp('系数矩阵的尺寸是:');
       size(sn)
       disp(['开始第', num2str(index1),'个数据处理!']);
        %首先获得网络矩阵
        sn = FormNet(training_set);%得到网络的邻接矩阵
        sn = full(sn); %full把一个稀疏矩阵转化为全矩阵
        sn = sn-diag(diag(sn));
        S = sn*sn.'; %矩阵对应节点对公共邻居数
        S(logical(sn)) = 0; %除去原来相连的点对
        S = S-diag(diag(S));
        S = triu(S, 0); %去掉对称的重复
		
        test_line_matrix = load(['data/data' num2str(foler_index) '/' file{index1,6} '/testing.txt'],'-ascii');
        [precision, AUC, hit]=caculate_precision_and_AUC(S,test_line_matrix,L,rows);
        fprintf(fid, 'precision=%f, AUC=%f, hit=%f\n', precision, AUC, hit);
        fclose(fid);
        precision_matrix{index1} = [precision_matrix{index1}, precision];
        AUC_matrix{index1} = [AUC_matrix{index1}, AUC];
        hit_matrix{index1} = [hit_matrix{index1}, hit];
        clear degree_ultimate_matrix;
        clear weighted_matrix coordinate logical_vector
        clear temp_vector S S3;
    end
end

for data_index=1:13
    mean_precision = mean(precision_matrix{data_index});
    variance_precision = sqrt((sum((precision_matrix{data_index}-mean_precision).^2))/length(precision_matrix{data_index}));
   % variance_precision = sqrt((sum((precision_matrix{data_index}-mean_precision).^2))/length(precision_matrix{data_index}));
   % variance_precision=sqrt(sum(precision_matrix{data_index}.^2)/length(precision_matrix{data_index})-(sum(precision_matrix{data_index})/length(precision_matrix{data_index}))^2);
   mean_hit = mean(hit_matrix{data_index});
   variance_hit = sqrt((sum((hit_matrix{data_index}-mean_hit).^2))/length(hit_matrix{data_index}));
%    fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}));
    %fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f, average_RMSE=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}), sum(RMSE_matrix{data_index})/length(RMSE_matrix{data_index}));
    fprintf(folder_id, '%s: %f %f %f %f %f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), variance_precision, sum(hit_matrix{data_index})/length(hit_matrix{data_index}), variance_hit);

    
%     variance_precision=sqrt(sum(precision_matrix{data_index}.^2)/length(precision_matrix{data_index})-(sum(precision_matrix{data_index})/length(precision_matrix{data_index}))^2);
%     variance_hit=sqrt(sum(hit_matrix{data_index}.^2)/length(hit_matrix{data_index})-(sum(hit_matrix{data_index})/length(hit_matrix{data_index}))^2);
%     %variance_precision = sqrt(sum(average_precision.^2)/length(average_precision)-(sum(average_precision)/length(average_precision))^2);
%     %variance_hit = sqrt(sum(average_hit.^2)/length(average_hit)-(sum(average_hit)/length(average_hit))^2);
%     fprintf(folder_id, '%s: average_precision=%f, variance_precision=%f, average_AUC=%f, average_hit=%f, variance_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), variance_precision, sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}),variance_hit);
%     %fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}));

end
fclose(folder_id);
clear 





