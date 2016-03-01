function lec5_slide37()
    load('faces.mat');
    HEIGHT = M;
    WIDTH = N;
    
    SQUARE = 6;    
    SX = SQUARE;
    SY = SQUARE;
    GAP = 0.01;
    
    [U, ~, ~] = svd(X);
    
    for i = 1:SQUARE
        for j = 1:SQUARE
            subplot('Position', [(i - 1)/SX + GAP, 1 - j/SY + GAP, 1/SX - GAP, 1/SY - GAP]);
            
            index = (i - 1) * SQUARE + j;
            MIN = min(U(:, index));
            MAX = max(U(:, index));

            normalized = (U(:, index) - MIN) / (MAX - MIN);
            imshow(reshape(normalized, [HEIGHT, WIDTH]));
        end
    end
end

