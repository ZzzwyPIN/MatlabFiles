function y=normal(x,m,s)
% FUNCTION y=NORMAL(x,m,s)
% Gaussian distribution
% m=mean
% s=standard deviation
y=(1/sqrt(2*pi*s^2))*exp(-((x-m).^2)/(2*s^2));

