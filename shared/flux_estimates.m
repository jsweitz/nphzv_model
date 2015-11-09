function yfluxes = flux_estimates(y,xp_array)
% function yfluxes = flux_estimates(y,xp_array)
% 
% Calcualtes the fluxes between functional groups in y
% given their values and the parameters in xp_array
%
% I will lump in terms of 
% bacteria, phytoplankton, zooplankton, viruses, inorganic, organic, higher trophics, external

% Convert the array from log space
x=exp(xp_array);

muh=x(1);
kon=x(2);
epsh=x(3);
muc=x(4);
kinc=x(5);
mue=x(6);
kine=x(7);
phivh=x(8);
phivc=x(9);
phive=x(10);
betah=x(11);
betac=x(12);
betae=x(13);
mvh=x(14);
mvc=x(15);
mve=x(16);
psizh=x(17);
psizc=x(18);
psize=x(19);
pg=x(20);
pon=x(21);
pin=1-x(21)-x(20);
mz=x(23);
mzp=x(24);
pex=x(25);
omega=x(26);
xsub=x(27);
qh=x(28);
qc=x(29);
qe=x(30);
qz=x(31);
qv=x(32);
minh=x(33);
minc=x(34);
mine=x(35);
monh=x(36);
monc=x(37);
mone=x(38);

% Convert the variables
C=y(1);
H=y(2);
E=y(3);
Z=y(4);
Vh=y(5);
Vc=y(6);
Ve=y(7);
xon=y(8);
xin=y(9);

yfluxes.p_to_v=qe*phive*E*Ve+qc*phivc*C*Vc;
yfluxes.p_to_z=qe*psize*E*Z+qc*psizc*C*Z;
yfluxes.in_to_p=qc*muc*C*xin/(xin+kinc)+qe*mue*E*xin/(xin+kine);
yfluxes.p_to_on=(qe-qv*betae)*phive*E*Ve+(qc-qv*betac)*phivc*C*Vc+pon*qe*psize*E*Z+pon*qc*psizc*C*Z+qc*monc*C+qe*mone*E;
yfluxes.b_to_on=(qh-qv*betah)*phivh*H*Vh+pin*qh*psizh*H*Z+qh*monh*H;
yfluxes.export=-omega*(xin-xsub);
yfluxes.btov=qh*phivh*H*Vh;
yfluxes.btoz=qh*psizh*H*Z;
