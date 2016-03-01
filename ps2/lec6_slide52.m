function lec6_slide52()
    v = VideoReader('hands.mp4');
    HEIGHT = v.Height;
    WIDTH = v.Width;
    
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
        X(:, i) = reshape(mat2gray(rgb2gray(s(i).frame)), [HEIGHT * WIDTH, 1]);
    end
    
    % X = bsxfun(@minus, X, mean(frames, 1));
    X = bsxfun(@minus, X, mean(X, 1));
    [U, S, V] = svds(X, 3);
    W_pca = -1 * S(1:DIM, 1:DIM)^-1 * U(:, 1:DIM)';
    X = W_pca * X;
        
    tol = 1e-8;
    mu = 1e-1;
    Wi = eye(DIM);
    while 1
        Y = Wi * X;
        del_W = (NUM * (eye(DIM)) - (Y.^3 * Y.')) * Wi / NUM;
        maxed = max(abs(del_W(:)));
        disp(maxed)
        
        if all(maxed < tol)
            disp(del_W);
            break
        end
        
        Wi = Wi + mu .* del_W;
    end
    
    frames = (Wi * W_pca)';
    ICAS = Wi * X;
    
    disp(size(ICAS));
    
    subplot(131);
    imshow(reshape(mat2gray(frames(:, 1)), [HEIGHT, WIDTH]));
    subplot(132);
    imshow(reshape(mat2gray(frames(:, 2)), [HEIGHT, WIDTH]));
    subplot(133);
    imshow(reshape(mat2gray(frames(:, 3)), [HEIGHT, WIDTH]));
    figure(2);
    plot(1:NUM, mat2gray(ICAS(1, :)) + 2, 1:NUM, mat2gray(ICAS(2, :)) + 4, 1:NUM, mat2gray(ICAS(3, :)) + 6);
    
%     [U, ~, ~] = svd(X);
%     trans_3 = transpose(U(:, 1:DIM));
%     
%     X = trans_3 * X;
%     MAX = max(X(:));
%     MIN = min(X(:));
%     X = (X - MIN) / (MAX - MIN) - 0.5;
%     
%     tol = 1e-10;
%     mu = 1e-2;
%     Wi = eye(DIM);
%     while 1
%         Y = Wi * X;
%         del_W = (1/(NUM))*(NUM.*(eye(DIM)) - (Y.^3 * Y.')) * Wi;
%         maxed = max(abs(del_W(:)));
%         disp(maxed);
%         
%         if maxed < tol
%             break
%         end
%         
%         Wi = Wi + mu .* del_W;
%     end
%     
%     frames = Wi * X;
%     frames = (frames + 0.5) * (MAX - MIN) + MIN;
%     frames = trans_3' * frames;
%     
%     subplot(131);
%     imshow(reshape(mat2gray(frames(:, 1)), [HEIGHT, WIDTH]));
%     subplot(132);
%     imshow(reshape(mat2gray(frames(:, 2)), [HEIGHT, WIDTH]));
%     subplot(133);
%     imshow(reshape(mat2gray(frames(:, 3)), [HEIGHT, WIDTH]));
end

