function [y_theory_C y_theory_E numsols_C numsols_E] = nov_steady_numsols(x)
% function [y_theory_C y_theory_E numsols_C numsols_E] = nov_steady_numsols(x)
%
% Returns the theoretical values of the steady state given some values
% of all of the parameters without viruses!  Hence nov = No Viruses
%
% The two returned values are possible solutions with C and one with E
% both are not possible.
%
% Also - note that the numsols returns the number of viable positive solutions

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

% The theory if there is E and no C
Cconst = qz*mzp/omega/psize^2;
me = mine+mone;
mh = minh+monh;
mc = minc+monc;

c2 = 2*kine-xsub+Cconst*mue^2-2*Cconst*me*mue+Cconst*me^2;
c1 = kine^2-2*xsub*kine-2*Cconst*me*mue*kine+2*Cconst*me^2*kine;
c0 = -xsub*kine^2+Cconst*me^2*kine^2;
tmpxin = roots([1 c2 c1 c0]); 
tmpi=find(tmpxin>0 & tmpxin<xsub);
numsols_E = length(tmpi);
if (length(tmpi)==1)
  xin=tmpxin(tmpi);
  Z = (omega*(xsub-xin)/(qz*mzp))^(0.5);
  xon = kon*(psizh*Z+monh+minh)/(muh-psizh*Z-monh-minh);
  tmpHtop = pon*qz*Z*(mz+mzp*Z)/pg+qe*mone*qz*(mz+mzp*Z)/(pg*qe*psize);
  tmpHbot = (qh*muh*xon)/(epsh*(xon+kon))-qh*monh+qe*mone*qh*psizh/qe/psize;
  H = tmpHtop/tmpHbot;
  E = (mzp*Z+mz-pg*qh*psizh*H/qz)*qz/(pg*qe*psize);
  Vc=0;
  Ve=0;
  Vh=0;
  C=0;
  y_theory_E=[H C E Z Vh Vc Ve xon xin];
elseif (length(tmpi)>1)
 xin_valid=tmpxin(tmpi)
% Note that although sometimes 2 solutions are found
% I have found that the solutions tend to be remarkably close
% and may be a double-root.  I just choose one at random
% THIS IS A PROBLEM - as I think I am choosing an unstable
% solution... so that precision leads to discrepancies...
 'E', tmpxin
 xin=xin_valid(1+(rand<0.5));
 Z = (omega*(xsub-xin)/(qz*mzp))^(0.5);
 xon = kon*(psizh*Z+monh +minh)/(muh-psizh*Z-monh-minh);
 tmpHtop = pon*qz*Z*(mz+mzp*Z)/pg+qe*mone*qz*(mz+mzp*Z)/(pg*qe*psize);
 tmpHbot = (qh*muh*xon)/(epsh*(xon+kon))-qh*monh+qe*mone*qh*psizh/qe/psize;
 H = tmpHtop/tmpHbot;
  E = (mzp*Z+mz-pg*qh*psizh*H/qz)*qz/(pg*qe*psize);
 Vc=0;
 Ve=0;
 Vh=0;
 C=0;
 y_theory_E=[H C E Z Vh Vc Ve xon xin];
else
  error('Too few solutions');
end

% The theory if there is C and no E
Cconst = qz*mzp/omega/psizc^2;
me = mine+mone;
mh = minh+monh;
mc = minc+monc;

c2 = 2*kinc-xsub+Cconst*muc^2-2*Cconst*mc*muc+Cconst*mc^2;
c1 = kinc^2-2*xsub*kinc-2*Cconst*mc*muc*kinc+2*Cconst*mc^2*kinc;
c0 = -xsub*kinc^2+Cconst*mc^2*kinc^2;
tmpxin = roots([1 c2 c1 c0]); 
tmpi=find(tmpxin>0 & tmpxin<xsub);
numsols_C = length(tmpi);
if (length(tmpi)==1)
  xin=tmpxin(tmpi);
  Z = (omega*(xsub-xin)/(qz*mzp))^(0.5);
  xon = kon*(psizh*Z+monh+minh)/(muh-psizh*Z-monh-minh);
  tmpHtop = pon*qz*Z*(mz+mzp*Z)/pg+qc*monc*qz*(mz+mzp*Z)/(pg*qc*psizc);
  tmpHbot = (qh*muh*xon)/(epsh*(xon+kon))-qh*monh+qc*monc*qh*psizh/qc/psizc;
  H = tmpHtop/tmpHbot;
  C = (mzp*Z+mz-pg*qh*psizh*H/qz)*qz/(pg*qc*psizc);
  Vc=0;
  Ve=0;
  Vh=0;
  E=0;
  y_theory_C=[H C E Z Vh Vc Ve xon xin];
elseif (length(tmpi)>1)
 'C', tmpxin
 xin_valid=tmpxin(tmpi);
 xin=xin_valid(1+(rand<0.5));
 Z = (omega*(xsub-xin)/(qz*mzp))^(0.5);
 xon = kon*(psizh*Z+monh+minh)/(muh-psizh*Z-monh-minh);
 tmpHtop = pon*qz*Z*(mz+mzp*Z)/pg+qc*monc*qz*(mz+mzp*Z)/(pg*qc*psizc);
 tmpHbot = (qh*muh*xon)/(epsh*(xon+kon))-qh*monh+qc*monc*qh*psizh/qc/psizc;
 H = tmpHtop/tmpHbot;
 C = (mzp*Z+mz-pg*qh*psizh*H/qz)*qz/(pg*qc*psizc);
 Vc=0;
 Ve=0;
 Vh=0;
 E=0;
 y_theory_C=[H C E Z Vh Vc Ve xon xin];
else
  error('Too few solutions');
end
