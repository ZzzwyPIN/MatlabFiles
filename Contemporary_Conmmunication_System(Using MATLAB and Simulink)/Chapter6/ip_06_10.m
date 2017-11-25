% MATLAB script for Illustrative Problem 6.10.
echo on
T=1;
Fs=2/T;
Ts=1/Fs;
c_opt=[-2.2 4.9 -3 4.9 -2.2];
t=-5*T:T/2:5*T;			
x=1./(1+((2/T)*t).^2);		        % sampled pulse
equalized_x=filter(c_opt,1,[x 0 0]);	% since there will be a delay of two samples at the output
% to take care of the delay
equalized_x=equalized_x(3:length(equalized_x));  
% Now, let us downsample the equalizer output.
for i=1:2:length(equalized_x),
  downsampled_equalizer_output((i+1)/2)=equalized_x(i);
  echo off;
end;
echo on ;
% Plotting commands follow.