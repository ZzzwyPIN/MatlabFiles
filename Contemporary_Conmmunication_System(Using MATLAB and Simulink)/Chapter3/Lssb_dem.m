% lssb_dem.m
% Matlab demonstration script for LSSB-AM demodulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise. 
echo on 
t0=.15;                              	% signal duration
ts=1/1500;                           	% sampling interval
fc=250;                              	% carrier frequency
fs=1/ts;                             	% sampling frequency
df=0.25;                             	% desired freq.resolution
t=[0:ts:t0];                         	% time vector
% the message vector
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier vector
udsb=m.*c;                           	% DSB modulated signal
[UDSB,udsb,df1]=fftseq(udsb,ts,df);  	% Fourier transform
UDSB=UDSB/fs;                        	% scaling
n2=ceil(fc/df1);                     	% location of carrier in freq. vector
% remove the upper sideband from DSB
UDSB(n2:length(UDSB)-n2)=zeros(size(UDSB(n2:length(UDSB)-n2)));
ULSSB=UDSB;                          	% generate LSSB-AM spectrum
[M,m,df1]=fftseq(m,ts,df);           	% spectrum of the message signal
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(M)-1)]-fs/2;    	% frequency vector
u=real(ifft(ULSSB))*fs;              	% generate LSSB signal from spectrum
% mixing
y=u.*cos(2*pi*fc*[0:ts:ts*(length(u)-1)]);	
[Y,y,df1]=fftseq(y,ts,df);           	% spectrum of the output of the mixer
Y=Y/fs;                              	% scaling
f_cutoff=150;                        	% choose the cutoff freq. of the filter
n_cutoff=floor(150/df);              	% design the filter
H=zeros(size(f));                    
H(1:n_cutoff)=4*ones(1,n_cutoff);    
% spectrum of the filter output
H(length(f)-n_cutoff+1:length(f))=4*ones(1,n_cutoff);
DEM=H.*Y;			     	% spectrum of the filter output
dem=real(ifft(DEM))*fs;              	% filter output
pause % Press a key to see the effect of mixing
clf
subplot(3,1,1)
plot(f,fftshift(abs(M)))
title('Spectrum of the the Message Signal')
xlabel('Frequency')
subplot(3,1,2)
plot(f,fftshift(abs(ULSSB)))
title('Spectrum of the Modulated Signal')
xlabel('Frequency')
subplot(3,1,3)
plot(f,fftshift(abs(Y)))
title('Spectrum of the Mixer Output')
xlabel('Frequency')
pause % Press a key to see the effect of filtering on the mixer output
clf
subplot(3,1,1)
plot(f,fftshift(abs(Y)))
title('Spectrum of the Mixer Output')
xlabel('Frequency')
subplot(3,1,2)
plot(f,fftshift(abs(H)))
title('Lowpass Filter Characteristics')
xlabel('Frequency')
subplot(3,1,3)
plot(f,fftshift(abs(DEM)))
title('Spectrum of the Demodulator output')
xlabel('Frequency')
pause % Press a key to see the message and the demodulator output signals
subplot(2,1,1)
plot(t,m(1:length(t)))
title('The Message Signal')
xlabel('Time')
subplot(2,1,2)
plot(t,dem(1:length(t)))
title('The Demodulator Output')
xlabel('Time')
