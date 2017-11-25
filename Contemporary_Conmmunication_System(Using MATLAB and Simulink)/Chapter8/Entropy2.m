function h=entropy2(p)
% h=entropy2(p) Returns the binary entropy function of the components 
%		of the vevtor p.
n=length(p);
for i=1:n
p1=[p(i) 1-p(i)];
h(i)=entropy(p1);
end
