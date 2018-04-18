function F = n_kron(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%这是一个用来计算矩阵F的n次克罗内克积的函数
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