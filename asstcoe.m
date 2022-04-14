function r = asstcoe(file)
data=load(file,'-ascii');
[row,~]=size(data);

%����߱������ȥ��
i=1;
while(i<=row)
    flag1=data(:,1)==data(i,2);%�ҳ���������ͬ�˵���ڵ�һ���е�λ�ã�������Ϊ1������Ϊ0
    flag2=data(:,2)==data(i,1);%�ҳ���������ͬ�˵���ڵڶ����е�λ�ã�������Ϊ1������Ϊ0
    flag=flag1+flag2;
    flag=flag==2;%�ҳ�flag����ֵΪ2��λ�ã�������Ϊ1������Ϊ0
    data(flag,:)=[];%ȥ�����ж�Ӧ��ͬ��λ��-----ȥ������ߺ��Ի�
    [row,~]=size(data);
    i=i+1;
end

%���ڽӾ���
maxID=max(max(data));%��������е����ֵ�������˵���
A_matrix=zeros(maxID,maxID);%����һ��n�׷���ȫ��
for index=1:row
    A_matrix(data(index,1),data(index,2))=1;%���ı��е���Ϣת��Ϊ������ʽ�����������ھ����Ӧλ���б�ʾΪ1
end
A_matrix=A_matrix+A_matrix';%�������Ǿ���Գƣ������������� 
A_matrix(A_matrix>1)=1;%��ֹ�Ի�������ߵ�Ӱ�죿    A_matrix�����������߷ֲ��ľ���------�ڽӾ���

%��ȷֲ�
degree=sum(A_matrix);%�õ�ÿ���ڵ�Ķȣ��� �� �� ����
MAXD=max(degree);%MAXDΪ���Ķ�
PK=zeros(1,MAXD);%����һ��1��MAXD�е�ȫ�����
N=maxID;
for index=1:MAXD
    PK(index)=sum(degree==index);%PK����ÿ��λ�ö���Ӧ��ͬ����ֵ�ȵĸ�������PK��5����Ϊ��=5�Ľڵ������
end
PK=PK/N;%��������Ϊ����------�ȷֲ�

%��PIJ��PIJ��ʲô����������
PIJ=zeros(MAXD);
for index=1:row
  PIJ(degree(data(index,1)),degree(data(index,2))) = PIJ(degree(data(index,1)),degree(data(index,2)))+1;
end
PIJ=PIJ+PIJ';
PIJ=PIJ/(2*row);

%��Q,sigma
Q=sum(PIJ);
sigma=sum([1:MAXD].^2.*Q)-sum([1:MAXD].*Q)^2;
%��r
JK=repmat([1:MAXD],MAXD,1);
JK=JK.*JK';
QJK=repmat(Q,MAXD,1);
QJK=QJK.*QJK.';
r=JK.*(PIJ-QJK);
r=sum(sum(r))/sigma;

disp([ file 'r��' num2str(r)]);
clear data Q PIJ JK PIJ QJK PK A_matrix
end




