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

%������a����С�������򣬷��������������У��Լ���Ӧ��index��
%�˷������Դ�ͼ����ֱ�۵Ŀ���ԭ������ı�����ж�Ӧ��ĸı�ֵ
[Y,index]=sort(a);
figure,plot(Y,a_quan(index))
figure,plot(a,a_quan)%������ֱ�ӱȽϻ�����ͼ�Ƚ��ҡ�


