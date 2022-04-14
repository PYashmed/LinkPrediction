A_matrix=[0 1 1 1;1 0 1 0;1 1 0 0;1 0 0 0];
 node_degree_vector = sum(A_matrix,2);% degree column vector
 base=log10(repmat(node_degree_vector,1,4));
 average_d_matrix = (A_matrix*base)./(node_degree_vector);
%  average_d_matrix(isnan(average_d_matrix)) = 0;
%         kk=node_degree_vector./(4-1);
%         mm=log10(kk);
%         mm(isnan(mm)) = 0;
%         mm(isinf(mm)) = 0;
%         ME=-kk.*(A_matrix*mm);
%  
        

