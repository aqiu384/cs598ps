function lec3_slide46()
    img = im2double(imread('46.jpg'));
    img = imresize(img, [174, 205]); % imresize required since input image does not match size given in slides
    
    bright_filter = exp(linspace(-2, 2, 205).^2 / -2) / (2 * pi)^0.5 * 4;
    img_bright = img;
    img_random = img;
    
    CONST1 = 0.05;
    CONST2 = 2 * CONST1;
    CONST3 = 3 * CONST1;
    SOLID = 1;
    
    for row = 1:174
        for channel = 1:3
            img_bright(row, :, channel) = img(row, :, channel) .* bright_filter;
        end
        for col = 1:205
            chance = rand;
            if CONST2 <= chance && chance < CONST3
                img_random(row, col, 1) = SOLID;
            elseif CONST1 <= chance && chance < CONST2
                img_random(row, col, 2) = SOLID;
            elseif chance < CONST1
                img_random(row, col, 3) = SOLID;
            end
        end
    end

    SIGMA = 4;
    SIZE = SIGMA * 3;
    X = meshgrid(-SIZE:SIZE);
    Y = fliplr(transpose(X));
    
    gauss_filter = exp((X.^2 + Y.^2) / (-2 * SIGMA^2)) / (2 * pi * SIGMA^2);
    
    SIGMA = 1;
    SIZE = SIGMA * 3;
    X = meshgrid(-SIZE:SIZE);
    Y = fliplr(transpose(X));
    
    denoise_filter = exp((X.^2 + Y.^2) / (-2 * SIGMA^2)) / (2 * pi * SIGMA^2);
    
    SIZE = 20;
    diagonal_filter = horzcat(eye(SIZE), fliplr(eye(SIZE))) / SIZE / 2;
    
    peak_filter = ones([1, SIZE * 2 + 1]);
    peak_filter(21) = -80;
    peak_filter = peak_filter / -40;
    
    img_gauss = zeros(size(img));
    img_denoise = zeros(size(img));
    img_diagonal = zeros(size(img));
    img_peak = zeros(size(img));
    
    for channel = 1:3
        img_gauss(:, :, channel) = conv2(img(:, :, channel), gauss_filter, 'same');
        img_denoise(:, :, channel) = conv2(img_random(:, :, channel), denoise_filter, 'same');
        img_diagonal(:, :, channel) = conv2(img(:, :, channel), diagonal_filter, 'same');
        img_peak(:, :, channel) = conv2(img_bright(:, :, channel), peak_filter, 'same');
    end
    
    figure('name', 'lec3_slide46');
    subplot(2, 6, 1);
    imshow(img);
    subplot(2, 6, 2);
    imagesc(gauss_filter);
    subplot(2, 6, 3);
    imshow(img_gauss);
    subplot(2, 6, 4);
    imshow(img_random);
    subplot(2, 6, 5);
    imagesc(denoise_filter);
    subplot(2, 6, 6);
    imshow(img_denoise);
    subplot(2, 6, 7);
    imshow(img);
    subplot(2, 6, 8);
    imagesc(diagonal_filter);
    subplot(2, 6, 9);
    imshow(img_diagonal);
    subplot(2, 6, 10);
    imshow(img_bright);
    subplot(2, 6, 11);
    stem(peak_filter);
    subplot(2, 6, 12);
    imshow(img_peak);
end

