function x3t = encoder(random_bits,plotter)
    
    oversampling_factor = 30;
    m = oversampling_factor;
    a = 0.5;
    length = 20;

    len = numel(random_bits);
    x2t = zeros(1,len);
    for i=1:len
        if random_bits(i)==1
            x2t(i) = -1;
        else
            x2t(i) = 1;
        end
    end

    % figure(2);
    % stem(plotter,x2t);
    % xlabel('t');
    % xlim([0 10000/len]);
    % ylabel('x2t');
    % title('X2t with raised cosine, 2nd channel');
    
    transmit_filter = raised_cosine(a, m, length);
    % transmit_filter = ones(m,1);
    
    nsymbols_upsampled = 1+(len-1)*m;%length of upsampled symbol sequence
    symbols_upsampled = zeros(nsymbols_upsampled,1);%initialize
    symbols_upsampled(1:m:nsymbols_upsampled)=x2t;

    x3t = conv(symbols_upsampled,transmit_filter,'same');
end