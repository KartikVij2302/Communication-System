function x3t = line_coding(x2t)
m=1;
a = 0.5;
length = 18; 
[transmit_filter, ~] = raised_cosine(a, m, length);
x3t = conv(x2t, transmit_filter, 'same');
end
