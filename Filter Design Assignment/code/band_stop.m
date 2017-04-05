%Frequencies all in kHz
sampl_freq = 90;
B_l = 7.7;
B_h = 10.7;
transition_band = 1;
[wp1,wp2,ws1,ws2] = get_discrete_specifications(sample_frq,B_l,B_h,'bs');
[omega_p1,omega_p2,omega_s1,omega_s2] = get_ct_specifications(wp1,wp2,ws1,ws2);
B = omega_p2 - omega_p1;
omega_0 = sqrt(omega_p1 * omega_p2);
[omega_lp,omega_ls] = get_lpf_specifications(B,omega_0,omega_p1,omega_p2,omega_s1,omega_s2,'bs');
delta_1 = 0.1;
delta_2 = 0.1;
[N,epsilon] = chebyshev_lpf_specifications(omega_lp,omega_ls,delta_1,delta_2);
s = tf('s');
G_sl = get_chebyshev_tf(N,epsilon,s,omega_lp);
G_bs = get_bandstop_ct(G_sl,s,B,omega_0);

