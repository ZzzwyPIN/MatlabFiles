function [count,ret,dest_u]=mimo_sd(r,H,C,M,s,COUNT,No)
% Sphere decoding algorithm in MIMO systems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  2004-5-17 CREATED by YING BIDONG (SJTU)  %
%  2004-6-9  Modified by XU WEIJUN(SJTU)    %
%  2004-6-7  Modified by Xu & Ying          %
%          copyrights belongs to Ying & Xu  %
%  2004-6-8  Tested 4*4 QPSK mode.          %
%   Successful!!! Congratulations!          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs interpretation:
% r: the received data vector(complex);
% H: the N*N MIMO channel matrix(complex);
% C: the original searching radius;
% M: the generator matrix/constance of the Tx data vector;
% s: the dedicated range for the very mode
% e.g. if mode=QPSK, then s=1; if mode=16QAM,then s=3;

% Outputs interpretation:
% ret: ret=0 stands for success; ret=-1 for failure;
% dest_u: the decoded symbol without normalization;
% tic;
n=2*length(r); % complex to real will enlarge the dimension to 2 times
r_eqv=[real(r.'),imag(r.')]; % complex to real
Mc=M*H;
Mc_eqv=[real(Mc.'),imag(Mc.');-imag(Mc.'),real(Mc.')];
invMc=inv(Mc_eqv);
G=Mc_eqv*Mc_eqv.';
Rq=chol(G);
Q=zeros(n,n);
for i=1:n
    Q(i,i)=Rq(i,i)^2;
    for p=(i+1):n
        Q(i,p)=Rq(i,p)/Rq(i,i);
    end
end
rho=r_eqv*invMc;

% n=2*length(r); % complex to real will enlarge the dimension to 2 times
% r_eqv=[real(r.'),imag(r.')]'; % complex to real
% Mc=M*H;
% Mc_eqv=[real(Mc),-imag(Mc);imag(Mc),real(Mc)];
% % invMc=inv(Mc_eqv);
% G=Mc_eqv.'*Mc_eqv;
% Rq=chol(G);
% Q=zeros(n,n);
% for i=1:n
%     Q(i,i)=Rq(i,i)^2;
%     for p=(i+1):n
%         Q(i,p)=Rq(i,p)/Rq(i,i);
%     end
% end
% I=eye(n);
% rho=inv(No*I+Mc_eqv'*Mc_eqv)*Mc_eqv'*r_eqv; %MMSE

d2=C;
T(n)=C;
for k=1:n
    S(k)=rho(k);
end
i=n;
L(i)=floor(sqrt(T(i)/Q(i,i))+S(i));
if L(i)>=s % confine the upper limit to its dedicated range
    L(i)=s;
end
u(i)=ceil(-sqrt(T(i)/Q(i,i))+S(i))-2;
if mod(u(i),2)==0
    u(i)=u(i)+1;
end
if u(i)<=(-s-2) % confine the lower limit to its dedicated range
    u(i)=-s-2;
end
Ed2=d2+1;% in order to make sure the expression Ed2<d2 wrong at the first time
% erfa=5;  %erfa=Inf means conventional Reduced Complexity SD
% beta=2;

count=COUNT;
while 1
    if Ed2<d2
        for k=1:n
            Eu(k)=u(k);
        end
        d2=Ed2;
        T(n)=Ed2;
%          d2=exp(-((1/erfa)*N(1))^beta)*Ed2;
%          T(n)=d2;
        i=n;
        L(i)=floor(sqrt(T(i)/Q(i,i))+S(i));
        if L(i)>=s
            L(i)=s;
        end
        u(i)=ceil(-sqrt(T(i)/Q(i,i))+S(i))-2;
        if mod(u(i),2)==0
            u(i)=u(i)+1;
        end
        if u(i)<=(-s-2)
            u(i)=-s-2;
        end
    end
    while i>=1
        u(i)=u(i)+2;
        count=count+1;
        while u(i)>L(i)
            if i==n
                ret=0;
                for k=1:length(r) % form the decoded symbols
                    dest_u(k,1)=Eu(k)+j*Eu(k+length(r));
                end
%                 toc;
%                 t=toc;
                return
            else
                i=i+1;
                u(i)=u(i)+2;
            end
        end
        if i==1
            N(1)=(L(1)-u(1))/2+1;
            break;
        else
            xi(i)=rho(i)-u(i);
            T(i-1)=T(i)-Q(i,i)*(S(i)-u(i))^2;
            S(i-1)=rho(i-1);
            for p=i:n
                S(i-1)=S(i-1)+Q(i-1,p)*xi(p);
            end
            i=i-1;
            L(i)=floor(sqrt(T(i)/Q(i,i))+S(i));
            if L(i)>=s
                L(i)=s;
            end
            u(i)=ceil(-sqrt(T(i)/Q(i,i))+S(i))-2;
            if mod(u(i),2)==0
                u(i)=u(i)+1;
            end
            if u(i)<=(-s-2)
                u(i)=-s-2;
            end
        end
    end
    Ed2=T(n)-T(1)+Q(1,1)*(S(1)-u(1))^2;
end
