function [golddata]=goldPN(pntaps1,pntaps2,pninitial)
%����M������ѡ��
sqn1=mPN(pntaps1,pninitial);
pninitial2=[zeros(1,length(pntaps1)-1),1];
sqn2=mPN(pntaps2,pninitial2);
%����Gold����
golddata=rem((sqn1+sqn2),2);
