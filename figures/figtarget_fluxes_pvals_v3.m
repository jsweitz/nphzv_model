clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figtarget_fluxes_pvals_v3';

tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

%tmppos= [0.2 0.2 0.7 0.7];
%tmpa1 = axes('position',tmppos);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');
set(gcf,'Position',[414 52 682 736]);

% main data goes here
% This is where we look at distributions of the parameters themselves
load param_search_results_flux_lowHV
parnames = {'muh','kon','epsh','muc','kinc','mue','kine','phivh','phivc',...
    'phive','betah','betac','betae','mvh','mvc','mve','psizh','psizc',...
    'psize',...%'pg','pon','pin',
    'mz','mzp','pex','omega','xsub','qh','qc',...
    'qe','qz','qv','minh','minc','mine','monh','monc','mone'};
latexparnames = {'\mu_H','k_{on}','\epsilon_H','\mu_C','k_{in,C}','\mu_E','k_{in,E}','\phi_{VH}','\phi_{VC}',...
    '\phi_{VE}','\beta_H','\beta_C','\beta_E','m_{VH}','m_{VC}','m_{VE}','\psi_{ZH}','\psi_{ZC}',...
    '\psi_{ZE}',...%'p_g','p_{on}','p_{in}',
    'm_Z','m_{ZP}','p_{ex}','\omega','x_{sub}','q_H','q_C',...
    'q_E','q_Z','q_V','m_{in,H}','m_{in,C}','m_{in,E}','m_{on,H}','m_{on,C}','m_{on,E}'};
latexparnames_dollars = {'$\mu_H$','$k_{on}$','$\epsilon_H$','$\mu_C$','$k_{in,C}$','$\mu_E$','$k_{in,E}$','$\phi_{VH}$','$\phi_{VC}$',...
    '$\phi_{VE}$','$\beta_H$','$\beta_C$','$\beta_E$','$m_{VH}$','$m_{VC}$','$m_{VE}$','$\psi_{ZH}$','$\psi_{ZC}$',...
    '$\psi_{ZE}$',...%'p_g','p_{on}','p_{in}',
    '$m_Z$','$m_{ZP}$','$p_{ex}$','$\omega$','$x_{sub}$','$q_H$','$q_C$',...
    '$q_E$','$q_Z$','$q_V$','$m_{in,H}$','$m_{in,C}$','$m_{in,E}$','$m_{on,H}$','$m_{on,C}$','$m_{on,E}$'};
npars = length(parnames);

[tmpdvals tmpdlist] =sort(stats.dev);
numds=floor(0.05*length(tmpdlist));
goodlist=tmpdlist(1:numds);
plistvary = [1:19 23:38];
for i=1:length(plistvary),
  if (i<=18)
    tmppos= [0.1 0.9-0.8*i/18 0.35 0.8/48];
  else
    tmppos= [0.6 0.9-0.8*(i-18)/18 0.35 0.8/48];
  end
  tmpa1 = axes('position',tmppos);
  %subplot(6,6,i);
  tmpprange = linspace(xl_array(plistvary(i)),xu_array(plistvary(i)),25);
  [tmpn,tmpyval]=hist(log(stats.xt(goodlist,plistvary(i))),tmpprange);
  %bar(tmpyval,tmpn);
  %xlim([(xl_array(plistvary(i))) (xu_array(plistvary(i)))]);
  imagesc(tmpn);
  %colormap('hsv');
  xlim([0.5 25.5]);
  ylim([0.5 1]);
  axis off
  tmpt=text(-4,0.5,latexparnames_dollars{i});
  set(tmpt,'interpreter','latex','fontsize',14);
  hold on
%  tmpf=plot([0.5 25.5 25.5 0.5 0.5],[0.55 0.55 1.0 1.0 0.55],'g-');
  [tmpm tmppmini]=min(stats.dev);
  [tmpd tmpimpos]=min((log(stats.xt(tmppmini,plistvary(i)))-tmpprange).^2);
  tmpf=plot(tmpimpos,0.75,'gd');
  set(tmpf,'markerfacecolor','g');
end
% Now compare to the general values
load ss_flux_LHS_lowHV
'Now to pvalid'
for i=1:length(plistvary),
  if (i<=18)
    tmppos= [0.1 0.9-0.8*i/18+0.8/48 0.35 0.8/48];
  else
    tmppos= [0.6 0.9-0.8*(i-18)/18+0.8/48 0.35 0.8/48];
  end
  tmpa1 = axes('position',tmppos);
  %subplot(6,6,i);
  [tmpn,tmpyval]=hist(pvalid(:,plistvary(i)),linspace(xl_array(plistvary(i)),xu_array(plistvary(i)),25));
  %bar(tmpyval,tmpn);
  %xlim([(xl_array(plistvary(i))) (xu_array(plistvary(i)))]);
  imagesc(tmpn);
  cmap=repmat(linspace(0.25,1,64)',1,3);
  colormap(cmap);
  xlim([0.5 25.5]);
  ylim([0.5 1]);
  axis off
%  tmpt=text(-4,0.75,latexparnames_dollars{i});
%  set(tmpt,'interpreter','latex','fontsize',14);
end
% This yields pvalid

% loglog(,, '');


% for use with layered plots
% set(gca,'box','off')

% adjust limits
% tmpv = axis;
% axis([]);
% ylim([]);
% xlim([]);

% change axis line width (default is 0.5)
% set(tmpa1,'linewidth',2)

% fix up tickmarks
% set(gca,'xtick',[1 100 10^4])

% creation of postscript for papers
% psprint(tmpxfigfilename);

% the following will usually not be printed 
% in good copy for papers
% (except for legend without labels)

% legend
% tmplh = legend('stuff',...);
% tmplh = legend('','','');
% remove box
% set(tmplh,'visible','off')
% legend('boxoff');

%xlabel('','fontsize',24,'verticalalignment','top');
%ylabel('','fontsize',24,'verticalalignment','bottom');
% title('','fontsize',24)
% 'horizontalalignment','left');

% for writing over the top
% coordinates are normalized again to (0,1.0)
tmpa2 = axes('Position', tmppos);
set(tmpa2,'visible','off');
% Adding the annotations
%tmph=plot(0.3,0.03,'ro');
%set(tmph,'markerfacecolor','r');
%set(tmph,'markersize',12);
%tmph=plot(0.3,0.02,'gd');
%set(tmph,'markerfacecolor','g');
%set(tmph,'markersize',12);
%text(0.3,0.05,'hello','fontsize',16);
%axis off
% first two points are normalized x, y positions
% text(,,'','Fontsize',14);

% automatic creation of postscript
% without name/date
psprintc(tmpfilenoname);

tmpt = pwd;
tmpnamememo = sprintf('[source=%s/%s.ps]',tmpt,tmpprintname);
text(1.05,.05,tmpnamememo,'Fontsize',6,'rotation',90);
datenamer(1.1,.05,90);
% datename(.5,.05);
% datename2(.5,.05); % 2 rows

% automatic creation of postscript
psprintc(tmpfilename);

% set following on if zooming of 
% plots is required
% may need to get legend up as well
%axes(tmpa1)
%axes(tmplh)
clear tmp*
