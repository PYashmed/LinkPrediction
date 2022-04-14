
file{1,1} = '/USAir/training.txt';
file{1,2} = '/USAir/testing.txt';
file{1,3} = '/USAir/reindex.txt';
file{1,4} = 'USAir';

file{2,1} = '/Yeast/training.txt';
file{2,2} = '/Yeast/testing.txt';
file{2,3} = '/Yeast/reindex.txt';
file{2,4} = 'Yeast';

file{3,1} = '/Food/training.txt';
file{3,2} = '/Food/testing.txt';
file{3,3} = '/Food/reindex.txt';
file{3,4} = 'Food';

file{4,1} = '/Power/training.txt';
file{4,2} = '/Power/testing.txt';
file{4,3} = '/Power/reindex.txt';
file{4,4} = 'Power';

file{5,1} = '/metabolic/training.txt';
file{5,2} = '/metabolic/testing.txt';
file{5,3} = '/metabolic/reindex.txt';
file{5,4} = 'metabolic';

file{6,1} = '/NS/training.txt';
file{6,2} = '/NS/testing.txt';
file{6,3} = '/NS/reindex.txt';
file{6,4} = 'NS';

file{7,1} = '/Jazz/training.txt';
file{7,2} = '/Jazz/testing.txt';
file{7,3} = '/Jazz/reindex.txt';
file{7,4} = 'Jazz';

file{8,1} = '/email/training.txt';
file{8,2} = '/email/testing.txt';
file{8,3} = '/email/reindex.txt';
file{8,4} = 'email';

file{9,1} = '/Slavko/training.txt';
file{9,2} = '/Slavko/testing.txt';
file{9,3} = '/Slavko/reindex.txt';
file{9,4} = 'Slavko';

file{10,1} = '/ucsocial/training.txt';
file{10,2} = '/ucsocial/testing.txt';
file{10,3} = '/ucsocial/reindex.txt';
file{10,4} = 'ucsocial';

file{11,1} = '/Infec/training.txt';
file{11,2} = '/Infec/testing.txt';
file{11,3} = '/Infec/reindex.txt';
file{11,4} = 'Infec';

file{12,1} = '/EuroSiS/training.txt';
file{12,2} = '/EuroSiS/testing.txt';
file{12,3} = '/EuroSiS/reindex.txt';
file{12,4} = 'EuroSiS';

file{13,1} = '/CE/training.txt';
file{13,2} = '/CE/testing.txt';
file{13,3} = '/CE/reindex.txt';
file{13,4} = 'CE';

file{14,1} = '/Router/training.txt';
file{14,2} = '/Router/testing.txt';
file{14,3} = '/Router/reindex.txt';
file{14,4} = 'Router';

file{15,1} = '/King Jame/training.txt';
file{15,2} = '/King Jame/testing.txt';
file{15,3} = '/King Jame/reindex.txt';
file{15,4} = 'King Jame';

file{16,1} = '/CS phd/training.txt';
file{16,2} = '/CS phd/testing.txt';
file{16,3} = '/CS phd/reindex.txt';
file{16,4} = 'CS phd';

file{17,1} = '/EVA/training.txt';
file{17,2} = '/EVA/testing.txt';
file{17,3} = '/EVA/reindex.txt';
file{17,4} = 'EVA';

for foler_index= 1:30   %folder_index�ǵڼ������ݼ� ��30 
    for index= 17:17 %index���������ݼ� ��13
        Total_Data = load(['��������/data' num2str(foler_index) file{index,3}],'-ascii');
        Total_Data = Total_Data(:,1:2);  %6257
        [L_,~] = size(Total_Data); %L_����������
        %����reindex������ͼ
        s_ = Total_Data(:,1);%��һ��
        t_ = Total_Data(:,2);%�ڶ���
        G_ = graph(s_,t_);  
        %�õ���С������
        s=minspantree(G_);
        [Training_set,~] = minspantree(G_); %5020����
       %��graph�е�table��תΪdouble��
       Training_set = table2array(Training_set.Edges); 
         %�õ�����train������
        [line_num,~] = size(Training_set); %5020
         %ȥ�����м�
        [intersection,same_Line_Num,~] = intersect(Total_Data,Training_set,'rows','stable'); %�õ����м�������reindex�ж�Ӧ������ ��reidnex��˳�򲻱�
      Total_Data(same_Line_Num,:) = []; %��reindex��ȥ��train������   6257-5020 ��5021���� 5020����
        [Line_Num,~]=size(Total_Data);  %�õ���reindex������  1237
         %��ѵ��������������ʱ
         while(line_num<=0.9*L_)
            %�����ȡ���ڼ����� �����train ʣ�µ���test
            Random_Line = randperm(Line_Num,1);
            line_num = line_num+1;
            Training_set(line_num,:) = Total_Data(Random_Line,:);
            Total_Data(Random_Line,:)=[];
            Line_Num = Line_Num-1;
        end
            
        %ѵ�������·��
        Train_path = strcat('��������/data', num2str(foler_index));
        Train_path = strcat(Train_path,file{index,1});
        %д��
        writematrix(Training_set,Train_path,'Delimiter','space');
        
        %���Լ����·��
        Test_path = strcat('��������/data', num2str(foler_index));
        Test_path = strcat(Test_path,file{index,2});
        %д��
        writematrix(Total_Data,Test_path,'Delimiter','space');
        
    end
end

