% MATLAB script for Illustrative Problem 8.12.
[p_err_ha,gamma_b]=p_e_hd_a(7,13,11,15,3);
[p_err_ho,gamma_b]=p_e_hd_o(7,13,11,15,3);
[p_err_so,gamma_b]=p_e_sd_o(7,13,11,15,3);
[p_err_sa,gamma_b]=p_e_sd_a(7,13,11,15,3);
semilogy(gamma_b,p_err_sa,gamma_b,p_err_so,gamma_b,p_err_ha,gamma_b,p_err_ho)
