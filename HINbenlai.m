clc;
clear;
%first list all file names
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

precision_matrix = cell(1,13);
AUC_matrix = cell(1,13);
hit_matrix = cell(1,13);
RMSE_matrix = cell(1,13);
for r=2:15
%folder_id = fopen('data/SRW_average_result.txt','w+');
random_walk_steps =r;

folder_id = fopen(['data/hsrw论文2_L=100_average_result_walk=' num2str(random_walk_steps ) ' .txt'],'w+');

L = 100;
%set number of random walk steps
%process five data sets
number = 1;
for foler_index=1:30
    for index= 1:13  %数据集
        fid = fopen(['data/data' num2str(foler_index) '/' file{index,6} '/HSRW_result.txt'],'w+');
        r_reindex = asstcoe(['data/data' num2str(foler_index) '/' file{index,6} '/reindex.txt']);
        r_train = asstcoe(['data/data' num2str(foler_index) '/' file{index,6} '/training.txt']);
        fprintf(fid, '%s\n', ['r_reindex:' num2str(r_reindex)]);
        fprintf(fid, '%s\n', ['r_train:' num2str(r_train)]);
        total_data = load(['data/data' num2str(foler_index) '/' file{index,6} '/reindex.txt'],'-ascii');
        total_max_label = max(max(total_data));
        fprintf(fid, '%s\n', ['total_max_node_label:' num2str(total_max_label)]);
        [t_rows t_cols] = size(total_data);
        fprintf(fid, 'total_rows=%d, total_cols=%d\n', t_rows, t_cols);
        clear total_data
        %load training data
        disp(file{index,1});
        
        training_set = load(['data/data' num2str(foler_index) '/' file{index,6} '/training.txt'],'-ascii');
        max_label = max(max(training_set));%maximmum node label
        fprintf(fid, '%s\n', ['training_max_node_label:' num2str(max_label)]);
        [rows cols] =size(training_set);
        fprintf(fid, 'training_rows=%d, training_cols=%d\n', rows, cols);
        A_matrix = zeros(max_label,max_label);
        for row_index = 1:rows 
            A_matrix(training_set(row_index,1), training_set(row_index,2)) = 1;
            A_matrix(training_set(row_index,2), training_set(row_index,1)) = 1;
        end
        
%HIN算法
%A_matrix是邻接矩阵（已给出）
node_degree_vector = sum(A_matrix,2);% degree column vector
base = repmat(node_degree_vector,1,max_label);%得到节点度矩阵，记为base

% h = load(['data/data' num2str(foler_index) '/' file{index,6} '/H_index.txt'],'-ascii');
%h = h';%得到的h是各节点的h指数纵向量
  
% H_index=repmat(h,1,max_label);%h指数矩阵
core = core_true(training_set);
core_base=repmat(core, 1, max_label);

% average_d_matrix = (A_matrix*base)/(node_degree_vector.');%平均邻居度矩阵
% average_h_matrix = (A_matrix*H_index)/(node_degree_vector.');%平均h指数矩阵
% average_d_matrix =repmat(average_d_matrix,1,max_label);
% average_h_matrix =repmat(average_h_matrix,1,max_label);
% 
% dh = (average_d_matrix.*average_h_matrix).^(1/2);
dh=(base.*core_base).^(1/2);
% dh=(base.*H_index).^(1/2);
%H_index = H_index'; SRW算法中没有转置，HHI算法中有转置，我认为这里不需要转置

%和SRW完全一样，得到概率转移矩阵
P = A_matrix./base;
P(isnan(P)) = 0;
P(isinf(P)) = 0;
%以下和SRW算法是几乎一致的
Simi_matrix = zeros(max_label);
Pi_matrix = eye(max_label);
        for step=1:random_walk_steps
            Pi_matrix = Pi_matrix*P;
            Pi_matrix = Pi_matrix-diag(diag(Pi_matrix));
            if step>1
                x_matrix = dh./(2*rows);
                y_matrix = x_matrix.';
                x_matrix = Pi_matrix.*x_matrix;
                %x_matrix = Pi_matrix.*x_matrix;%HHI算法代码中没有除以2倍的行列式
                y_matrix = (Pi_matrix.').*y_matrix;
                %y_matrix = (Pi_matrix.').*y_matrix;*det(A_matrix)
                Simi_matrix = Simi_matrix+(x_matrix+y_matrix);
                clear x_matrix y_matrix;
                Simi_matrix(logical(A_matrix)) = 0;%delete already existing links
            end
        end

                 %load test set
        test_line_matrix = load(['data/data' num2str(foler_index) '/' file{index,6} '/testing.txt'], '-ascii');
    %             test_size = size(test_line_matrix)
    %             for L=10:10:test_size(1)
    %                 disp(['L=' num2str(L)]);
    %                 [precision, AUC, hit] = caculate_precision_and_AUC(Simi_matrix,test_line_matrix,L,rows,node_degree_vector);
    %                 p_r_matrix = [p_r_matrix; [precision hit]];
    %             end
    %             save([file{index,5} '_p_r.txt'], 'p_r_matrix', '-ascii');
        [precision, AUC, hit, RMSE] = caculate_precision_and_AUC(Simi_matrix,test_line_matrix,L,rows);
        fprintf('precision=%f\n AUC=%f\n hit=%f\n', precision, AUC, hit)
        
        fclose(fid);
        precision_matrix{index} = [precision_matrix{index}, precision];
        AUC_matrix{index} = [AUC_matrix{index}, AUC];
        hit_matrix{index} = [hit_matrix{index}, hit];
        RMSE_matrix{index} = [RMSE_matrix{index}, RMSE];
    end
end
for data_index= 1:13
%     mean_precision = mean(precision_matrix{data_index});
%     variance_precision = sqrt((sum((precision_matrix{data_index}-mean_precision).^2))/length(precision_matrix{data_index}));
   % variance_precision = sqrt((sum((precision_matrix{data_index}-mean_precision).^2))/length(precision_matrix{data_index}));
   % variance_precision=sqrt(sum(precision_matrix{data_index}.^2)/length(precision_matrix{data_index})-(sum(precision_matrix{data_index})/length(precision_matrix{data_index}))^2);
%    mean_hit = mean(hit_matrix{data_index});
%    variance_hit = sqrt((sum((hit_matrix{data_index}-mean_hit).^2))/length(hit_matrix{data_index}));
%    fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}));
    %fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f, average_RMSE=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}), sum(RMSE_matrix{data_index})/length(RMSE_matrix{data_index}));
    fprintf(folder_id, '%f %f\n', sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}));

    
    
    %    variance_precision=sqrt(sum(precision_matrix{data_index}.^2)/length(precision_matrix{data_index})-(sum(precision_matrix{data_index})/length(precision_matrix{data_index}))^2);
%    variance_hit=sqrt(sum(hit_matrix{data_index}.^2)/length(hit_matrix{data_index})-(sum(hit_matrix{data_index})/length(hit_matrix{data_index}))^2);
%    fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, variance_precision=%f, average_hit=%f, variance_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), variance_precision, sum(hit_matrix{data_index})/length(hit_matrix{data_index}), variance_hit);
   % fprintf(folder_id, '%s: average_precision=%f, average_AUC=%f, average_hit=%f, average_RMSE=%f,\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}), sum(RMSE_matrix{data_index})/length(RMSE_matrix{data_index}));
   % fprintf('%s: average_precision=%f, average_AUC=%f, average_hit=%f\n', file{data_index,6}, sum(precision_matrix{data_index})/length(precision_matrix{data_index}), sum( AUC_matrix{data_index})/length( AUC_matrix{data_index}), sum(hit_matrix{data_index})/length(hit_matrix{data_index}));

end
end
fclose(folder_id);
clear
