% ip_4_07.m  added for spar
p1=0;
p2=1;
delta=1;
n=11;
tol=0.01;
b=10*p2;
dist=Uq_mdpnt('Normal',b,n,delta,tol,p1,p2);
