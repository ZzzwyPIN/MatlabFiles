% dsb_dem.m
% Matlab demonstration script for DSB-AM demodulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.
echo on
t0=.15;                              	% signal duration
ts=1/1500;                           	% sampling interval
fc=250;                              	% carrier frequency
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df=0.3;                              	% desired frequency resolution
% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
u=m.*c;                              	% modulated signal
y=u.*c;		                     	% mixing
[M,m,df1]=fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
[U,u,df1]=fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
[Y,y,df1]=fftseq(y,ts,df);           	% Fourier transform
Y=Y/fs;                              	% scaling
f_cutoff=150;                        	% cutoff freq. of the filter
n_cutoff=floor(150/df1);             	% design the filter
f=[0:df1:df1*(length(y)-1)]-fs/2;
H=zeros(size(f));                    
H(1:n_cutoff)=2*ones(1,n_cutoff);    
H(length(f)-n_cutoff+1:length(f))=2*ones(1,n_cutoff);
DEM=H.*Y;			     	% spectrum of the filter output
dem=real(ifft(DEM))*fs;		     	% filter output
pause % Press a key to see the effect of mixing
clf
subplot(3,1,1)
plot(f,fftshift(abs(M)))
title('Spectrum of the the Message Signal')
xlabel('Frequency')
subplot(3,1,2)
plot(f,fftshift(abs(U)))
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
pause % Press a key to compare the spectra of the message an the received signal
clf
subplot(2,1,1)
plot(f,fftshift(abs(M)))
title('Spectrum of the Message Signal')
xlabel('Frequency')
subplot(2,1,2)
plot(f,fftshift(abs(DEM)))
title('Spectrum of the Demodulator Output')
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
