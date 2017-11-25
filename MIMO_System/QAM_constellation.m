function [symbols] = QAM_constellation(modulation_order)
load QAM_constellations;
switch modulation_order
    case 1
        symbols = [1;-1];
    case 2
        symbols = const_QAM4;
    case 3
        symbols = const_QAM8;
    case 4
        symbols = const_QAM16;
    case 5
        symbols = const_QAM32;
    case 6
        symbols = const_QAM64;
    case 7
        symbols = const_QAM128;
    case 8
        symbols = const_QAM256;
    otherwise
        error('this Modu_mode is not support in this version');
        return;
end