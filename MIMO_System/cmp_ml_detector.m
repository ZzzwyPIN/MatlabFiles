function [symbol_err_rate,Shat,err_nbr] = cmp_ml_detector(Y,H,symbols,S)
Modu_mode = length(symbols);
[N,M] = size(H);
Total = Modu_mode^M;

for idx = 1:M
    code(idx,1) = symbols(1);
end
y_diff = Y-H*code;
min_value = abs(y_diff'*y_diff);
flg = 0;

for loop = 1:Total-1 
	bin = loop;
    for idx = 1:M
		code(idx,1) = symbols(mod(bin,Modu_mode)+1);
		bin = floor(bin/Modu_mode);
    end
    y_diff = Y-H*code;
    est = abs(y_diff'*y_diff);
    
    if est < min_value
        min_value = est;
        flg = loop;
    end
end   

for idx = 1:M
    Shat(idx,1) = symbols(mod(flg,Modu_mode)+1);
    flg = floor(flg/Modu_mode);
end

err_mat = S-Shat;
err_nbr = length(find(abs(err_mat)>0.0001));
symbol_err_rate = err_nbr/prod(size(err_mat));




