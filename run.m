t = 0:0.01:1.5;
y = cos(2*pi*t);
y1 = adpcm_encoder(y);
y2 = adpcm_decoder(y1);
Z = y2-y;
subplot(2,2,1)
plot(t,y)
title('����ģ���ź�y');
subplot(2,2,2)
stem(t,y1)
title('ADPCM����');
subplot(2,2,3)
plot(t,y2)
title('ADPCM����');
subplot(2,2,4)
plot(t,Z)
title('���');
