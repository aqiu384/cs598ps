function lec6_slide22()
    rng(0, 'twister');
    NUM = 1000;
    r1 = rand(1, NUM)*2 - 1;
    r2 = rand(1, NUM)*2 - 1;
    x = 2*r1 + r2;
    y = r1 + r2;
    
    X = vertcat(x, y);    
    [U, S, V] = svd(cov(X'));
    W = S ^ -0.5 * transpose(V);
    pca_points = W * X;
    
    tol = 1e-10;
    mu = 1e-2;
    Wi = eye(2);
    while 1
        Y = Wi * X;
        del_W = (NUM .* (eye(2)) - (Y.^3 * Y.')) * Wi / NUM;
        maxed = max(abs(del_W(:)));
        disp(maxed)
        
        if all(maxed < tol)
            disp(del_W);
            break
        end
        
        Wi = Wi + mu .* del_W;
    end
    
    lca_points = Wi * X;
    
    subplot(131)
    scatter(X(1, :), X(2, :));
    subplot(132);
    scatter(pca_points(1, :), pca_points(2, :));
    axis equal;
    subplot(133);
    scatter(lca_points(1, :), lca_points(2, :));
    axis equal;
end

