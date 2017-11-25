function y=x_fnct(x,funfcn,p1,p2,p3)
% y=x_fnct(x,funfcn,p1,p2,p3)
%  Returns the function funfcn(x) times x

args=[];
for nn=1:nargin-2
  args=[args,',p',int2str(nn)];
end
args=[args,')'] ;
y=eval([funfcn,'(x',args,'.*x' ]);
