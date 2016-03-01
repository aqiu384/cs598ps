function lec5_slide52()
    rng(0, 'twister');

    load('faces.mat');
    HEIGHT = M;
    WIDTH = N;
    NUM = 1000;
    X = reshape(X, [600, HEIGHT, WIDTH]);
    
    patches = zeros(100, NUM);
    C = randi([1, 600], 1, NUM);
    Xer = randi([1, HEIGHT - 9], 1, NUM);
    Yer = randi([1, WIDTH - 9], 1, NUM);
    
    for i = 1:1000
        x = Xer(i);
        y = Yer(i);
        patches(:, i) = reshape(X(C(i), x:x + 9, y:y + 9), [100, 1])';
    end
    
    [U, S, V] = svds(patches, 50);
    
    SX = 10;
    SY = 5;
    GAP = 0.01;
    
%     for i = 1:SX
%         for j = 1:SY
%             subplot('Position', [(i - 1)/SX + GAP, 1 - j/SY + GAP, 1/SX - GAP, 1/SY - GAP]);
%             
%             index = (i - 1) * SX + j;
%             disp(index);
%             MIN = min(U(:, index));
%             MAX = max(U(:, index));
% 
%             normalized = (U(:, index) - MIN) / (MAX - MIN);
%             imshow(reshape(normalized, [10, 10]));
%         end
%     end


    eigen_patches = U(:, 1:50);
    global_min = min(U(:, 1:50
    
    for i = 1:SX * SY
        subplot(10, 5, i);
        imshow(reshape(U(:, i), [10, 10]));
    end
end

