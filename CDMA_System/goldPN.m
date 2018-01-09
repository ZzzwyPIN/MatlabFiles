function [golddata]=goldPN(pntaps1,pntaps2,pninitial)
%生成M序列优选对
sqn1=mPN(pntaps1,pninitial);
pninitial2=[zeros(1,length(pntaps1)-1),1];
sqn2=mPN(pntaps2,pninitial2);
%生成Gold序列
golddata=rem((sqn1+sqn2),2);
