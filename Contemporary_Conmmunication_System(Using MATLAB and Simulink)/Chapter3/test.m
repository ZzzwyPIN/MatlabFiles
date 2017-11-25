t0=.15;                    		% signal duration
ts=0.001;                  		% sampling interval
% the message vector
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
m_hat=imag(hilbert(m));    		% find the Hilbert transform