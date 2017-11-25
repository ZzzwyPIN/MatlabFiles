clc
clear

P=[0.1 0.3 0.05 0.09 0.21 0.25];
Q=P'*P;
Q=reshape(Q,1,36);
H=Entropy(Q);
[h,L]=Huffman(Q);
Eta=H/L; 