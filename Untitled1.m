A=[0 1 0 0 0 0 1 0 0 0;1 0 1 0 0 0 1 0 0 0;0 1 0 1 0 0 1 0 0 0;0 0 1 0 1 0 1 1 1 1;0 0 0 1 0 1 1 0 0 0;0 0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 0 0 0 0;0 0 0 1 0 0 0 0 0 0;0 0 0 1 0 0 0 0 0 0;0 0 0 1 0 0 0 0 0 0];%����������ڽӾ���
%��þ���ά��
A_Size = size(A);
M = zeros(A_Size(1), 1);
%  ����ڵ�Ķ�ֵ
b = sum(A, 2);
%������ڵ���ڽӶ�
for i=1:A_Size(1)
    M(i) = sum(b(find(A(i,:))));
end
%  ����ڵ�������ھӽڵ����
pi ={};
pj = {}; for i=1:A_Size(1)
    tmp =   M(find(A(i,:)));
    pi(i) = {b(i)./tmp};
    pj(i) = {b(find(A(i,:)))./tmp};
end
%  ����ڵ����Ϣ��
res = zeros(A_Size(1),1);
for i=1:A_Size(1)
    B_S = size(pi{i});
    for j=1:B_S(1)
        res(i) = -pi{i}(j)*pj{i}(j)*log2(pi{i}(j)) + res(i);
    end
end

