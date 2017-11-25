function [p]=Ss_pe94(snr_in_dB, Lc, A, w0)
% [p]=ss_Pe94(snr_in_dB, Lc, A, w0)
%		SS_PE94  finds the measured error rate. The function 
%   		that returns the measured probability of error for the given value of 
%   		the snr_in_dB, Lc, A and w0.
snr=10^(snr_in_dB/10);
sgma=1;		      			% Noise standard deviation is fixed.
Eb=2*sgma^2*snr;      			% signal level required to achieve the given ???这一步有点不太懂。
		      			% signal-to-noise ratio
E_chip=Eb/Lc;	      			% energy per chip
N=10000;	      			% number of bits transmitted
% The generation of the data, noise, interference, decoding process and error
% counting is performed all together in order to decrease the run time of the 
% program. This is accomplished by avoiding very large sized vectors.
num_of_err=0;		
for i=1:N
  % Generate the next data bit.
  temp=rand;	
  if (temp<0.5)
    data=-1;
  else
    data=1;
  end;
  % Repeat it Lc times, i.e. divide it into chips.
  for j=1:Lc
    repeated_data(j)=data;
  end;
  % pn sequence for the duration of the bit is generated next
  for j=1:Lc
    temp=rand;
    if (temp<0.5)
      pn_seq(j)=-1;
    else
      pn_seq(j)=1;
    end;
  end;
  % the transmitted signal is
  trans_sig=sqrt(E_chip)*repeated_data.*pn_seq;
  % AWGN with variance sgma^2
  noise=sgma*randn(1,Lc);
  % interference 
  n=(i-1)*Lc+1:i*Lc;
  interference=A*sin(w0*n);
  % received signal
  rec_sig=trans_sig+noise+interference;
  % Determine the decision variable from the received signal.
  temp=rec_sig.*pn_seq;
  decision_variable=sum(temp);
  % making decision
  if (decision_variable<0)
    decision=-1;
  else
    decision=1;
  end;
  % If it is an error, increment the error counter.
  if (decision~=data)
    num_of_err=num_of_err+1;
  end;
end;
% then the measured error probability is
p=num_of_err/N;