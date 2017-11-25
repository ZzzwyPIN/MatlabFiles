% MATLAB script for Illustrative Problem 8.11. 
echo on
gamma_b_db=[-4:1:14];
gamma_b=10.^(gamma_b_db/10);
qq=q(sqrt(0.733.*gamma_b));
p_err=2047*qq.^2.*(3-2.*qq);
pause % Press a key to see p_err versus gamma_b curve.
loglog(gamma_b,p_err)
