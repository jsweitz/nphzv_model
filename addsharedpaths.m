% This adds the correct path in MATLAB required for computation
% should be run in the nphz_v_results subdirectory

tmps = pwd;
tmps2 = strcat(tmps,'/shared');
addpath(tmps2);
tmps2 = strcat(tmps,'/data');
addpath(tmps2);
tmps2 = strcat(tmps,'/utils');
addpath(tmps2);
