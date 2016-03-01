function lec9_slide45()
    load('face2.mat');
    [U, S, V] = svd(XX);
    
    down = V(:, 1:2)';
    red = down(:, g == 1);
    blue = down(:, g == 0);
    blue = blue(:, blue(1, :) < -0.05);
    
    TOTAL = length(red) + length(blue);
    XRANGE = -0.0515:0.0002:-0.047;
    YRANGE = -0.1:0.0005:0.1;
    XLEN = length(XRANGE);
    YLEN = length(YRANGE);
    
    [X, Y] = meshgrid(XRANGE, YRANGE);
    grid = cat(3, X, Y);
        
    blue_sigma = eye(2);
    red_sigma = eye(2);
    
    blue_mu = mean(blue, 2);
    red_mu = mean(red, 2);
    
    blue_g = zeros(YLEN, XLEN);
    red_g = zeros(YLEN, XLEN);
        
    for i = 1:YLEN
        for j = 1:XLEN
            point = squeeze(grid(i, j, :));
            
            blue_point = point - blue_mu;
            blue_g(i, j) = -0.5 * blue_point' * inv(blue_sigma) * blue_point + log(0.5) - 0.5 * log(det(blue_sigma));
            
            red_point = point - red_mu;
            red_g(i, j) = -0.5 * red_point' * inv(red_sigma) * red_point + log(0.5) - 0.5 * log(det(red_sigma));
        end
    end
    
    bound_g = blue_g - red_g;
    
    figure('Name', 'Lecture 9: Slide 53');
    subplot(121);
    hold on;
    contourf(grid(:, :, 1), grid(:, :, 2), bound_g, 1);
    scatter(blue(1, :), blue(2, :));
    scatter(red(1, :), red(2, :), 'r');
    hold off;
    
    [U, S, V] = svd(XX);
    
    down = V(:, 1:2)';
    red = down(:, g == 1);
    blue = down(:, g == 0);
    blue = blue(:, blue(1, :) < -0.05);
    
    TOTAL = length(red) + length(blue);
    XRANGE = -0.0515:0.0002:-0.047;
    YRANGE = -0.1:0.0005:0.1;
    XLEN = length(XRANGE);
    YLEN = length(YRANGE);
    
    [X, Y] = meshgrid(XRANGE, YRANGE);
    grid = cat(3, X, Y);
        
    blue_sigma = cov(blue'); %eye(2);
    red_sigma = cov(red'); %eye(2);
    
    blue_mu = mean(blue, 2);
    red_mu = mean(red, 2);
    
    blue_g = zeros(YLEN, XLEN);
    red_g = zeros(YLEN, XLEN);
        
    for i = 1:YLEN
        for j = 1:XLEN
            point = squeeze(grid(i, j, :));
            
            blue_point = point - blue_mu;
            blue_g(i, j) = -0.5 * blue_point' * inv(blue_sigma) * blue_point + log(length(blue) / TOTAL) - 0.5 * log(det(blue_sigma));
            
            red_point = point - red_mu;
            red_g(i, j) = -0.5 * red_point' * inv(red_sigma) * red_point + log(length(red) / TOTAL) - 0.5 * log(det(red_sigma));
        end
    end
    
    bound_g = zeros(YLEN, XLEN);
    bound_g(red_g > blue_g) = 1;
    
    subplot(122);
    hold on;
    contourf(grid(:, :, 1), grid(:, :, 2), bound_g, 1);
    scatter(blue(1, :), blue(2, :));
    scatter(red(1, :), red(2, :), 'r');
    hold off;
end

