function lec1_slide47()
    img = imread('allen.jpg');
    [width, height, depth] = size(img);
        
    img1d = double(reshape(img, [width * height * depth, 1]));
    no_green = kron(kron(diag([1, 0, 1]), eye(height)), eye(width)) * img1d;
    flipped = kron(kron(eye(depth), fliplr(eye(height))), eye(width)) * no_green;
    swapped = kron(kron(eye(depth), eye(height)), kron([0, 1; 1, 0], eye(width / 2))) * flipped;
    new_img = uint8(reshape(swapped, size(img)));
    
    figure('name', 'lec1_slide47');
    subplot(121);
    imshow(img);
    subplot(122);
    imshow(new_img);
end

