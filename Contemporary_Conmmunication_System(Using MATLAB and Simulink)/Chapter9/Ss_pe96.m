function [p]=ss_Pe96(rho_in_dB)
% [p]=ss_Pe96(rho_in_dB)
%		SS_PE96  finds the measured error rate. The value of
%   		signal per interference ratio in dB is given as an 
%   		input to the function.
rho=10^(rho_in_dB/10);
Eb=rho;			      		% energy per bit
if (rho>2),	
  alpha=2/rho;		      		% optimal alpha if rho>2
else
  alpha=1;		      		% optimal alpha if rho<2
end;
sgma=sqrt(1/(2*alpha));       		% noise standard deviation
N=10000;	      	      		% number of bits transmitted
% generation of the data sequence
for i=1:N,
  temp=rand;
  if (temp<0.5)
    data(i)=1;
  else
    data(i)=0;
  end;
end;
% Find the received signals.
for i=1:N,
  % the transmitted signal
  if (data(i)==0),
    r1c(i)=sqrt(Eb);
    r1s(i)=0;
    r2c(i)=0;
    r2s(i)=0;
  else
    r1c(i)=0;
    r1s(i)=0;
    r2c(i)=sqrt(Eb);
    r2s(i)=0;
  end;
  % The received signal is found by adding noise with probability alpha.
  if (rand<alpha),
    r1c(i)=r1c(i)+gngauss(sgma);
    r1s(i)=r1s(i)+gngauss(sgma);
    r2c(i)=r2c(i)+gngauss(sgma);
    r2s(i)=r2s(i)+gngauss(sgma);
  end;
end;
% Make the decisions and count the number of errors made.
num_of_err=0;
for i=1:N,
  r1=r1c(i)^2+r1s(i)^2;        	% first decision variable
  r2=r2c(i)^2+r2s(i)^2;   		% second decision variable
  % Decision is made next.
  if (r1>r2),
    decis=0;
  else
    decis=1;
  end;
  % Increment the counter if this is an error.
  if (decis~=data(i)),
    num_of_err=num_of_err+1;
  end;
end;
% measured bit error rate is then
p=num_of_err/N;