%Frequencies all in kHz
close all;
sample_frq = 140;
B_l = 9.4;
B_h = 14.4;
transition_band = 1;
P = bodeoptions;           % handle to plot options
P.MagScale = 'linear';
P.MagUnits = 'abs';
[wp1,wp2,ws1,ws2] = get_discrete_specifications(sample_frq,B_l,B_h,'bp');
[omega_p1,omega_p2,omega_s1,omega_s2] = get_ct_specifications(wp1,wp2,ws1,ws2);
B = omega_p2 - omega_p1;
omega_0 = sqrt(omega_p1 * omega_p2);
[omega_lp,omega_ls] = get_lpf_specifications(B,omega_0,omega_p1,omega_p2,omega_s1,omega_s2,'bp');
delta_1 = 0.1;
delta_2 = 0.1;
[N,omega_c] = butterworth_lpf_specifications(omega_lp,omega_ls,delta_1,delta_2);
s = tf('s');
% omega_c = 1.0745;
[H_s_L] = get_butterworth_tf(N,omega_c,s);
figure;
bodeplot(H_s_L,P); title('Bodeplot for Low Pass Butterworth H_s_L');
[H_s_bp,H_z_bp,H_z_bp_actual] = get_bandpass_ct(N,H_s_L,s,B,omega_0);
figure;
bodeplot(H_s_bp,P); title('Bodeplot for Band Pass Butterworth H_s_{bp}');
figure;
plot_Hz(H_z_bp,wp1,wp2,ws1,ws2);title('Plot for Band Pass Digital Filter');
% [H_z] = ct_to_dt_bp(H_s_bp);

%%FIR
[h_fir_n_bp,H_fir_bp,H_fir_z_bp,fir_order_bp] = get_fir('bp',delta_1,wp1,wp2,ws1,ws2);



