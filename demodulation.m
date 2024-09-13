function y3t = demodulation(y4t,time_vector)
    fc = 1e6;
    a = 2;
    y = y4t.*cos(2*pi*fc*time_vector);
    y3t = a*lowpass(y,1/(8*3));
end