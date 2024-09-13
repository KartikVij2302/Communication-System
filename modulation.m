function x4t = modulation(x3t,time_vector)
    fc = 1e6;
    % ct = cos(2*pi*fc*time_vector);
    x4t = x3t.*cos(2*pi*fc*time_vector);
end