function lec9_slide32()
    rng(0, 'twister'); 
    NUM = 200;
    XRANGE = -3:0.2:5;
    YRANGE = -3:0.2:4;
    XLEN = length(XRANGE);
    YLEN = length(YRANGE);
    
    [X, Y] = meshgrid(XRANGE, YRANGE);
    grid = cat(3, X, Y);
                
    blue = randn(2, NUM);
    red = [randn(1, NUM) + 2; randn(1, NUM) + 1];
    
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
    
    figure('Name', 'Lecture 9: Slide 32');
    hold on;
    contourf(grid(:, :, 1), grid(:, :, 2), bound_g, 1);
    contour(grid(:, :, 1), grid(:, :, 2), blue_g, -5:0);
	contour(grid(:, :, 1), grid(:, :, 2), red_g, -5:0);
    scatter(blue(1, :), blue(2, :));
    scatter(red(1, :), red(2, :), 'r');
    axis equal;
    hold off;
end

