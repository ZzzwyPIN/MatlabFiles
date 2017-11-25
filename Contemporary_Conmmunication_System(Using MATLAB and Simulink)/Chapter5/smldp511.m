function [p]=smldP511(snr_in_dB)
% [p]=smldP511(snr_in_dB)
%		SMLDP511  simulates the probability of error for the given
%   		snr_in_dB, signal-to-noise ratio in dB, for the system 
%   		described in Illustrated Problem 5.11.
M=4;				   	% quaternary biorthogonal signaling
E=1;
SNR=exp(snr_in_dB*log(10)/10);	   	% signal-to-noise ratio per bit
sgma=sqrt(E^2/(4*SNR));  	   	% sigma, standard deviation of noise
N=10000;	 		   	% number of symbols being simulated
% generation of the quaternary data source
for i=1:N,
   temp=rand;   	      		% uniform random variable over (0,1)
   if (temp<0.25),
      dsource(i)=0; 
   elseif (temp<0.5),
      dsource(i)=1; 
   elseif (temp<0.75),
      dsource(i)=2; 
   else
      dsource(i)=3; 
   end
end;
% detection, and error probability computation
numoferr=0;
for i=1:N,
   % the matched filter outputs
   if (dsource(i)==0)
      r0=sqrt(E)+gngauss(sgma);
      r1=gngauss(sgma);
   elseif (dsource(i)==1)
      r0=gngauss(sgma);
      r1=sqrt(E)+gngauss(sgma);
   elseif (dsource(i)==2)
      r0=-sqrt(E)+gngauss(sgma);
      r1=gngauss(sgma);
   else
      r0=gngauss(sgma);
      r1=-sqrt(E)+gngauss(sgma);
   end;
   % detector follows
   if (r0>abs(r1)),
      decis=0;
   elseif (r1>abs(r0)),
      decis=1;
   elseif (r0<-abs(r1)),
      decis=2;
   else
      decis=3;
   end;
   if (decis~=dsource(i)),     		% If it is an error, increase the error counter.
      numoferr=numoferr+1;
   end;
end;
p=numoferr/N;	               		% bit error probability estimate