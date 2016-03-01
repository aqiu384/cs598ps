function lec10_slide42()
    rng(0, 'twister'); 
    NUM = 20;

    blue = [randn(NUM ,1) + 1.5, randn(NUM, 1) + 1]';
    red = [randn(NUM, 1), randn(NUM, 1)]';
    
    combined = [-red, blue];
    constant = [-ones(1, NUM), ones(1, NUM)];
    
    H = zeros(2 * NUM + 3);
    H(1, 1) = 1;
    H(2, 2) = 1;
    
    f = ones(2 * NUM + 3, 1);
    f(1:3, 1) = 0;
    
    A = -[combined', constant'];
    A = [A, -eye(2 * NUM); zeros(2 * NUM, 3), -eye(2 * NUM)];

    b = [-ones(2 * NUM, 1); zeros(2 * NUM, 1)];
    
    x = quadprog(H, f, A, b);
    
    X = -3:0.1:3;
    Y = (x(1) * X + x(3)) / -x(2);
    Y_neg = (x(1) * X + x(3) + 1) / -x(2);
    Y_pos = (x(1) * X + x(3) - 1) / -x(2);
    
    red_dist = red' * [x(1); x(2)] + x(3);
    blue_dist = blue' * [x(1); x(2)] + x(3);
    
    figure('Name', 'Lecture 10: Slide 42');
    subplot(121);
    scatter(blue(1, :), blue(2, :));
    hold on;
    scatter(red(1, :), red(2, :));
    plot(X, Y);
    plot(X, Y_pos);
    plot(X, Y_neg);
    hold off;
    
    subplot(122);
    stem([red_dist; blue_dist]);
end

