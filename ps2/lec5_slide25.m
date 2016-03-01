function lec5_slide25()
    rng(0, 'twister');
    NUM = 300;
    ANGLE = pi / 6;
    ROTATION = [cos(ANGLE), -sin(ANGLE); sin(ANGLE), cos(ANGLE)];
    
    points = zeros([2, NUM]);
        
    points(1, :) = 2 * randn(NUM, 1);
    points(2, :) = 0.25 * randn(NUM, 1);
    points = ROTATION * points;
    
    [U, S, V] = svd(cov(transpose(points)));
    my_cov = U * S ^ 0.5;
    W = U * S ^ -0.5 * transpose(V);
    new_points = W * points;
    
    [U, S, ~] = svd(cov(transpose(new_points)));
    new_cov = U * S ^ 0.5;
    
    subplot(121);
    scatter(points(1, :), points(2, :), 'filled');
    hold on;
    quiver([0, 0], [0, 0], my_cov(1, :), my_cov(2, :), 'r');
    hold off;
    axis equal;
    
    subplot(122);
    scatter(new_points(1, :), new_points(2, :), 'filled');
    hold on;
    quiver([0, 0], [0, 0], new_cov(1, :), new_cov(2, :), 'r');
    hold off;
    axis equal;
end

