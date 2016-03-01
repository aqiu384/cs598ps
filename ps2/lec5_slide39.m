function lec5_slide39()
    load('faces.mat');
    HEIGHT = M;
    WIDTH = N;
    
    SQUARE = 6;    
    [U, S, V] = svd(X);
    
    down_50 = V(11, 1:50)';
    back_50 = U(:, 1:50) * S(1:50, 1:50) * down_50;
    
    down_13 = V(11, 1:13)';
    back_13 = U(:, 1:13) * S(1:13, 1:13) * down_13;
   
    subplot(161);
    imshow(my_mat2gray(reshape(X(:, 11), [HEIGHT, WIDTH])));
    subplot(162);
    imshow(my_mat2gray(log(abs(down_50) + 1)));
    subplot(163);
    imshow(my_mat2gray(reshape(back_50, [HEIGHT, WIDTH])));
    subplot(164);
    imshow(my_mat2gray(reshape(X(:, 11), [HEIGHT, WIDTH])));
    subplot(165);
    imshow(my_mat2gray(log(abs(down_13) + 1)));
    subplot(166);
    imshow(my_mat2gray(reshape(back_13, [HEIGHT, WIDTH])));
end

