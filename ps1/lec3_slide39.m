function lec3_slide39()
    [samples, sample_freq] = audioread('39.wav');
    len_samples = length(samples);
    max_freq = sample_freq / 2;
    max_time = len_samples / sample_freq;
    
    blo = fir1(34, 0.48); 
    bhi = fir1(34, 0.48, 'high');
    ban = fir1(48, [0.20, 0.50]);
    bst = fir1(48, [0.20, 0.50], 'stop');
    
    outhi = filter(bhi, 1, samples);
    outlo = filter(blo, 1, samples);
    outba = filter(ban, 1, samples);
    outbs = filter(bst, 1, samples);
    
    spectin = my_spectrogram(samples, 512);
    specthi = my_spectrogram(outhi, 512);
    spectlo = my_spectrogram(outlo, 512);
    spectba = my_spectrogram(outba, 512);
    spectbs = my_spectrogram(outbs, 512);
    
    figure('name', 'lec3_slide39');
    subplot(321);
    imagesc([0, max_time], [0, max_freq], spectin), set(gca, 'YDir', 'normal');
    title('Original input');
    subplot(323);
    imagesc([0, max_time], [0, max_freq], specthi), set(gca, 'YDir', 'normal');
    title('Lowpass');
    subplot(324);
    imagesc([0, max_time], [0, max_freq], spectlo), set(gca, 'YDir', 'normal');
    title('Highpass');
    subplot(325);
    imagesc([0, max_time], [0, max_freq], spectba), set(gca, 'YDir', 'normal');
    title('Bandpass');
    subplot(326);
    imagesc([0, max_time], [0, max_freq], spectbs), set(gca, 'YDir', 'normal');
    title('Band-reject');
end

