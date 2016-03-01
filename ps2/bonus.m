function bonus()
    load('one.mat');
    disp(size(one));
    
    WIDTH = 28;
    HEIGHT = 28;
    NUM = 500; % length(one);
    X = zeros(WIDTH * HEIGHT, NUM);
    K = round(NUM / 4);
        
    for i = 1:NUM
        X(:, i) = reshape(cell2mat(one(i)), [WIDTH * HEIGHT, 1]);
    end
    
    distances = ones(NUM, NUM) * Inf;
    
    for i = 1:NUM
        temp = zeros(1, NUM);
        for j = 1:NUM
            temp(j) = sum((X(:, i) - X(:, j)) .^ 2);
        end
        for j = 1:K + 1
            [D, I] = min(temp);
            temp(I) = Inf;
            distances(i, I) = D;
        end
        disp(i);
    end
            
    for k = 1:NUM
        for i = 1:NUM
            for j = 1:NUM
                if distances(i, j) > distances(i, k) + distances(k, j)
                    distances(i, j) = distances(i, k) + distances(k, j);
                end
            end
        end
        disp(k);
    end
    
    imagesc(distances);
    disp(max(distances(:)));
    
    D = distances;
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
    % disp(size(mappedX));
    scatter(mappedX(:, 1), mappedX(:, 2));
    
    SIZE = 0.1;
    dx = WIDTH * SIZE;
    dy = HEIGHT * SIZE;
    
    hold on;
    for i = 1:NUM
        x = mappedX(i, 1);
        y = mappedX(i, 2);
        imagesc([x-dx, x+dx],[y+dy, y-dy], reshape(X(:, i), [HEIGHT, WIDTH]));
    end
    hold off;
    
    axis equal;
end

