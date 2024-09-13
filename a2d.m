clc, clearvars, close;

% a2d
[audio, audio_sampling_rate] = audioread('project.wav');
audio = audio(1:3*audio_sampling_rate);
audio_normalized = int16(audio * 32767);
audio_binary = dec2bin(typecast(audio_normalized(:), 'uint16'), 16);
x1t = audio_binary(:) - '0';
snrdb = 0:1:5;
error = zeros(numel(snrdb),1);
fs = 3*1e6;
% for idx = 1:numel(snrdb)
    plotter = 1/audio_sampling_rate:1/audio_sampling_rate:length(x1t)/audio_sampling_rate;
    x3t = encoder(x1t,plotter);
    % obw(x3t)
    
    
    plotter = plotter';
    t = 0:1/fs:length(x3t)/fs - 1/fs;
    t = t';
    x4t = modulation(x3t, t);
    % obw(x4t)
    y4t = channel(x4t,1,t); 
    % obw(y4t)
    y3t = demodulation(y4t,t);
    % obw(y3t)
    y1t = decoder(y3t,plotter);
    count = 0;
    for idx1 = 1:numel(x1t)
        if(y1t(idx1) ~= x1t(idx1))
            count = count + 1;
        end
    end

    disp(count/numel(x1t));
    % error(idx) = count/numel(x1t);
    
    % figure(1);
    % stem(plotter, x1t);
    % xlabel('t');
    % xlim([0 20000/audio_sampling_rate])
    % ylabel('x1t');
    % title('X1t with raised cosine, 2nd channel');

    % figure(3);
    % stem(t,x3t);
    % xlabel('t');
    % xlim([0 10000/fs])
    % ylabel('x3t');
    % title('X3t with raised cosine, 2nd channel');
    % 
    % figure(4);
    % stem(x4t);
    % xlabel('t');
    % xlim([0 1000000/fs])
    % ylabel('x4t');
    % title('X4t with raised cosine, 2nd channel');
    % 
    % figure(5);
    % stem(t,y4t);
    % xlim([0 10000/fs])
    % xlabel('t');
    % ylabel('y4t');
    % title('Y4t with raised cosine, 2nd channel');
    % 
    % figure(6);
    % stem(t,real(y3t));
    % xlabel('t');
    % xlim([0 10000/fs])
    % ylabel('y3t');
    % title('Y3t with raised cosine, 2nd channel');
    % 
    % figure(8);
    % stem(plotter,y1t);
    % xlim([0 10000/audio_sampling_rate])
    % xlabel('t');
    % ylabel('y1t');
    % title('Y1t with raised cosine, 2nd channel');
    % 
    % figure(9);
    % plot(real(x4t),imag(x4t),'o');
    % xlabel('Real part of the signal');
    % ylabel('Imaginary part of the signal');
    % title('Constellation plot of input to channel, raised cosine, 2nd channel');
    % 
    % figure(10);
    % plot(real(y4t),imag(y4t),'o');
    % xlabel('Real part of the signal');
    % ylabel('Imaginary part of the signal');
    % title('Constellation plot of output to channel, raised cosine, 2nd channel');
    
    y1t_updated = char('0'+y1t);
    
    binary_matrix = reshape(y1t_updated, [], 16);
    audio_integers = bin2dec(binary_matrix);
    audio_reconstructed = typecast(uint16(audio_integers), 'int16');
    audio_reconstructed_normalized = double(audio_reconstructed) / 32767;
    
    % sound(audio, 48000); % Play original audio
    % pause(length(audio)/fs + 1); % Wait for audio to finish plus a little extra
    sound(audio_reconstructed_normalized, audio_sampling_rate); % Play reconstructed audio
% end
% 
% figure();
% plot(snrdb,error);
% xlabel('SNR (in dB)');
% ylabel('Bit error rate');
% title('Bit error rate vs SNR');