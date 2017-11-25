function y=x_a2_fnct(x,funfcn,a,p1,p2,p3)
% y=x_a2_fnct(x,funfcn,a,p1,p2,p3)
%  Returns the function funfcn(x) times (x-a).^2

args=[];
for nn=1:nargin-3
  args=[args,',p',int2str(nn)];
end
args=[args,')'] ;
y=eval([funfcn,'(x',args,'.*(x-a).^2' ]);
