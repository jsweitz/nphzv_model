%%
%Sloppy-Stiff script
load('ss_flux_target.mat')

pars = stats_top.params(1,:);      %reference pars -- make a row vector
vars = stats_top.y(1,:);
[H, Hlog] = hessian_generate(pars,vars);
%%
%cells with strings useful in plotting
varnames = {'H','C','E','Z','V_H','V_C','V_E','x_on','x_in'};
latexvarnames = {'H','C','E','Z','V_H','V_C','V_E','x_{on}','x_{in}'};
latexvarnames_dollars = {'$H$','$C$','$E$','$Z$','$V_H$','$V_C$','$V_E$','$x_{on}$','$x_{in}$'};
parnames = {'muh','kon','epsh','muc','kinc','mue','kine','phivh','phivc',...
    'phive','betah','betac','betae','mvh','mvc','mve','psizh','psizc',...
    'psize',...%'pg','pon','pin',...these parameters are ignored in analysis
    'mz','mzp','pex','omega','xsub','qh','qc',...
    'qe','qz','qv','minh','minc','mine','monh','monc','mone'};
latexparnames = {'\mu_H','k_{on}','\epsilon_H','\mu_C','k_{in,C}','\mu_E','k_{in,E}','\phi_{VH}','\phi_{VC}',...
    '\phi_{VE}','\beta_H','\beta_C','\beta_E','m_{VH}','m_{VC}','m_{VE}','\psi_{ZH}','\psi_{ZC}',...
    '\psi_{ZE}',...%'p_g','p_{on}','p_{in}',...
    'm_Z','m_{ZP}','p_{ex}','\omega','x_{sub}','q_H','q_C',...
    'q_E','q_Z','q_V','m_{in,H}','m_{in,C}','m_{in,E}','m_{on,H}','m_{on,C}','m_{on,E}'};
latexparnames_dollars = {'$\mu_H$','$k_{on}$','$\epsilon_H$','$\mu_C$','$k_{in,C}$','$\mu_E$','$k_{in,E}$','$\phi_{VH}$','$\phi_{VC}$',...
    '$\phi_{VE}$','$\beta_H$','$\beta_C$','$\beta_E$','$m_{VH}$','$m_{VC}$','$m_{VE}$','$\psi_{ZH}$','$\psi_{ZC}$',...
    '$\psi_{ZE}$',...%'$p_g$','$p_{on}$','$p_{in}$',...
    '$m_Z$','$m_{ZP}$','$p_{ex}$','$\omega$','$x_{sub}$','$q_H$','$q_C$',...
    '$q_E$','$q_Z$','$q_V$','$m_{in,H}$','$m_{in,C}$','$m_{in,E}$','$m_{on,H}$','$m_{on,C}$','$m_{on,E}$'};
npars = length(parnames);

%%
%Eigenvalue spectrum for log space, used in supplementary
[eigveclog,eigvallog] = eig(Hlog);

eigvallog = eigvallog./max(max(abs(eigvallog)));
eigvallog = diag(eigvallog);


%%
%Sloppy stiff eigenvalues

lambnames = {'$\lambda_0$','$\lambda_1$','$\lambda_2$','$\lambda_3$',...
    '$\lambda_4$','$\lambda_5$','$\lambda_6$','$\lambda_7$',...
    '$\lambda_8$','$\lambda_9$'};
thisplot = eigvallog(end-9:end);
thisplot = flipud(thisplot);
figure(1)
plot(1:10,thisplot,'k.','MarkerSize',20);
xlim([0 11])
ylim([10^-17 10])
title('Eigenvalue Spectrum (max 10 shown)','FontSize',20)
ylabel('\lambda / \lambda_0','FontSize',20)
set(gca,'Yscale','log','FontSize',16,'Xtick',1:10)
xticklabel_rotate(1:10,0,lambnames,'interpreter','latex','FontSize',20)

%%
%rank pars
eigveclast = abs(eigveclog(:,end));
numimp = 20;
[vals,indy] = sort(eigveclast,'descend');

figure(2)
bar(vals(1:numimp))
xtickpts = 1:numimp;
xlim([0 numimp+1])
%set(gca,'Yscale','log')
set(gca,'FontSize',16)
xticklabel_rotate(xtickpts,90,latexparnames_dollars(indy(1:numimp)),'interpreter','latex','FontSize',16)
ylabel('value in \lambda_0','FontSize',20)
title('Eigenvector alignment (Max 20 shown)','FontSize',20)

