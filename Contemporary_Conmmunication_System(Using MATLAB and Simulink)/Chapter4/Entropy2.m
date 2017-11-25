function h=entropy2(p)
% h=entropy2(p) Returns the binary entropy function of the components 
%		of the vevtor p.
h=-p.*log2(p)-(1-p).*log2(1-p);
