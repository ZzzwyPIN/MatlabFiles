function [enc_comp] = cm_dpske(E,M,mapping,sequence);
% [enc_comp] = cm_dpske(E,M,mapping,sequence)
% 		CM_DPSKE differentially encodes a sequence.
% 		E is the average energy, M is the number of constellation points,
% 		and mapping is the vector defining how the constellation points are 
% 		allocated. Finally, ``sequence'' is the uncoded binary data sequence. 
k=log2(M);
N=length(sequence);
% If N is not divisible by k, append zeros, so that it is...
remainder=rem(N,k);
if (remainder~=0),
  for i=N+1:N+k-remainder,
    sequence(i)=0;
  end;
  N=N+k-remainder;
end;
theta=0;				% Initially, assume that theta=0.	
for i=1:k:N,
  index=0;
  for j=i:i+k-1,
    index=2*index+sequence(j);
  end;
  index=index+1;
  theta=mod(2*pi*mapping(index)/M+theta,2*pi);
  enc_comp((i+k-1)/k,1)=sqrt(E)*cos(theta);
  enc_comp((i+k-1)/k,2)=sqrt(E)*sin(theta);
end;