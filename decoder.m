function y1t = decoder(y3t,plotter)

    a = 0.5;
    length = 20;
    m = 30;

    transmit_filter = raised_cosine(a, m, length);
    % transmit_filter = ones(m,1);
    
    receiver_filter = conj(flipud(transmit_filter));

    received = conv(y3t, receiver_filter, 'same');   
    length = numel(received);
    y2t=received(1:m:length);

    % figure(7);
    % stem(plotter,y2t);
    % xlabel('t');
    % xlim([0 10000/(length/m)]);
    % ylabel('y2t');
    % title('Y2t with raised cosine, 2nd channel');
    % disp(size(y2t));
    y1t = (y2t <= 0);

end