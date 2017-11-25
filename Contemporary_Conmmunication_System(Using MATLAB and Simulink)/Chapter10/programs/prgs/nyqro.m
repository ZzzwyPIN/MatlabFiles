% Impulse response of raised-cosine filter
function y = nyqro(alpha, x)

si = sinc(x);
a  = pi * x;
b  = alpha * a;
c  = x .^ 2;
d  = 1 - (4*alpha*alpha*c);


pole = find(abs(d) < 0.001);


d(pole) = ones(size(pole));


y = si .* cos(b) ./ d;

a = pi * x(pole);
b = alpha * a;
c = x(pole) .^2;
d = 1 - (12*alpha*alpha*c);


y(pole) = (-sin(a) .* sin(b) .*alpha ) ./ d;

clear si a b c d pole;
