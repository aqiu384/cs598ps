function lec8_slide30()
    [input, input_freq] = audioread('pa.wav');
    [template, temp_freq] = audioread('shot.wav');
    
    input_pad = cat(1, input, zeros(length(template) - 1, 1));
    temp_pad = cat(1, template, zeros(length(input) - 1, 1));
    
    WINDOW = 200;
    
    convolved = ifft(fft(input_pad) .* fft(temp_pad));
    convolved = convolved(1:length(input));
    conv_pad = cat(1, abs(convolved), zeros(WINDOW - mod(length(convolved), WINDOW), 1));
    
    filtered = max(reshape(conv_pad, [WINDOW, length(conv_pad) / WINDOW]));
        
    figure('Name', 'Lecture 8: Slide 30');
    plot((1:length(input)) / input_freq, input);
    hold on;
    plot((1:length(filtered)) / temp_freq * WINDOW, exp(6 * mat2gray(filtered)) / 200);
    hold off;
    axis([0, 22, -Inf, Inf]);
end

