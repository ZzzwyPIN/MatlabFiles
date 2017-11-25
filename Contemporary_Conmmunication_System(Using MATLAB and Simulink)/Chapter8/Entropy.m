function h=entropy(p)
%		H=ENTROPY(P) returns the entropy function of 
%		the probability vector P.
if length(find(p<0))~=0,
  error('Not a prob. vector, negative component(s)')
end
if abs(sum(p)-1)>10e-10,
  error('Not a prob. vector, components do not add up to 1')
end
h=sum(-p.*log2(p));
