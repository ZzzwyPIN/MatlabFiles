clc
clear
% MATLAB script for Illustrative Problem 2.7.
echo on
N=256;                  % number of samples
deltaf=0.1;             % frequency separation
f=[0:deltaf:(N/2)*deltaf, -(N/2-1)*deltaf:deltaf:-deltaf];
% f=0:deltaf:(N-1)*deltaf;
                        % Swap the first half.
Sy=1./(1+(2*pi*f).^2);          % sampled spectrum
Ry=ifft(Sy);                % autocorrelation of Y
% Plotting command follows.
plot(fftshift(abs(Ry)));  %ע��fftshiftָ���ʹ���Լ�realȡʵ����ʹ�á� %?Ϊʲôȡabs��ȡreal�Ľ����һ���ģ�
