clc
clear
% MATLAB script for Illustrative Problem 2.9.
N=1000;                         % The maximum value of n
M=50;
Rxav=zeros(1,M+1);
Ryav=zeros(1,M+1);
Sxav=zeros(1,M+1);
Syav=zeros(1,M+1);
for i=1:10                % Take the ensemble average over ten realizations.
   X=rand(1,N)-(1/2);            % Generate a uniform number sequence on (-1/2,1/2).
   Y(1)=0;
   for n=2:N, Y(n)=0.9*Y(n-1)+X(n); end; %#ok<SAGROW> % Note that Y(n) means Y(n-1).
   Rx=Rx_est(X,M);           % autocorrelation of {Xn}
   Ry=Rx_est(Y,M);           % autocorrelation of {Yn}
   Sx=fftshift(abs(fft(Rx)));            % power spectrum of {Xn}
   Sy=fftshift(abs(fft(Ry)));            % power spectrum of {Yn} 
   Rxav=Rxav+Rx;
   Ryav=Ryav+Ry;
   Sxav=Sxav+Sx;
   Syav=Syav+Sy; 
   echo off ;
end;
echo on ;
Rxav=Rxav/10;
Ryav=Ryav/10;
Sxav=Sxav/10;
Syav=Syav/10;
% Plotting commands follow
figure
subplot(1,2,1)
plot(Rxav);
xlabel('m');
ylabel('Rx(m)');
subplot(1,2,2);
plot(Ryav);
xlabel('m');
ylabel('Ry(m)');

figure
subplot(1,2,1)
plot(Sxav);
axis([0 51 0 0.16]);
xlabel('f');
ylabel('Sx(f)');
subplot(1,2,2);
plot(Syav);
xlabel('f');
ylabel('Sy(f)');



