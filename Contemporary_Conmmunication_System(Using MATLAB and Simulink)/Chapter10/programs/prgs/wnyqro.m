% Impulse response of root-raised-cosine filter
function y = wnyqro(alpha, x)

warning off;

a = 4*alpha*x;
b = pi*(1+alpha)*x;
c = pi*(1-alpha)*x;
d = x.^2;
e = 16*alpha*alpha*d;
f = (pi*x) .* (1-e);

y = (a .* cos(b) + sin(c) ) ./ f;

warning on;