% MATLAB script for Illustrartive Problem 8, Chapter 1.
ts=0.001;                          
fs=1/ts;                           
t=[0:ts:10];                       
x=cos(2*pi*47*t)+cos(2*pi*219*t);  
p=spower(x);                        
psd=spectrum(x,1024);              
pause   % Press a key to see the power in the signal.
p
pause   % Press a key to see the power spectrum.
specplot(psd,fs)
