%������·Ԥ���㷨��2��ָ�꣺precision(��ȷ��) AUC
function [precisoin, AUC, hit, RMSE] = caculate_precision_and_AUC(degree_matrix,test_line_matrix,L,exist_lines)
%CACULATE_PRECISION_AND_AUC Summary of this function goes
%here�����������caculate_precision_and_AUC,���Ǽ���׼ȷ�Ⱥ�AUC�ĺ������ĸ������ֱ���(�Ⱦ��󣬲��Ծ������ŵı�(�������))
%   Detailed explanation goes here

total = degree_matrix;
clear degree_matrix close_matrix between_matrix;
total = triu(total,0);%triu������matlab����ȡ���������Ǿ���ĺ�����triu(X)����X����������Ǿ�������Ԫ�ز�0
[n_row, ~] = size(total);
non_zeros = sum(sum(total>0));%sum(x)��������ӣ���ÿ�еĺͣ������������  non_zeros=total���������ĺͣ����õ��������Ե��ܺ�
line_count = (n_row*(n_row-1))/2;%��������������n���������n*(n-1)/2���ߣ�
line_count = line_count - non_zeros-exist_lines;%Ϊʲô��ȥ�����Ե��ܺͣ���
%{
�����������������1��total��degree_matrix�������Ǿ��� 2��non_aeros��total����Ԫ���ܺ�
3��line_count�Ǻ�����������йصĶ���
%}

pred_matrix = total;         %Ԥ�����
test_value_array = [];
[m , ~] = size(test_line_matrix);  %m��n�ֱ�Ϊ���Լ����С���
[~, pos_degree] =  sort(total(:),'descend');%sort(A)��A�������������л�����������Ĭ�϶��Ƕ�A�����������С�sort(A)��Ĭ�ϵ����򣬶�sort(A,'descend')�ǽ������� 
                                                   %pos_degree��ÿ����ֵ��Ӧ��λ�á�L_degree�ǰ��ս�������е����� 
total(pos_degree(L+1:end)) = 0; %total������ֻ����ǰL��������������ȫ����Ϊ�㡣
correct_number = 0;
%{
�����������������1��pred_matrix��totalһ�� 2��m,nΪ���Լ�������
3��total�����б���ǰL����������������
%}

for index3 = 1:m   
   coordinate = test_line_matrix(index3,:);% coordinateÿ��ѭ���о���ʾ���Լ��е�ĳһ�У����õ����Լ������ߵ������˵�
   test_value_array = [test_value_array,pred_matrix(coordinate(1),coordinate(2))];%pred_matrix(coordinate(1),coordinate(2)��ʾ���Լ��������������Ծ����ж�Ӧ�������ԡ��˲�ʲô��˼����
   pred_matrix(coordinate(1),coordinate(2))=-1;
   if total(coordinate(1),coordinate(2)) ~= 0 %�жϲ��Լ��е������Ƿ�Ԥ���������������ֵ��Ԥ�����correct_number��1��correct_number���Ϊ���Լ����������߱�Ԥ�����������
       correct_number =correct_number +1;
   end
end

precisoin = correct_number/L;  %���ֵ1��������ȷ��(a/a+c),��������Ԥ��Ϊ���ĵ�����ȷ�ı���
hit = correct_number/m;        %����3
pred_array = pred_matrix(pred_matrix>0);
pred_array = [pred_array;zeros(line_count, 1)];%������
clear pred_matrix total coordinate correct_number;

total_count = 1000000;
%n_bigger = 0;  ����������Ϊ��ʾû�õ�����ע�͵�
%n_equal = 0;
cols_of_test = length(test_value_array);
cols_of_pred = length(pred_array);

%����Ϊ����AUC�Ĺ���
 value_test = test_value_array(randi(cols_of_test,1,total_count));%ÿ������Ӳ��Լ��г�ȡһ�����ߣ�����ȡ10���
 value_pred = pred_array(randi(cols_of_pred,1,total_count));%�����ԭ�������߼����г�ȡһ������
 n_bigger = sum(value_test>value_pred.');%ͳ�����Բ��Լ������߿����Դ�������E-�����ߵ�����
 n_equal = sum(value_test==value_pred.');%ͳ��������ȵ�����

AUC = (n_bigger+0.5*n_equal)/total_count;    %����2
% disp(['precision��:' num2str(precisoin) ',AUC��:' num2str(AUC)]);


%����Ϊ����RMSE�Ĺ���
average_value = sum(test_value_array)/length(test_value_array);
normalized_test_value = test_value_array./average_value;

RMSE_1 = (normalized_test_value - 1).*(normalized_test_value - 1);
RMSE  = sqrt((sum(RMSE_1))/length(test_value_array));   %����4



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

