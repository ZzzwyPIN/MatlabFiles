function y=exp_fnct(x,funfcn,k,T,p1,p2,p3)
% y=exp_fnct(x,funfcn,k,T,p1,p2,p3)
%  Returns the function funfcn(x) times
%  the exponential factor exp(-j*2*pi*k/T*x)

j=sqrt(-1) ;
args=[];
for nn=1:nargin-4
  args=[args,',p',int2str(nn)];
end
args=[args,')'] ;
y=eval([funfcn,'(x',args,'.*exp(-j*2*pi*x*k/T)']);
