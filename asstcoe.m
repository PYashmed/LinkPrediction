function r = asstcoe(file)
data=load(file,'-ascii');
[row,~]=size(data);

%有向边变无向边去环
i=1;
while(i<=row)
    flag1=data(:,1)==data(i,2);%找出两列中相同端点的在第一列中的位置，将其置为1，其余为0
    flag2=data(:,2)==data(i,1);%找出两列中相同端点的在第二列中的位置，将其置为1，其余为0
    flag=flag1+flag2;
    flag=flag==2;%找出flag中数值为2的位置，将其置为1，其余为0
    data(flag,:)=[];%去除两列对应相同的位置-----去除有向边和自环
    [row,~]=size(data);
    i=i+1;
end

%求邻接矩阵
maxID=max(max(data));%求出矩阵中的最大值，即最大端点编号
A_matrix=zeros(maxID,maxID);%定义一个n阶方阵，全零
for index=1:row
    A_matrix(data(index,1),data(index,2))=1;%将文本中的信息转变为矩阵形式，即将连边在矩阵对应位置中表示为1
end
A_matrix=A_matrix+A_matrix';%将上三角矩阵对称，补成完整方阵 
A_matrix(A_matrix>1)=1;%防止自环和有向边的影响？    A_matrix即网络中连边分布的矩阵------邻接矩阵

%求度分布
degree=sum(A_matrix);%得到每个节点的度（， ， ， ，）
MAXD=max(degree);%MAXD为最大的度
PK=zeros(1,MAXD);%定义一个1行MAXD列的全零矩阵
N=maxID;
for index=1:MAXD
    PK(index)=sum(degree==index);%PK矩阵每个位置都对应着同样数值度的个数，如PK（5）即为度=5的节点的总数
end
PK=PK/N;%将个数变为比例------度分布

%求PIJ（PIJ是什么？？？？）
PIJ=zeros(MAXD);
for index=1:row
  PIJ(degree(data(index,1)),degree(data(index,2))) = PIJ(degree(data(index,1)),degree(data(index,2)))+1;
end
PIJ=PIJ+PIJ';
PIJ=PIJ/(2*row);

%求Q,sigma
Q=sum(PIJ);
sigma=sum([1:MAXD].^2.*Q)-sum([1:MAXD].*Q)^2;
%求r
JK=repmat([1:MAXD],MAXD,1);
JK=JK.*JK';
QJK=repmat(Q,MAXD,1);
QJK=QJK.*QJK.';
r=JK.*(PIJ-QJK);
r=sum(sum(r))/sigma;

disp([ file 'r：' num2str(r)]);
clear data Q PIJ JK PIJ QJK PK A_matrix
end




