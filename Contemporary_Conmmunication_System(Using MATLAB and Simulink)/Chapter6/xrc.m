function [y] = xrc(f,alpha,T);
% [y]=xrc(f,alpha,T)
% 		Evaluates the expression Xrc(f). The parameters alpha and T
% 		must also be given as inputs to the function.
if (abs(f) > ((1+alpha)/(2*T))),
  y=0;
elseif (abs(f) > ((1-alpha)/(2*T))),
  y=(T/2)*(1+cos((pi*T/alpha)*(abs(f)-(1-alpha)/(2*T))));
else
  y=T;
end;