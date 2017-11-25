function [goldseq]=gold_seq(connection1,connection2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���������������һ��gold���з���
%%%%%%%connection1,connection2�ֱ�Ϊ�������ѡM���б�ԭ����ʽϵ����goldseqΪ���ɵ�gold���о���
mseq1 = m_sequence(connection1);
mseq2 = m_sequence(connection2);
N = 2^length(connection1)-1;
for shift_amount = 0:N-1
    shift_mseq2 = [mseq2(shift_amount+1:N) mseq2(1:shift_amount)];
    goldseq(shift_amount+1,:) = mod(mseq1+shift_mseq2,2);
end;
