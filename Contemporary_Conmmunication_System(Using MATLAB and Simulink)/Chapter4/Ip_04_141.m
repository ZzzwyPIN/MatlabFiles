% MATLAB script for Illustrative Problem 4.14.1.

echo on
a=randn(1,500);
n=16;
[sqnr,a_quan,code]=U_pcm(a,16);
% pause	% Press a key to see the SQNR.
% sqnr
% pause	% Press a key to see the first five input values.
% a(1:5)
% pause	% Press a key to see the first five quantized values.
% a_quan(1:5)
% pause	% Press a key to see the first five codewords.
% code(1:5,:)
b=a-a_quan;
plot(b)

%将输入a按从小到大排序，返回排序过后的序列，以及对应的index。
%此方法可以从图像上直观的看出原序列与改变后序列对应点的改变值
[Y,index]=sort(a);
figure,plot(Y,a_quan(index))
figure,plot(a,a_quan)%不排序直接比较画出的图比较乱。


