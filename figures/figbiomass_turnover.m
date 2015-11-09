clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figbiomass_turnover';
tmpfilebwname = sprintf('%s_noname_bw',tmpfilename);
tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');
set(gcf,'Position',[ 106          45        1094         761]);

% main data goes here
load ss_flux_tau_target
load stability_solution_analysis
% loglog(,, '');
tmpsnames = {'$H$';'$C$';'$E$';'$Z$';'$V_H$';'$V_C$';'$V_E$';'$x_{on}$';'$x_{in}$'};
for i=1:9,
  subplot(3,3,i);
  tmph=plot(stats_top.y(:,i),stats_top.tup_wv(:,i),'ko');
  set(tmph,'markersize',6,'markerfacecolor',[0.3 0.3 0.3]);
  set(gca,'fontsize',18);
  xlabel('Density $/$L','fontsize',18,'verticalalignment','top','interpreter','latex');
  ylabel('Turnover (days)','fontsize',18,'verticalalignment','bottom','interpreter','latex');
  tmpxlim = get(gca,'xlim');
  tmpylim = get(gca,'ylim');
  tmpt=text(tmpxlim(2)-(tmpxlim(2)-tmpxlim(1))*0.15,tmpylim(2)-(tmpylim(2)-tmpylim(1))*0.1,tmpsnames(i));
  set(tmpt,'interpreter','latex','fontsize',16);
  set(gca,'xlim',tmpxlim);
  set(gca,'ylim',tmpylim);
end

%
%
% Some helpful plot commands
% tmph=plot(x,y,'ko');
% set(tmph,'markersize',10,'markerfacecolor,'k');
% tmph=plot(x,y,'k-');
% set(tmph,'linewidth',2);


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
% set(gca,'ytick',[1 100 10^4])

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

% title('','fontsize',24)
% 'horizontalalignment','left');

% for writing over the top
% coordinates are normalized again to (0,1.0)
tmpa2 = axes('Position', tmppos);
set(tmpa2,'visible','off');
% first two points are normalized x, y positions
% text(,,'','Fontsize',14);

% automatic creation of postscript
% without name/date
psprintc(tmpfilenoname);
psprint(tmpfilebwname);

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
