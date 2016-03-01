function lec6_slide32()
    load('faces.mat');
    HEIGHT = M;
    WIDTH = N;
    NUM = 600;
    DIM = 16;
    
    imagesc(reshape(X(:, 1), HEIGHT, WIDTH));
    
    X = bsxfun(@minus, X, mean(X, 2));
    [U, S, V] = svd(cov(X'));
    W_pca = S(1:DIM, 1:DIM)^-0.5 * U(:, 1:DIM)';
    X = W_pca * X;
        
    tol = 1e-5;
    mu = 1e-1;
    Wi = eye(DIM);
    while 1
        Y = Wi * X;
        del_W = (NUM * (eye(DIM)) - (Y.^3 * Y.')) * Wi / NUM;
        maxed = max(abs(del_W(:)));
        disp(maxed)
        
        if all(maxed < tol)
            disp(del_W);
            break
        end
        
        Wi = Wi + mu .* del_W;
    end
    
    pca_faces = U;
    lca_faces = (Wi * W_pca)';
    
    for i = 1:16
        subplot(8, 4, i)
        MIN = min(pca_faces(:, i));
        MAX = max(pca_faces(:, i));
        
        normalized = (pca_faces(:, i) - MIN) / (MAX - MIN);
        imshow(reshape(normalized, [HEIGHT, WIDTH]));
    end
    
    for i = 1:16
        subplot(8, 4, i + 16)
        MIN = min(lca_faces(:, i));
        MAX = max(lca_faces(:, i));
        
        normalized = (lca_faces(:, i) - MIN) / (MAX - MIN);
        imshow(reshape(normalized, [HEIGHT, WIDTH]));
    end
end

