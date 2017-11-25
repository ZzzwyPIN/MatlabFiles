function [p]=ss_Pe42(rho_in_dB)
% [p]=ss_Pe42(rho_in_dB)
%		SS_PE42  finds the measured error rate for the given value of
%   		signal per interference ratio in dB.
rho=10^(rho_in_dB/10);
Eb=rho;					% energy per information bit
E=Eb/2;					% energy per symbol transmitted
% the optimal value of alpha
if (rho>2),
  alpha=2/rho;
else
  alpha=1;
end;
% the variance of the additive noise
if (E>1),
  sgma=sqrt(E/2);
else
  sgma=sqrt(1/2);
end;
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
% find the transmitted signals
for i=1:N,
  if (data(i)==0),
    tr11c(i)=sqrt(E);  tr12c(i)=sqrt(E);
    tr11s(i)=0;	 tr12s(i)=0;
    tr21c(i)=0;	 tr22c(i)=0;	
    tr21s(i)=0;	 tr22s(i)=0;
  else
    tr11c(i)=0;	 tr12c(i)=0;
    tr11s(i)=0;	 tr12s(i)=0;
    tr21c(i)=sqrt(E);	 tr22c(i)=sqrt(E);
    tr21s(i)=0;	 tr22s(i)=0;
  end;
end;

% find the received signals, make the decisions and count the number of errors.  
num_of_err=0;
for i=1:N,
  % determine if there is jamming 
  if (rand<alpha),
    jamming1=1;	       			% jamming present on the second transmission
  else	
    jamming1=0;	       			% jamming not present on the first transmission
  end;
  if (rand<alpha),
    jamming2=1;	       			% jamming present on the second transmission
  else
    jamming2=0;	       			% jamming not present on the second transmission
  end;
  % the the received signals
  if (jamming1==1)
    r11c=tr11c(i)+gngauss(sgma);    r11s=tr11s(i)+gngauss(sgma);
    r21c=tr21c(i)+gngauss(sgma);    r21s=tr21s(i)+gngauss(sgma);
  else
    r11c=tr11c(i);    r11s=tr11s(i);
    r21c=tr21c(i);    r21s=tr21s(i);
  end;
  if (jamming2==1)
    r12c=tr12c(i)+gngauss(sgma);    r12s=tr12s(i)+gngauss(sgma);
    r22c=tr22c(i)+gngauss(sgma);    r22s=tr22s(i)+gngauss(sgma);
  else
    r12c=tr12c(i);    r12s=tr12s(i);
    r22c=tr22c(i);    r22s=tr22s(i);
  end;
  % compute the decision variables, first the weights
  if (jamming1==1),
    w1=1/sgma^2;
  else
    w1=10;
  end;
  if (jamming2==1),
    w2=1/sgma^2;
  else
    w2=10;
  end;
  % the intermediate decision variables are
  r11=r11c^2+r11s^2;
  r12=r12c^2+r12s^2;
  r21=r21c^2+r21s^2;
  r22=r22c^2+r22s^2;
  % the decision variables x and y
  x=w1*r11+w2*r12;
  y=w1*r21+w2*r22;
  % make the decision now
  if (x>y),
    decis=0;
  else
    decis=1;
  end;
  % increment the counter if this is an error
  if (decis~=data(i)),
    num_of_err=num_of_err+1;
  end;
end;
% the measured bit error rate is then
p=num_of_err/N;