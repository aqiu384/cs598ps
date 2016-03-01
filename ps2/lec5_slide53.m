function lec5_slide53()
    load('faces.mat');
    HEIGHT = M;
    WIDTH = N;
    NUM = 600;
    NUM_PATCHES = 10;
    DIM = 16;
    
    patches = zeros(100, NUM_PATCHES);
    C = randi([1, NUM], 1, NUM_PATCHES);
    Xer = randi([1, HEIGHT - 9], 1, NUM_PATCHES);
    Yer = randi([1, WIDTH - 9], 1, NUM_PATCHES);
    
    for i = 1:NUM_PATCHES
        x = Xer(i);
        y = Yer(i);
        rand_img = reshape(X(:, C(i)), HEIGHT, WIDTH);
        rand_patch = rand_img(x:x + 9, y:y + 9);
        patches(:, i) = reshape(rand_patch, [100, 1]);
    end
%     HEIGHT = M;
%     WIDTH = N;
%     NUM = 1000;
%     
%     patches = zeros(100, NUM);
%     C = randi([1, 600], 1, NUM);
%     Xer = randi([1, HEIGHT - 9], 1, NUM);
%     Yer = randi([1, WIDTH - 9], 1, NUM);
%     
%     for i = 1:1000
%         x = Xer(i);
%         y = Yer(i);
%         patches(:, i) = reshape(PICS(C(i), x:x + 9, y:y + 9), [100, 1])';
%     end
    
    [U, S, V] = svd(patches);
    
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
    MIN = min(eigen_patches(:));
    MAX = max(eigen_patches(:));
    
    for i = 1:SX * SY
        subplot(10, 5, i);
        imagesc(reshape(eigen_patches(:, i), [10, 10]));
    end
end

