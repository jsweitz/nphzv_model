% This is a function meant to find optimal parameters
% congruent with a target set of densities
%
% Updated to include basal loss - October 2013
% Joshua Weitz
% 2012-2013

% We search the space using different initial conditions 
% and keep searching until we find conditions compatible
% with the output
clear all

% REMOVE LATER
cd ..
addsharedpaths
cd analysis

% Initial values
x0.muh=1;
x0.kon=0.5;
x0.epsh=0.1;
x0.muc=1;
x0.kinc=0.5;
x0.mue=1;
x0.kine=5;
x0.phivh=10^-12;
x0.phivc=10^-12;
x0.phive=10^-11;
x0.betah=25;
x0.betac=25;
x0.betae=250;
x0.mvh=0.5;
x0.mvc=0.5;
x0.mve=0.5;
x0.psizh=10^-5;
x0.psizc=10^-5;
x0.psize=10^-5;
x0.pg=0.4;
x0.pon=0.3;
x0.pin=0.3;
x0.mz=0.05;
x0.mzp=10^-6;
x0.pex=0.5;
x0.omega=0.01;
x0.xsub=5;
x0.qh=2*10^-9;
x0.qc=2*10^-9;
x0.qe=2*10^-7;
x0.qz=2*10^-4;
x0.qv=2*10^-12;
x0.minh=0.01;
x0.minc=0.012;
x0.mine=0.011;
x0.monh=0.013;
x0.monc=0.014;
x0.mone=0.015;

x0_array = struct2array(x0);

% Lower bounds
xl.muh=1/2;
xl.kon=0.5/2;
xl.epsh=0.1/2;
xl.muc=1/2;
xl.kinc=0.5/10;
xl.mue=0.2;
xl.kine=0.5;
xl.phivh=10^-13;
xl.phivc=10^-13;
xl.phive=10^-12;
xl.betah=25/2;
xl.betac=25/2;
xl.betae=250/2;
xl.mvh=0.5/10;
xl.mvc=0.5/10;
xl.mve=0.5/10;
xl.psizh=10^-5/10;
xl.psizc=10^-5/10;
xl.psize=10^-5/10;
xl.pg=0.4;
xl.pon=0.3;
xl.pin=0.3;
xl.mz=0.05/2;
xl.mzp=10^-6/100;
xl.pex=0.5/2;
xl.omega=0.01/2;
xl.xsub=x0.xsub/2;
xl.qh=2*10^-9/4;
xl.qc=2*10^-9/4;
xl.qe=2*10^-7/4;
xl.qz=2*10^-4/4;
xl.qv=2*10^-12/4;
xl.minh=0.001;
xl.minc=0.001;
xl.mine=0.001;
xl.monh=0.005;
xl.monc=0.005;
xl.mone=0.005;

xl_array = struct2array(xl);

% Upper bounds
xu.muh=1*2;
xu.kon=0.5*2;
xu.epsh=0.1*2;
xu.muc=1*2;
xu.kinc=0.5*2;
xu.mue=2;
xu.kine=10;
xu.phivh=10^-12*100;
xu.phivc=10^-12*100;
xu.phive=10^-12*100;
xu.betah=25*2;
xu.betac=25*4;
xu.betae=250*2;
xu.mvh=5;
xu.mvc=5;
xu.mve=5;
xu.psizh=10^-5*10;
xu.psizc=10^-5*10;
xu.psize=10^-5*10;
xu.pg=0.4;
xu.pon=0.3;
xu.pin=0.3;
xu.mz=0.05*2;
xu.mzp=10^-6*100;
xu.pex=0.5*2;
xu.omega=0.01*2;
xu.xsub=x0.xsub*2;
xu.qh=2*10^-9*2;
xu.qc=2*10^-9*2;
xu.qe=2*10^-7*2;
xu.qz=2*10^-4*2;
xu.qv=2*10^-12*10;
xu.minh=0.10;
xu.minc=0.10;
xu.mine=0.10;
xu.monh=0.10;
xu.monc=0.10;
xu.mone=0.10;

xu_array = struct2array(xu);

% Move in log-space
x0_array=log(x0_array);
xl_array=log(xl_array);
xu_array=log(xu_array);

% The data
H_d=2*10^8;
C_d=2*10^8;
E_d=2*10^6;
Z_d=5*10^4;
Vh_d=2*10^9;
Vc_d=2*10^9;
Ve_d=2*10^7;
xon_d=5;
xin_d=0.1;
vtob = 10;
fracvh = 0.5;
fracvc = 0.25;
fracve = 0.10;
y_data_flux=[H_d C_d E_d Z_d Vh_d Vc_d Ve_d xon_d xin_d vtob fracvh fracvc fracve];

%Number of Resamples when doing Latin hypercube
nruns = 10;
%Number of Samples in Latin Hypercube
nS = 10^5;
%The total number of points sampled from parameter space is nruns*nS

fracfeasible = zeros(1,nruns);
clear stats
count=0;
more off
for j=1:nruns,
  j
  %Sample between upper and lower bounds (uniform prob. distribution)
  %I belive xl_array and xu_array are log(values) and hence we are
  %sampling uniformly in log-space
  LHSample = LHSmid(nS,xl_array,xu_array);
  for k=1:size(LHSample,1)
    tmpx0=array2vstruct(LHSample(k,:),fieldnames(x0));
    tmpx0_array=LHSample(k,:);
    options = optimset('MaxFunEvals',10000,'MaxIter',10000,'Algorithm','interior-point');
    % Create anonymous function
    f=@(x)vocmod_flux(x,y_data_flux);
    
    % Solution, using nonlinear optimization
    yinit_theory = voc_steady_flux(tmpx0_array);
    if (sum(yinit_theory>0)==length(yinit_theory));
      xt_array=fmincon(f,tmpx0_array,[],[],[],[],xl_array,xu_array,[],options);
      y_theory=voc_steady_flux(xt_array);
      % Interpretable solutions
      count=count+1;
      stats.dev(count)=vocmod_flux(xt_array,y_data_flux);
      xt_array=exp(xt_array); 
      stats.xt(count,:)=xt_array;
      stats.yt(count,:)=y_theory;
    end
  end
end
[tmpdev tmpi] = min(stats.dev);
xt_array=stats.xt(tmpi,:);
xt=array2vstruct(xt_array,fieldnames(x0));
note = 'Best fit is found by minima in stats.dev, in this case, it is stored in xt_array and xt';
save param_search_results_flux_lowHV stats y_data_flux xl_array xu_array xl xu xt xt_array;

