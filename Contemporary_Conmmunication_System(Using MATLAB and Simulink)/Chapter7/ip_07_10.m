% MATLAB script for Illustrative Problem 10, Chapter 7.
echo on
K=10;N=2*K;T=100;variance=1;
noise=sqrt(variance)*randn(1,N);
a=rand(1,36);
a=sign(a-0.5);
b=reshape(a,9,4);
% Generate the 16QAM points
XXX=2*b(:,1)+b(:,2)+j*(2*b(:,3)+b(:,4));
XX=XXX';
X=[0 XX 0 conj(XX(9:-1:1))];
x=zeros(1,N);
for n=0:N-1
  for k=0:N-1
    x(n+1)=x(n+1)+1/sqrt(N)*X(k+1)*exp(j*2*pi*n*k/N);
    echo off
  end
end
echo on
r=x+noise;
Y=zeros(1,10);
for k=1:9
  for n=0:N-1
    Y(1,k+1)=Y(1,k+1)+1/sqrt(N)*r(n+1)*exp(-j*2*pi*k*n/N);
    echo off
  end
end
echo on
% Detect the nearest neighbor in the 16QAM constellation
for k=1:9
  if real(Y(1,k+1))>0
    if real(Y(1,k+1))>2
      Z(1,k+1)=3;
    else
      Z(1,k+1)=1;
    end
  else
    if real(Y(1,k+1))<-2
      Z(1,k+1)=-3;
    else
      Z(1,k+1)=-1;
    end
  end
  if imag(Y(1,k+1))>0
    if imag(Y(1,k+1))>2
      Z(1,k+1)=Z(1,k+1)+3*j;
    else
      Z(1,k+1)=Z(1,k+1)+j;
    end
  else
    if imag(Y(1,k+1))<-2
      Z(1,k+1)=Z(1,k+1)-3*j;
    else
      Z(1,k+1)=Z(1,k+1)-j;
    end
  end
  echo off
end
echo on
error=max(size(find(Z(1,2:10)-X(1,2:10))));
