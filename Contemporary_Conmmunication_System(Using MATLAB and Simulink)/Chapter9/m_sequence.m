function [mseq] = m_sequence(connection)
%%%%%%%%%%%%%%%%%%%���������������M���С����У�connection��Ҫ����M���еı�ԭ����ʽϵ����mseqΪ���ɵĶ���ʽ���С�
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