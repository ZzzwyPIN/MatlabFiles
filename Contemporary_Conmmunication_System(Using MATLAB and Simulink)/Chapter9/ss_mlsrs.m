function [seq]=ss_mlsrs(connections)
% [seq]=ss_mlsrs(connections)
%		SS_MLSRS  generates the maximal length shift-register sequence when the
%   		shift-register connections are given as input to the function. A "zero"
%   		means not connected, whereas a "one" represents a connection. 
m=length(connections);		
L=2^m-1;				% length of the shift register sequence requested
registers=[zeros(1,m-1) 1];		% initial register contents
seq(1)=registers(m);			% first element of the sequence
for i=2:L
   new_reg_cont(1)=connections(1)*seq(i-1);
   for j=2:m
     new_reg_cont(j)=registers(j-1)+connections(j)*seq(i-1);
   end;
   registers=new_reg_cont;		% current register contents
   seq(i)=registers(m);			% the next element of the sequence
end;