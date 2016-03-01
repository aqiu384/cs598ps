function lec3_slide18()
    [samples, sample_freq] = audioread('18.wav');
    len_samples = length(samples);
    max_freq = sample_freq / 2;
    max_time = len_samples / sample_freq;
    
    spect64 = my_spectrogram(samples, 64);
    spect512 = my_spectrogram(samples, 512);
    spect2048 = my_spectrogram(samples, 2048);
    
    figure('name', 'lec3_slide18');
    subplot(311);
    imagesc([0, max_time], [0, max_freq], spect64), set(gca, 'YDir', 'normal');
    title('Small Window, N = 64');
    subplot(312);
    imagesc([0, max_time], [0, max_freq], spect512), set(gca, 'YDir', 'normal');
    title('Medium Window, N = 512');
    subplot(313);
    imagesc([0, max_time], [0, max_freq], spect2048), set(gca, 'YDir', 'normal');
    title('Large Window, N = 2048');
end

