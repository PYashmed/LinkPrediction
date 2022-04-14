%function  core_true(training_set, dir_name)
function  core = core3(training_set)
   [rows, cols] =size(training_set);
   max_label = max(max(training_set))
   A_matrix = zeros(max_label,max_label);
   for row_index = 1:rows 
          A_matrix(training_set(row_index,1), training_set(row_index,2)) = 1;
          A_matrix(training_set(row_index,2), training_set(row_index,1)) = 1;
   end
        
   sn = A_matrix;
   core = zeros(max_label,1);
   node_degree_vector = sum(sn,2);
   s = sum(node_degree_vector); 
   k_core = 0;
   node_station = zeros(max_label,1);
   node_station_1 = zeros(max_label,1);
   
   
while s>0
     A = find(node_degree_vector <= k_core);
     node_station(A(1:end)) = 1;
     sign = length(A);     
       while sign>0
%         A = find(node_degree_vector <= k_core);
           node_degree_vector(A(1:end)) = 0;
           
           for data_index = 1:length(A)
               sn(A(data_index,1),:) = 0;
               sn(:,A(data_index,1)) = 0;
           end
           
           node_degree_vector = sum(sn,2);           
%            node_sign_matrix = find(node_degree_vector~=0);
%            node_sign = min(node_degree_vector(node_sign_matrix(1:end)));
%            
%            sign = node_sign==k_core;
           
           A = find(node_degree_vector <= k_core);
           A_1 = find(node_degree_vector == 0);
           sign = length(A) - length(A_1);
           
%            node_station_1()
           node_station(A(1:end)) = 1;
%            sign = length(A);
       end
       
%          node_station_1 = node_station;
         node_station(logical(node_station_1)) = 0;
         core(logical(node_station)) = k_core;
         core_sign = length(find(core==0));
%         A = find(node_degree_vector == k_core);
%         node_degree_vector(A(1:end)) = 0;
%         core(A(1:end)) = k_core;
         node_degree_vector = sum(sn,2);
         node_sign_matrix = find(node_degree_vector~=0);
         node_sign = min(node_degree_vector(node_sign_matrix(1:end)));
         
%          core(logical(node_station)) = k_core + node_sign;
         k_core = node_sign;
         s = sum(node_degree_vector);
%          s = s*core_sign;
         node_station_1(logical(node_station)) = 1;   
   end
     %save([dir_name, '/core.txt'],'core','-ascii');
  end   