clear
% 设置仿真参数
Mt = 2; % 发射天线数
Mr = 2; % 接收天线数
Num = 1000000; % 仿真点数

% ====== 产生 PSK 和 QAM 星座符号 ====== /
modulation_order = 2;
symbols = QAM_constellation(modulation_order);

idx = 0;
for snr = 10:2:10
    snr
    Eb = 10^(snr/10); % 传输能量
	No = 1; % Noise power 1
	
    bit_error_nbr = 0;   
    symbol_error_nbr = 0;   
    for loop = 1:Num
        init_bit = randi([0 1],Mt*modulation_order,1);
        mod_sym = bi2de(reshape(init_bit,modulation_order,Mt)','left-msb')+1;
        S = symbols(mod_sym);  % 产生符号序列

        H = normrnd(0,1,Mr,Mt) + j*normrnd(0,1,Mr,Mt); % 产生信道矩阵
		N_noise = normrnd(0,No,Mr,1) + j*normrnd(0,No,Mr,1); % 产生噪声
		Y = sqrt(Eb*modulation_order)*H*S + N_noise; % 传输符号       
        
        [err_rate,s_d,cur_ser_nbr] = cmp_ml_detector(Y,sqrt(Eb*modulation_order)*H,symbols,S); % 检测传输符号
        symbol_error_nbr = symbol_error_nbr + cur_ser_nbr;
        
       % =======  symbols detection ===================%
       for i = 1:length(s_d)
           dis2 = (s_d(i)-symbols).*conj(s_d(i)-symbols);
           [d_min,k] = min(dis2);
           demo(i,:) = symbols(k);
           demo_bit(i,:) = de2bi(k-1,modulation_order,'left-msb');
       end
       demo_out = reshape(demo_bit.',1,Mt*modulation_order);
       [number,ratio] = biterr(demo_out.',init_bit);
       bit_error_nbr = bit_error_nbr + number;
        
        
        if mod(loop,2000) == 0
            loop
            symbol_error_nbr
            tmp_ser = symbol_error_nbr/(loop*Mt)
            bit_error_nbr
            tmp_ber = bit_error_nbr/(loop*Mt*modulation_order)
        end
    end
    
    idx = idx+1;
	ser(idx) = symbol_error_nbr/(loop*Mt)
	ber(idx) = bit_error_nbr/(loop*Mt*modulation_order)
end
