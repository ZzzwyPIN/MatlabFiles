function y=lambtest3(x)
%		y=lambda(x) generates a triangular signal
y=0.5*sawtooth(pi*(x-4)/4,0.5)+0.5;
end