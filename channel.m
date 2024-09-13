function y4t = channel(x4t,snr,time_vector)
        
    Eb = sum(x4t.^2)/numel(x4t);
    variance = 1;
    % disp(Eb);
    % disp(vari);
    % vari = 1;
    % total_noise =sqrt(variance)*randn(size(x4t)) + 1i* sqrt(variance)*randn(size(x4t));
    % 
    % y4t = x4t + total_noise;
    a = 0.82;
    b = 6;

    h1t = zeros(1,b+1);
    h1t(1) = a;
    h1t(b+1) = 1-a;
    total_noise =sqrt(variance)*randn(size(x4t)) + 1i* sqrt(variance)*randn(size(x4t));

    % noise_with_memory = sqrt(variance) * randn(size(x4t));
    y4t = conv(x4t, h1t, 'same') + total_noise;

end