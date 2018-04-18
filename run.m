t = 0:0.01:1.5;
y = cos(2*pi*t);
y1 = adpcm_encoder(y);
y2 = adpcm_decoder(y1);
Z = y2-y;
subplot(2,2,1)
plot(t,y)
title('输入模拟信号y');
subplot(2,2,2)
stem(t,y1)
title('ADPCM编码');
subplot(2,2,3)
plot(t,y2)
title('ADPCM解码');
subplot(2,2,4)
plot(t,Z)
title('误差');
