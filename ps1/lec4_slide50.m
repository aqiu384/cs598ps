function lec4_slide50()
    img0 = ones([174, 205]) * 255;
    img0(44:130, 51:154) = 200;
    img1 = zeros([174, 205]);
    img1(44:130, 51:154) = 255;
    
    kernel = [1, 1, 1; 1, -8, 1; 1, 1, 1] / -8;
    
    filtered0 = abs(conv2(img0, kernel, 'same'));
    filtered1 = abs(conv2(img1, kernel, 'same'));
    
    figure('name', 'lec4_slide50');
    subplot(221);
    imshow(uint8(img0));
    subplot(222);
    imshow(filtered0);
    subplot(223);
    imshow(uint8(img1));
    subplot(224);
    imshow(filtered1);
end

