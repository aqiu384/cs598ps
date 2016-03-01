function lec6_slide45()
    rng(0, 'twister');
    RANK = 2;
    
    X = ones(100, 200);
    X(6:25, 1:25) = 255;
    X(6:25, 51:90) = 255;
    X(6:25, 131:160) = 255;
    X(6:25, 186:200) = 255;
    X(81:90, 21:40) = 255;
    X(81:90, 81:120) = 255;
    X(81:90, 151:180) = 255;
    
    W = rand(100, RANK) + 10;
    H = rand(RANK, 200) + 10;
            
    for i = 1:1000
        W = X * pinv(H);
        W = max(W, 0);
        H = pinv(W) * X;
        H = max(H, 0);
        disp(i);
    end

    subplot(121);
    imagesc(H);
    subplot(122);
    imagesc(W);
end

