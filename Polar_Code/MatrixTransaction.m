function B = MatrixTransaction(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%这是一个用来计算极化码编码过程中排序矩阵Bn的函数%
%递归公式：B8 = R8*kron(I2, B4)  B4 = R4*kron(I2, B2)
%input:n(B的阶数)
%output:Bn(生成的n*n的排序矩阵)
% Io = I(:,1:2:end);%抽出矩阵I的奇数列
% Ie = I(:,2:2:end);
% R = [Io Ie];
I2 = eye(2);
B = eye(2);
m = log2(n)-1;
for i = 1:m
    n_ = 2^(i+1);
    I = eye(n_);
    Io = I(:,1:2:end);%抽出矩阵I的奇数列
    Ie = I(:,2:2:end);
    R = [Io Ie];
    B = R*kron(I2, B);
end
