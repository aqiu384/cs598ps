function output = my_mat2gray(input)
    MIN = min(input(:));
    MAX = max(input(:));
    output = (input - MIN) / (MAX - MIN);
end

