% made by YB %
%����һ��ģ�����ݼ������precision��AUC ���������ļ��Ƚ�
clc;
clear;

%�������ݼ�
total_data=zeros(9,28);
for r = 2:15
    if (r == 2)
    total_data = load(['��������/1SRW_ME10Ϊ�ײ�_var_average_result_walk=' num2str(2) ' .txt' ],'-ascii');
    else
    total_data = cat(2,total_data,load(['��������/1SRW_ME10Ϊ�ײ�_var_average_result_walk=' num2str(r) ' .txt' ],'-ascii'));
    end
end

%�ֱ���AUC��precision
precision=zeros(9,14);
AUC=zeros(9,14);
for r = 1:14
  precision(:,r) = total_data(:,2*r-1);
  AUC(:,r) = total_data(:,2*r);
end
AUC=AUC.';
precision=precision.'

%�õ����AUC��precision�����ǵ�������
% [PreMaxnum,PreQuene] = max(precision,[],2);
% [AUCMaxnum,AUCQuene] = max(total_data,[],2);


%�����Ҫ��PreMaxnm/AUCMaxnum��֮ǰģ������X����ȶ� ʾ��
%����߼����� ��������λ��Ϊ1
%X = load(['�ļ���'],'-ascii');
%L = logical(PreMaxnum>=X);
%�ҵ�Ϊ1��λ�� ֻ�������
%[BiggerLine,~] = find(L);
    