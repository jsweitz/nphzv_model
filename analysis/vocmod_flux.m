function f = vocmod_flux(x,y_data)
% function f = vocmod_flux(x,y_data)
% This function moves in the 38 parameter space of the
% model to find values compatible with a desired output

% Calculate the steady state
y_theory=voc_steady_flux(x);

% Weight things
f=sum(log(y_theory./y_data).^2);

% f = (H-H_d)^2/H_d^2 + (C-C_d)^2/C_d^2 + (E-E_d)^2/E_d^2+ (Z-Z_d)^2/Z_d^2 + (Vh-Vh_d)^2/Vh_d^2+(Vc-Vc_d)^2/Vc_d^2+(Ve-Ve_d)^2/Ve_d^2+(xon-xon_d)^2/xon_d^2+(xin-xin_d)^2/xin_d^2;

