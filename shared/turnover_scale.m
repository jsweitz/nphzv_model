function tau = turnover_scale(x,p)
% function tau = turnover_scale(x,p)
%
% Returns the per-variable turnover scale given the 
% parameters p and the steady state densities x 
%
% For example, in practice, do the following
%  tau=turnover_scale(x,params)
%  tdown(i,:)=tau(:,1)';
%  tup(i,:)=tau(:,2)';

%parameters
muh=p(1);
kon=p(2);
epsh=p(3);
muc=p(4);
kinc=p(5);
mue=p(6);
kine=p(7);
phivh=p(8);
phivc=p(9);
phive=p(10);
betah=p(11);
betac=p(12);
betae=p(13);
mvh=p(14);
mvc=p(15);
mve=p(16);
psizh=p(17);
psizc=p(18);
psize=p(19);
pg=p(20);
pon=p(21);
pin=1-p(21)-p(20);
mz=p(23);
mzp=p(24);
pex=p(25);
omega=p(26);
xsub=p(27);
qh=p(28);
qc=p(29);
qe=p(30);
qz=p(31);
qv=p(32);
minH=p(33);
minC=p(34);
minE=p(35);
monH=p(36);
monC=p(37);
monE=p(38);

%variables
H = x(1);
C1 = x(2);
E1 = x(3);
Z = x(4);
Vh = x(5);
Vc = x(6);
Ve = x(7);
xon = x(8);
xin = x(9);


%Combine Variable DE and Sensitivity DE
% Split + and - parts to get turnover times
fdots_split=[H.*minH+H.*monH+H.*phivh.*Vh+H.*psizh.*Z, H.*muh.*xon.*(kon+xon).^(-1);  % H
C1.*minC+C1.*monC+C1.*phivc.*Vc+C1.*psizc.*Z, C1.*muc.*xin.*(kinc+xin).^(-1);   % C 
E1.*minE+E1.*monE+E1.*phive.*Ve+E1.*psize.*Z, E1.*mue.*xin.*(kine+xin).^(-1);  % E
mz.*Z+mzp.*Z.^2, pg.*(C1.*psizc.*qc.*qz.^(-1).*Z+E1.*psize.*qe.*qz.^(-1).*Z+H.*psizh.*qh.*qz.^(-1).*Z);  % Z
mvh.*Vh, betah.*H.*phivh.*Vh;   % Vh
mvc.*Vc, betac.*C1.*phivc.*Vc;  % Vc 
mve.*Ve, betae.*E1.*phive.*Ve;  % Ve
epsh.^(-1).*H.*muh.*qh.*xon.*(kon+xon).^(-1), C1.*monC.*qc+E1.*monE.*qe+H.*monH.*qh+mvc.*qv.*Vc+C1.*phivc.*(qc+(-1).*betac.*qv).*Vc+mve.*qv.*Ve+E1.*phive.*(qe+(-1).*betae.*qv).*Ve+mvh.*qv.*Vh+H.*phivh.*(qh+(-1).*betah.*qv).*Vh+ C1.*pon.*psizc.*qc.*Z+E1.*pon.*psize.*qe.*Z+H.*pon.*psizh.*qh.*Z;  % xon
C1.*muc.*qc.*xin.*(kinc+xin).^(-1)+E1.*mue.*qe.*xin.*(kine+xin).^(-1)+omega.*xin, C1.*minC.*qc+E1.*minE.*qe+H.*minH.*qh+(1+(-1).*epsh).*epsh.^(-1).*H.*muh.*qh.*xon.*(kon+xon).^(-1)+ omega.*xsub+ C1.*pin.*psizc.*qc.*Z+E1.*pin.*psize.*qe.*Z+H.*pin.*psizh.*qh.*Z+mz.*qz.*Z];  % Done
tau(:,1)=x'./fdots_split(:,1);
tau(:,2)=x'./fdots_split(:,2);

