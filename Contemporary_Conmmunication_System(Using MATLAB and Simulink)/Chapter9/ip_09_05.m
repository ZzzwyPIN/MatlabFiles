% MATLAB script for Illustrative Problem 9.5.
clc
clear

echo on
% First determine the maximal length shift-register sequences.
% Assume the initial shift-register content as "00001".
connections1=[1 0 1 0 0];
connections2=[1 1 1 0 1];
sequence1=ss_mlsrs(connections1);
sequence2=ss_mlsrs(connections2);
% Cyclically shift the second sequence and add it to the first one.
L=2^length(connections1)-1;
for shift_amount=0:L-1
  temp=[sequence2(shift_amount+1:L) sequence2(1:shift_amount)];
  gold_seq(shift_amount+1,:)=(sequence1+temp) - floor((sequence1+temp)./2).*2;
  echo off ;
end;
echo on ;
% Find the max value of the cross-correlation for these sequences.
max_cross_corr=0;
for i=1:L-1
  for j=i+1:L
    % equivalent sequences
    c1=2*gold_seq(i,:)-1;
    c2=2*gold_seq(j,:)-1;
    for m=0:L-1
      shifted_c2=[c2(m+1:L) c2(1:m)];
      corr=abs(sum(c1.*shifted_c2));
      if (corr>max_cross_corr)
        max_cross_corr=corr;
      end;
      echo off ; 
    end;
  end;
end;
% Note that max_cross_correlation turns out to be 9 in this example.