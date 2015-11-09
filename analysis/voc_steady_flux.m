function y_theory = voc_steady_flux(x)
% function y_theory = voc_steady_flux(x)
% This function moves in the 38 parameter space of the
% model to find values compatible with a desired output
%
% Which, in this version, also includes trying to get the
% q-values aligned
%
% Modified October 8, 2012 to ensure that outcomes of grazing
% equal to 1
% pin=1-x(21)-x(20);

% Move out of log-space
x=exp(x);

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

% The theory
H=mvh/(betah*phivh);
C=mvc/(betac*phivc);
E=mve/(betae*phive);
Z=(pg/qz*(qh*psizh*H+qc*psizc*C+qe*psize*E)-mz)/(mzp);
xin=xsub-qz*mzp*Z^2/omega;
Vc=(muc*xin/(xin+kinc)-psizc*Z-minc-monc)/phivc;
Ve=(mue*xin/(xin+kine)-psize*Z-mine-mone)/phive;
% Then following the text
aleph = -qh*H/epsh*(psizh*Z+minh+monh)+qv*mvc*Vc+qv*mve*Ve+(qc-qv*betac)*phivc*C*Vc+(qe-qv*betae)*phive*E*Ve+pon*Z*(qh*psizh*H+qc*psizc*C+qe*psize*E)+qh*monh*H+qc*monc*C+qe*mone*E;
Vh=aleph/(qh*phivh*H/epsh-qv*mvh-(qh-qv*betah)*phivh*H);
xon=kon*(phivh*Vh+psizh*Z+minh+monh)/(muh-phivh*Vh-psizh*Z-minh-monh);
vtob=(Vh+Vc)/(H+C);
fracvh=phivh*Vh/(phivh*Vh+psizh*Z);
fracvc=phivc*Vc/(phivc*Vc+psizc*Z);
fracve=phive*Ve/(phive*Ve+psize*Z);

% The answer
y_theory=[H C E Z Vh Vc Ve xon xin vtob fracvh fracvc fracve];

