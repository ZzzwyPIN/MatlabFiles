% MATLAB script for Illustrative Problem 5, Chapter 6.
echo on
p=0.99;
N=1000;
d=5;
% The filter is described by the vectors A and B below...
A=[1 -2*p p^2];
B=(1-p)^2;
for i=1:N,
   [white_noise_seq1(i) white_noise_seq2(i)] = gngauss;
   echo off;
end;
echo on;
b1=filter(B,A,white_noise_seq1);
b2=filter(B,A,white_noise_seq2);
c=b1(d+1:N)+b2(1:N-d);
% The case where p=0.9 follows...
p=0.9;
A=[1 -2*p p^2];
B=(1-p)^2;
for i=1:N,
   [white_noise_seq1(i) white_noise_seq2(i)] = gngauss;
   echo off;
end;
echo on;
new_b1=filter(B,A,white_noise_seq1);
new_b2=filter(B,A,white_noise_seq2);
new_c=new_b1(d+1:N)+new_b2(1:N-d);
% plotting commands follow
plot(1:N,b1,'-',1:N,b2,'--',1:N-d,c,':') ; 
pause % p=0.99 ; Press a key to see results with pole at p=0.9
plot(1:N,new_b1,'-',1:N,new_b2,'--',1:N-d,new_c,':') ; 