function lec3_slide49()
    [samples, sample_freq] = audioread('49.mp3');
    len_samples = length(samples);
    max_freq = sample_freq / 2;
    max_time = len_samples / sample_freq;
    
    decimated_samples = samples(1:8:length(samples));
    
    blo = fir1(34, 0.125); % Lowpass at 1/8th as per Piazza instructions
    low_pass = filter(blo, 1, samples);
    filtered_samples = low_pass(1:8:length(low_pass));
        
    original = my_spectrogram(samples, 512);
    decimated = my_spectrogram(decimated_samples, 512);
    filtered = my_spectrogram(filtered_samples, 512);
    
    figure('name', 'lec3_slide49');
    subplot(311);
    imagesc([0, max_time], [0, max_freq / 2], original(1:end / 2, :)), set(gca, 'YDir', 'normal');
    title('Input');
    subplot(312);
    imagesc([0, max_time], [0, max_freq / 8], decimated), set(gca, 'YDir', 'normal');
    title('Decimated');
    subplot(313);
    imagesc([0, max_time], [0, max_freq / 8], filtered), set(gca, 'YDir', 'normal');
    title('Filtered & Decimated');
end

