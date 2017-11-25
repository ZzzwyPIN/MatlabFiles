% Fourier transform of raised-cosine filter
function y = nyqrofr(alpha, x)

a = 0.5*(1-alpha);
b = 0.5*(1+alpha);
c = abs(x);

[m,n] = size(x);
y = zeros(m,n);

% Innenbereich (Eins)
bla = find( abs(x) <= a );
y(bla) = ones(size(bla)); 

% Aussenbereich (Null)
bla = find( abs(x) >= b );
y(bla) = zeros(size(bla));

% Übergangszone (Rolloff-Bereich)
bla = find ( abs(x)>a & abs(x)<b );
y(bla) = 0.5*(1-sin(pi/alpha*(abs(x(bla))-.5)));
