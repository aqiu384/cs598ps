function lec9_slide34()
    rng(0, 'twister'); 
    NUM = 200;
    RANGE = -10:0.2:5;
    RANGE_LEN = length(RANGE);
    
    ANGLE = pi / 4;
    ROTATION = [cos(ANGLE), -sin(ANGLE); sin(ANGLE), cos(ANGLE)];
    
    [X, Y] = meshgrid(RANGE, RANGE);
    grid = cat(3, X, Y);
            
    blue = [randn(NUM ,1), randn(NUM, 1)]';
    red = ROTATION * [3 * randn(NUM ,1), 0.5 * randn(NUM, 1)]' - 3;
        
    blue_sigma = cov(blue');
    red_sigma = cov(red');
    
    blue_mu = mean(blue, 2);
    red_mu = mean(red, 2);
    
    blue_g = zeros(RANGE_LEN);
    red_g = zeros(RANGE_LEN);
    
    for i = 1:RANGE_LEN
        for j = 1:RANGE_LEN
            point = squeeze(grid(i, j, :));
            
            blue_point = point - blue_mu;
            blue_g(i, j) = -0.5 * blue_point' * inv(blue_sigma) * blue_point + log(0.5) - 0.5 * log(det(blue_sigma));
            
            red_point = point - red_mu;
            red_g(i, j) = -0.5 * red_point' * inv(red_sigma) * red_point + log(0.5) - 0.5 * log(det(red_sigma));
        end
    end
    
    bound_g = zeros(RANGE_LEN);
    bound_g(red_g > blue_g) = 1;
    
    figure('Name', 'Lecture 9: Slide 34A');
    hold on;
    contourf(grid(:, :, 1), grid(:, :, 2), bound_g, 1);
    contour(grid(:, :, 1), grid(:, :, 2), blue_g, -5:0);
	contour(grid(:, :, 1), grid(:, :, 2), red_g, -5:0);
    scatter(blue(1, :), blue(2, :));
    scatter(red(1, :), red(2, :), 'r');
    axis equal;
    hold off;
end

