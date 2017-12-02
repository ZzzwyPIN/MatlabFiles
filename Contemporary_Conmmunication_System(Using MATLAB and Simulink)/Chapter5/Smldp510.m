function [p]=Smldp510(snr_in_dB)
% [p]=smldP510(snr_in_dB)
%		SMLDP510  simulates the probability of error for the given
%   		snr_in_dB, signal-to-noise ratio in dB.
M=4;				   	% quaternary orthogonal signaling
E=1;
SNR=exp(snr_in_dB*log(10)/10);	   	% signal-to-noise ratio per bit
sgma=sqrt(E^2/(4*SNR));  	   	% sigma, standard deviation of noise 关键是不知道为什么sgma可以这样计算得出。
N=10000;	 		   	% number of symbols being simulated
% generation of the quaternary data source
for i=1:N
  temp=rand;   	      			% a uniform random variable over (0,1)
  if (temp<0.25)
    dsource1(i)=0; 
    dsource2(i)=0;	      	
  elseif (temp<0.5)
    dsource1(i)=0; 
    dsource2(i)=1;	      	
  elseif (temp<0.75)
    dsource1(i)=1; 
    dsource2(i)=0;	      	
  else
    dsource1(i)=1; 
    dsource2(i)=1;
  end
end;
% detection, and probability of error calculation
numoferr=0;
for i=1:N
  % matched filter outputs
  if ((dsource1(i)==0) && (dsource2(i)==0))
    r0=sqrt(E)+Gngauss(sgma);
    r1=Gngauss(sgma);
    r2=Gngauss(sgma);
    r3=Gngauss(sgma);
  elseif ((dsource1(i)==0) && (dsource2(i)==1))
    r0=Gngauss(sgma);
    r1=sqrt(E)+Gngauss(sgma);
    r2=Gngauss(sgma);
    r3=Gngauss(sgma);
  elseif ((dsource1(i)==1) && (dsource2(i)==0))
    r0=Gngauss(sgma);
    r1=Gngauss(sgma);
    r2=sqrt(E)+Gngauss(sgma);
    r3=Gngauss(sgma);
  else
    r0=Gngauss(sgma);
    r1=Gngauss(sgma);
    r2=Gngauss(sgma);
    r3=sqrt(E)+Gngauss(sgma);
  end;
  % the detector
  max_r=max([r0 r1 r2 r3]);
  if (r0==max_r)
    decis1=0;
    decis2=0;
  elseif (r1==max_r)
    decis1=0;
    decis2=1;
  elseif (r2==max_r)
    decis1=1;
    decis2=0;
  else
    decis1=1;
    decis2=1;
  end;
  % Count the number of bit errors made in this decision.
  if (decis1~=dsource1(i))   		% If it is an error, increase the error counter.
    numoferr=numoferr+1;
  end;
  if (decis2~=dsource2(i))   		% If it is an error, increase the error counter.
    numoferr=numoferr+1;
  end;
end;
p=numoferr/(2*N);	       		% bit error probability estimate