function modu_map = modu_init(Modu_mode)
% program for initial modulation constellation
% Input parameters description:
% Modu_mode:    Modulation bits number
% Output parameters description:
% modu_map:     Modulation constellation
% Note: the signal power in modulation has been normalized
switch Modu_mode
    case 1  %BPSK
        modu_map(1) = 1;
        modu_map(2) = -1;
    case 2  %QPSK
        a = 1/sqrt(2);
        modu_map(1) = a+i*a;
        modu_map(2) = -a+i*a;
        modu_map(3) = a-i*a;
        modu_map(4) = -a-i*a;
    case 3  %8PSK
        a = cos(pi/8);
        b = sin(pi/8);
        modu_map(1) = a+i*b;
        modu_map(2) = b+i*a;
        modu_map(3) = -a+i*b;
        modu_map(4) = -b+i*a;
        for j = 1:4
            modu_map(j+4) = conj(modu_map(j));
        end
    case 4  %16QAM
        a = 1/sqrt(10);
        modu_map(1) = (3*a)+i*(3*a);
        modu_map(2) = a+i*(3*a);
        modu_map(3) = -(3*a)+i*(3*a);
        modu_map(4) = -a+i*(3*a);
        for j =1:4
            modu_map(j+4) = modu_map(j)-i*(2*a);
        end
        for j = 1:8
            modu_map(j+8) = conj(modu_map(j));
        end
    otherwise
        error('this Modu_mode is not support in this version');
        return;
end