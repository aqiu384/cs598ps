function lec11_slide24()
    rng(0, 'twister'); 
    
    NUM = 100;
    base_blue = randn(2, NUM) + 4;
    red = [randn(2, NUM - 1), [2.3; 2.3]];
    
    inc = [0, -1.8, -3];

    figure('Name', 'Lecture 11: Slide 24');
    for j = 1:3
        STEP = 0.5;

        blue = base_blue + inc(j);
        points = [blue, red];

        XRANGE = -4:STEP:8;
        YRANGE = -4:STEP:8;

        RNUM = length(XRANGE) * length(YRANGE);
        [X, Y] = meshgrid(XRANGE, YRANGE);

        XR = kron(reshape(X, [], 1), ones(1, 2 * NUM));
        YR = kron(reshape(Y, [], 1), ones(1, 2 * NUM));

        XP = kron(points(1, :), ones(RNUM, 1));
        YP = kron(points(2, :), ones(RNUM, 1));

        [~, inds] = sort((XP - XR) .^ 2 + (YP - YR) .^ 2, 2);

        RB = [ones(RNUM, NUM), -ones(RNUM, NUM)];

        for i = 1:RNUM
            temp = RB(i, :);
            RB(i, :) = temp(inds(i, :));
        end

        neighs = [1, 3, 5, 11, 21, 99];

        XLEN = length(XRANGE);
        YLEN = length(YRANGE);

        for i = 1:6
            FAIL = sum(RB(:, 1:neighs(i)), 2);
            FAIL = reshape(FAIL, XLEN, YLEN);

            subplot(3, 6, 6 * (j - 1) + i);
            hold on;
            contourf(X, Y, FAIL, 1);
            scatter(blue(1, :), blue(2, :));
            scatter(red(1, :), red(2, :));
            hold off;
            axis equal;
        end
    end
end

