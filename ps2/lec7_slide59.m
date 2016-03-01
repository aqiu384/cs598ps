function lec7_slide59()
    rng(0, 'twister');
    NUM = 500;
    ONES = ones(3, NUM);
    K = 12;
    ONE = ones(K, 1);
    angles = rand(NUM, 1) * 10;
    
    points = zeros(3, NUM);
    points(1, :) = angles .* cos(angles);
    points(2, :) = angles .* sin(angles);
    points(3, :) = rand(NUM, 1) * 5;
    
    dists = ones(NUM, NUM) * Inf;
    
    for i = 1:NUM
        distances = sum((points - diag(points(:, i)) * ONES) .^ 2);
        for j = 1:K + 1
            [D, I] = min(distances);
            distances(I) = Inf;
            dists(i, I) = D .^ 0.5;
        end
    end
        
    for k = 1:NUM
        for i = 1:NUM
            for j = 1:NUM
                if dists(i, j) > dists(i, k) + dists(k, j)
                    dists(i, j) = dists(i, k) + dists(k, j);
                end
            end
        end
        disp(k);
    end
  
    D = dists;
    n = NUM;
    no_dims = 2;
        
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
    scatter(mappedX(:, 1), mappedX(:, 2), [], angles);
    
%     sub_row = bsxfun(@minus, D, mean(D, 1));
%     sub_col = bsxfun(@minus, D, mean(D, 2));
%     sub_all = bsxfun(@minus, D, mean(D(:)));
%     
%     result = (sub_row + sub_col - sub_all) * 0.5;
%     [U, S, V] = svd(result);
%     
%     X = S ^ 0.5 * U';
%     
%     disp(max(D(:)));
%     scatter(X(1, :), X(2, :), [], angles);
%     subplot(121);
%     scatter3(points(1, :), points(2, :), points(3, :), [], angles);
%     axis equal;
%     subplot(122);
%     scatter(X(1, :), X(2, :), [], angles);
%     axis equal;
end

