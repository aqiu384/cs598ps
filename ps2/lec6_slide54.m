function lec6_slide54()
    rng(0, 'twister');
    
    v = VideoReader('hands.mp4');
    HEIGHT = v.Height;
    WIDTH = v.Width;
    RANK = 2;
    
    s = struct('frame', zeros(HEIGHT, WIDTH, 3));
    
    k = 1;
    while hasFrame(v)
        s(k).frame = readFrame(v);
        k = k + 1;
    end
    
    X = zeros(HEIGHT * WIDTH, length(s));
    
    NUM = length(s);
    DIM = 3;
    
    for i = 1:NUM
        X(:, i) = reshape(im2double(rgb2gray(s(i).frame)), [HEIGHT * WIDTH, 1]);
    end
    
    W = rand(HEIGHT * WIDTH, RANK) + 10;
    H = rand(RANK, NUM) + 10;
            
    for i = 1:1000
        W = X * pinv(H);
        W = max(W, 0);
        H = pinv(W) * X;
        H = max(H, 0);
        disp(i);
    end

    subplot(121);
    imshow(mat2gray(reshape(W(:, 1), [HEIGHT, WIDTH])));
    subplot(122);
    imshow(mat2gray(reshape(W(:, 2), [HEIGHT, WIDTH])));
    figure(2);
    plot(1:NUM, H(1, :), 1:NUM, H(2, :));
end

