A=[0 1 0 0 0 0 1 0 0 0;1 0 1 0 0 0 1 0 0 0;0 1 0 1 0 0 1 0 0 0;0 0 1 0 1 0 1 1 1 1;0 0 0 1 0 1 1 0 0 0;0 0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 0 0 0 0;0 0 0 1 0 0 0 0 0 0;0 0 0 1 0 0 0 0 0 0;0 0 0 1 0 0 0 0 0 0];%输入网络的邻接矩阵
%获得矩阵维度
A_Size = size(A);
M = zeros(A_Size(1), 1);
%  计算节点的度值
b = sum(A, 2);
%计算各节点的邻接度
for i=1:A_Size(1)
    M(i) = sum(b(find(A(i,:))));
end
%  计算节点概率与邻居节点概率
pi ={};
pj = {}; for i=1:A_Size(1)
    tmp =   M(find(A(i,:)));
    pi(i) = {b(i)./tmp};
    pj(i) = {b(find(A(i,:)))./tmp};
end
%  计算节点的信息熵
res = zeros(A_Size(1),1);
for i=1:A_Size(1)
    B_S = size(pi{i});
    for j=1:B_S(1)
        res(i) = -pi{i}(j)*pj{i}(j)*log2(pi{i}(j)) + res(i);
    end
end

