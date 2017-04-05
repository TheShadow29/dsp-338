%Frequencies all in kHz
sample_frq = 140;
B_l = 9.4;
B_h = 14.4;
transition_band = 1;
[wp1,wp2,ws1,ws2] = get_discrete_specifications(sample_frq,B_l,B_h,'bp');
[omega_p1,omega_p2,omega_s1,omega_s2] = get_ct_specifications(wp1,wp2,ws1,ws2);
B = omega_p2 - omega_p1;
omega_0 = sqrt(omega_p1 * omega_p2);
[omega_lp,omega_ls] = get_lpf_specifications(B,omega_0,omega_p1,omega_p2,omega_s1,omega_s2,'bp');
delta_1 = 0.1;
delta_2 = 0.1;
[N,omega_c] = butterworth_lpf_specifications(omega_lp,omega_ls,delta_1,delta_2);
s = tf('s');
[H_s_L] = get_butterworth_tf(N,omega_c,s);
[H_s_bp] = get_bandpass_ct(H_s_L,s,B,omega_0);
