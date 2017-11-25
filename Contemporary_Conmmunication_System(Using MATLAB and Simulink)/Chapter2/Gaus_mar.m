function [X]=Gaus_mar(X0,rho,N)
% [X]=gaus_mar(X0,rho,N)
%       GAUS_MAR  generates a Gauss-Markov process of length N.
%           The noise process is taken to be white Gaussian
%           noise with zero mean and unit variance.
for i=1:2:N
  [Ws(i),Ws(i+1)]=Gngauss;        % Generate the noise process.
end;
X(1)=rho*X0+Ws(1);                % first element in the Gauss--Markov process
for i=2:N
  X(i)=rho*X(i-1)+Ws(i);          % the remaining elements
end;
