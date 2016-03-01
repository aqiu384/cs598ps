function lec6_slide51()
    v = VideoReader('hands.mp4');
    HEIGHT = v.Height;
    WIDTH = v.Width;
    
    s = struct('frame', zeros(HEIGHT, WIDTH, 3));
    
    k = 1;
    while hasFrame(v)
        s(k).frame = readFrame(v);
        k = k + 1;
    end
    
    frames = zeros(HEIGHT * WIDTH, length(s));
    
    NUM = length(s);
    
    for i = 1:NUM
        frames(:, i) = reshape(double(rgb2gray(s(i).frame)), [HEIGHT * WIDTH, 1]);
    end
    
    [U, S, V] = svds(frames, 3);
    % PCAS = S(1:3, 1:3) * transpose(V(:, 1:3));
    PCAS = S(1:3, 1:3)^-0.5 * U(:, 1:3)' * frames;
        
    subplot(131);
    imshow(reshape(mat2gray(U(:, 1)), [HEIGHT, WIDTH]));
    colormap gray;
    subplot(132);
    imshow(reshape(mat2gray(U(:, 2)), [HEIGHT, WIDTH]));
    colormap gray;
    subplot(133);
    imshow(reshape(mat2gray(U(:, 3)), [HEIGHT, WIDTH]));
    colormap gray;
    figure(2);
    plot(1:NUM, PCAS(1, :), 1:NUM, PCAS(2, :), 1:NUM, PCAS(3, :));
end

