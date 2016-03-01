function lec4_slide53()
    img = im2double(imread('53.png'));
    
    SIGMA = 15;
    SIZE = SIGMA * 3;
    [X, Y] = meshgrid(-SIZE:SIZE, -SIZE:SIZE);
    base_filter = exp((X.^2 + Y.^2) / (-2 * SIGMA^2)) / (2 * pi * SIGMA^2);
    
    ker_0 = zeros(size(base_filter));
    ker_90 = zeros(size(base_filter));
    
    ker_0(:, SIZE - 1:SIZE + 1) = base_filter(:, SIZE - 1:SIZE + 1);
    ker_90(SIZE - 1:SIZE + 1, :) = base_filter(SIZE - 1:SIZE + 1, :);
    ker_45 = diag(diag(base_filter, -1), -1) + diag(diag(base_filter)) + diag(diag(base_filter, 1), 1);
    ker_135 = fliplr(ker_45);
    
    resp_0 = conv2(img, ker_0, 'same');
    resp_45 = conv2(img, ker_45, 'same');
    resp_90 = conv2(img, ker_90, 'same');
    resp_135 = conv2(img, ker_135, 'same');
    
    figure('name', 'lec4_slide53');
    subplot(151);
    imshow(img);
    title('Input');
    subplot(152);
    imagesc(resp_0), axis image;
    title('Response 0');
    subplot(153);
    imagesc(resp_90), axis image;
    title('Response 90');
    subplot(154);
    imagesc(resp_45), axis image;
    title('Response 45');
    subplot(155);
    imagesc(resp_135), axis image;
    title('Response -45');
end

