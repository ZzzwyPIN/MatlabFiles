function B = MatrixTransaction(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����һ���������㼫�������������������Bn�ĺ���%
%�ݹ鹫ʽ��B8 = R8*kron(I2, B4)  B4 = R4*kron(I2, B2)
%input:n(B�Ľ���)
%output:Bn(���ɵ�n*n���������)
% Io = I(:,1:2:end);%�������I��������
% Ie = I(:,2:2:end);
% R = [Io Ie];
I2 = eye(2);
B = eye(2);
m = log2(n)-1;
for i = 1:m
    n_ = 2^(i+1);
    I = eye(n_);
    Io = I(:,1:2:end);%�������I��������
    Ie = I(:,2:2:end);
    R = [Io Ie];
    B = R*kron(I2, B);
end
