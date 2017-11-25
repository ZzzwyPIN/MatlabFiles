function [p_err,gamma_db]=p_e_hd_o(gamma_db_l,gamma_db_h,k,n,d_min)
% p_e_hd_o.m 	Matlab function for computing error probability in
%            	hard-decision decoding of a linear block code
%            	when orthogonal signaling is used.
%  		[p_err,gamma_db]=p_e_hd_o(gamma_db_l,gamma_db_h,k,n,d_min)
%  		gamma_db_l=lower E_b/N_0
%  		gamma_db_h=higher E_b/N_0
% 		k=number of information bits in the code
%  		n=code block length
%  		d_min=minimum distance of the code

gamma_db=[gamma_db_l:(gamma_db_h-gamma_db_l)/20:gamma_db_h];
gamma_b=10.^(gamma_db/10);
R_c=k/n;
p_b=q(sqrt(R_c.*gamma_b));
p_err=(2^k-1).*(4*p_b.*(1-p_b)).^(d_min/2);
