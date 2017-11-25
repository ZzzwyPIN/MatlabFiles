function [goldseq]=gold_seq(connection1,connection2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%这个函数用来产生一组gold序列方阵。
%%%%%%%connection1,connection2分别为输入的优选M序列本原多项式系数。goldseq为生成的gold序列矩阵。
mseq1 = m_sequence(connection1);
mseq2 = m_sequence(connection2);
N = 2^length(connection1)-1;
for shift_amount = 0:N-1
    shift_mseq2 = [mseq2(shift_amount+1:N) mseq2(1:shift_amount)];
    goldseq(shift_amount+1,:) = mod(mseq1+shift_mseq2,2);
end;
