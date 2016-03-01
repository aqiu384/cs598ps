function lec8_slide46()
    load('one.mat');
    [HEIGHT, WIDTH] = size(one);
    
    white_one = [zeros(HEIGHT, WIDTH), one, zeros(HEIGHT, WIDTH)];
    black_one = max(white_one(:)) - white_one;
    
    laplacian = ones(3) / -8;
    laplacian(2, 2) = 1;
    
    filter_grad = abs(conv2(one, laplacian, 'same'));
    white_grad = abs(conv2(white_one, laplacian, 'same'));
    black_grad = abs(conv2(black_one, laplacian, 'same'));
    black_grad = black_grad(2:end - 1, 2:end - 1);
    
    white_filter = conv2(white_grad, filter_grad, 'same');
    black_filter = conv2(black_grad, filter_grad, 'same');
    
    [~, ind_xb] = max(max(black_filter));
    [~, ind_yb] = max(max(black_filter, [], 2));
    
    [~, ind_xw] = max(max(white_filter));
    [~, ind_yw] = max(max(white_filter, [], 2));
    
    CONST = 1;
    
    figure('Name', 'Lecture 8: Slide 46');
    colormap gray;
    subplot(331);
    imagesc(one);
    axis equal;
    subplot(332);
    imagesc(white_one);
    axis equal;
    subplot(333);
    imagesc(black_one);
    axis equal;
    subplot(334);
    imagesc(filter_grad);
    axis equal;
    subplot(335);
    imagesc(white_grad);
    axis equal;
    subplot(336);
    imagesc(black_grad);
    axis equal;
    subplot(338);
    imagesc((CONST * white_filter));
    hold on;
    scatter(ind_xw, ind_yw, 'r', 'filled');
    hold off;
    axis equal;
    subplot(339);
    imagesc((CONST * black_filter));
    hold on;
    scatter(ind_xb, ind_yb, 'r', 'filled');
    hold off;
    axis equal;
end

