function lec7_slide36()
    load('cities.mat');
    NUM = length(D);
    
    n = NUM;
    no_dims = 3;
    
    M = -.5 * (D .^ 2 - sum(D .^ 2)' * ones(1, n) / n - ones(n, 1) * sum(D .^ 2) / n + sum(sum(D .^ 2)) / (n ^ 2));
	M(isnan(M)) = 0;
	M(isinf(M)) = 0;
    [vec, val] = eig(M);
	if size(vec, 2) < no_dims
		no_dims = size(vec, 2);
		warning(['Target dimensionality reduced to ' num2str(no_dims) '...']);
	end
	
    % Computing final embedding
    h = real(diag(val)); 
    [foo, sorth] = sort(h, 'descend');  
    val = real(diag(val(sorth, sorth))); 
    vec = vec(:,sorth);
    mappedX = real(vec(:,1:no_dims) .* (ones(n, 1) * sqrt(val(1:no_dims))')); 
    disp(size(mappedX));
    
    X = mappedX;
    
%     sub_row = bsxfun(@minus, D, mean(D, 1));
%     sub_col = bsxfun(@minus, D, mean(D, 2));
%     sub_all = bsxfun(@minus, D, mean(D(:)));
%     
%     result = (sub_row + sub_col - sub_all) * 0.5;
%     [U, S, V] = svd(result);
%     
%     X = S ^ 0.5 * U';
    
    scatter3(X(:, 1) * -1, X(:, 2), X(:, 3));
    text(X(:, 1) * -1, X(:, 2), X(:, 3), cities);
end

