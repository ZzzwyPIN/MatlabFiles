function F = n_kron(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����һ�������������F��n�ο����ڿ˻��ĺ���
initial_F = [1,0;1,1];

if n==2
    F = kron(initial_F,initial_F);
else
    F = kron(initial_F,initial_F);
    for i = 1:n-2
        F = kron(initial_F,F);
%         F = kron(initial_F,F);
    end
end