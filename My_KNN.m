function [ result_label ] = My_KNN( train_element,train_label,test_element,range )
% attr for options : K , test_class , measure

% repmat each element of test_element and acquire euc_distance from each
% train_elememt
for i = 1:size(test_element , 1)    %temp variable
    diff_mat = repmat(test_element(i,:) , size(train_element , 1) , 1)  - train_element;
    for j = 1:size(train_element , 1)
        % storing euclidean distance for each row of diff_mat
        distance_mat(j) = norm(diff_mat(j,:));
    end
    [sorted_dis_mat , original_row]  =sort(distance_mat , 'ascend');
    len = min(range , length(sorted_dis_mat));
    result_label(i) = mode(train_label(original_row(1:len)));
end

end

