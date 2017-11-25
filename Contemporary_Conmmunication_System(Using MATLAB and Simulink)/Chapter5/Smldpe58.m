function [p]=smldPe58(snr_in_dB)
% [p]=smldPe58(snr_in_dB)
%		SMLDPE58  simulates the probability of error for the given
%   		snr_in_dB, signal to noise ratio in dB.
d=1;
SNR=exp(snr_in_dB*log(10)/10);	   	% signal to noise ratio per bit
sgma=sqrt((5*d^2)/(4*SNR));	   	% sigma, standard deviation of noise
N=10000;	 		   	% number of symbols being simulated
% Generation of the quaternary data source follows.
for i=1:N,
  temp=rand;   	      			% a uniform random variable over (0,1)
  if (temp<0.25),
    dsource(i)=0;           		% With probability 1/4, source output is "00."
  elseif (temp<0.5),
    dsource(i)=1;           		% With probability 1/4, source output is "01."
  elseif (temp<0.75),
    dsource(i)=2;           		% With probability 1/4, source output is "10."
  else
    dsource(i)=3;	      		% With probability 1/4, source output is "11."
  end
end;
% detection, and probability of error calculation
numoferr=0;
for i=1:N,
  % the matched filter outputs
  if (dsource(i)==0),
    r=-3*d+gngauss(sgma);  		% if the source output is "00"
  elseif (dsource(i)==1),
    r=-d+gngauss(sgma);    		% if the source output is "01"
  elseif (dsource(i)==2)  
    r=d+gngauss(sgma);     		% if the source output is "10"
  else
    r=3*d+gngauss(sgma);   		% if the source output is "11"
  end;
  % Detector follows.
  if (r<-2*d),
    decis=0;		     		% Decision is "00."
  elseif (r<0),
    decis=1;		     		% Decision is "01."
  elseif (r<2*d),
    decis=2;		     		% Decision is "10."
  else
    decis=3;		     		% Decision is "11."
  end;
  if (decis~=dsource(i)),   		% If it is an error, increase the error counter.
    numoferr=numoferr+1;
  end;
end;
p=numoferr/N;	  	     		% probability of error estimate