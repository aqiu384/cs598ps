function lec3_slide21()
    MAT_SIZE = 32;

    function M = dft_mat(mat_size)
        temp_row = 0:(mat_size - 1);
        temp_square =  transpose(temp_row) * temp_row * 2 * pi / mat_size;
        M = cos(temp_square) + 1i * sin(temp_square);
    end

    X = meshgrid(1:32) * pi / 16;
    Y = fliplr(transpose(X));
    
    mat = dft_mat(MAT_SIZE);
    sin3x = sin(3 * X);
    sin5y = sin(5 * Y);
    sin3xy = sin(3 * (X + Y));
    sin6x8y = sin3xy + sin(6 * X + 8 * Y);
    
    colormap(1 - gray);
    
    figure('name', 'lec3_slide21');
    subplot(241);
    imagesc(sin3x);
    title('sin(3x)');
    subplot(242);
    imagesc(log(abs(mat * sin3x * mat) + 1));
    subplot(243);
    imagesc(sin5y);
    title('sin(5y)');
    subplot(244);
    imagesc(log(abs(mat * sin5y * mat) + 1));
    subplot(245);
    imshow(sin3xy);
    title('sin(3(x + y))');
    subplot(246);
    imshow(abs(mat * sin3xy * mat));
    subplot(247);
    imshow(sin6x8y);
    title('sin(3(x + y)) + sin(6x + 8y)');
    subplot(248);
    imshow(abs(mat * sin6x8y * mat));
end

