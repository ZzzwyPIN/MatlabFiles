function [golddata]=goldPN(pntaps1,pntaps2,pninitial)
sqn1=mPN(pntaps1,pninitial);%sqn1表示扩频码,大小为N*N的矩阵
pninitial2=[zeros(1,length(pntaps1)-1),1];
sqn2=mPN(pntaps2,pninitial2);%C表示扩频码,大小为1*N的矩阵
golddata=rem((sqn1+sqn2),2);
