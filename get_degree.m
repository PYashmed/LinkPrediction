function [ out ] = get_degree(A,k)
%GET_DEGREE Summary of this function goes here
%   Detailed explanation goes here
%AΪ�ڽӾ���
%�õ�����A�ڵ�Ϊk�Ķ�
row = A(k,:);
out=size(find(row==1),2);
end

