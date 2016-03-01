function values = my_spectrogram(samples, dft_size)
    DFT_SIZE = dft_size;
    OVERLAP = 0.25;
    PADDING = DFT_SIZE * (1 - OVERLAP);
    HANN_WINDOW = transpose(0.5 * (1 - cos(2 * pi * linspace(0, DFT_SIZE - 1, DFT_SIZE) / (DFT_SIZE - 1))));
        
    len_samples = length(samples);
    samples = samples(:);
    samples(end + 1:end + DFT_SIZE) = 0;
    
    bin_count = floor(len_samples / PADDING);
    new_samples = zeros(DFT_SIZE, bin_count);
        
    for index = 1:bin_count
        offset = 1 + PADDING * (index - 1);
        new_samples(:, index) = samples(offset:offset + DFT_SIZE - 1) .* HANN_WINDOW;
    end
    
    dft_samples = fft(new_samples);
    values = log(abs(dft_samples(1:end / 2, :)) + 1);    
end

