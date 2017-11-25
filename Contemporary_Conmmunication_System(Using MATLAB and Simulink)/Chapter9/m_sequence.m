function [mseq] = m_sequence(connection)
%%%%%%%%%%%%%%%%%%%这个函数用来产生M序列。其中，connection是要生成M序列的本原多项式系数。mseq为生成的多项式序列。
N = length(connection);
L = 2^N-1;
register = [zeros(1,N-1) 1];
mseq(1) = register(N);
for i = 2:L
   newreg(1) = mod(sum(connection.*register),2);
   for j = 2:N
       newreg(j) = register(j-1);
   end;
   register = newreg;
   mseq(i) = register(N);
end;