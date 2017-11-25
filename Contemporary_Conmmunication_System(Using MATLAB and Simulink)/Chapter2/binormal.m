% binormal.m generation of a binormal vector pages 52-53

y=randn(2,3000);
c=1/(2*sqrt(2))*[sqrt(3)+1 sqrt(3)-1; sqrt(3)-1 sqrt(3)+1];
x=c*y;
plot(x(1,:),x(2,:),'.')