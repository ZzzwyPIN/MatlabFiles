function [golddata]=goldPN(pntaps1,pntaps2,pninitial)
sqn1=mPN(pntaps1,pninitial);%sqn1��ʾ��Ƶ��,��СΪN*N�ľ���
pninitial2=[zeros(1,length(pntaps1)-1),1];
sqn2=mPN(pntaps2,pninitial2);%C��ʾ��Ƶ��,��СΪ1*N�ľ���
golddata=rem((sqn1+sqn2),2);
