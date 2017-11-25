% MATLAB script for Illustrative Problem 2.6.
echo on
delta=0.01;
F_min=-2;
F_max=2;
f=F_min:delta:F_max;
Sx=ones(1,length(f));
H=1./(1+(2*pi*f).^2);
Sy=Sx.*H.^2;
plot(f,Sy);
axis([-2 2 0 1]);
xlabel('f');