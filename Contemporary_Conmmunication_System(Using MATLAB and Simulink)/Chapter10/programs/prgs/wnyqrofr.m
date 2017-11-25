% Fourier Transform of Root-Raised-Cosine-Pulse
function y = wnyqrofr(alpha, x)

warning off;         % avoid devide by zero warning

a = 0.5*(1-alpha);
b = 0.5*(1+alpha);
c = abs(x);

[m,n] = size(x);
y = zeros(m,n);


bla = find( abs(x) <= a );
y(bla) = ones(size(bla)); 


bla = find( abs(x) >= b );
y(bla) = zeros(size(bla));


bla = find ( abs(x)>a & abs(x)<b );
y(bla) = cos(pi/(4*alpha)*(2*abs(x(bla))-1+alpha));

warning on;