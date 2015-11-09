clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'fignpp_baseline';
tmpfilebwname = sprintf('%s_noname_bw',tmpfilename);
tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);


set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);
tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);

set(gcf,'PaperPositionMode','auto');

% main data goes here
% load ss_flux_target
% uM N /day
% Uses a series of pre-generated data
tmps = 'param_search_results_flux_lowHV';
load(tmps);
tmps = 'ss_flux_target';
load(tmps);
[tmpd tmpi]=sort(stats.dev,'ascend');
stats_top.xt = stats.xt(tmpi(1:stats.numtop5),:);
stats_top.yt = stats.yt(tmpi(1:stats.numtop5),1:9);
for i=1:stats.numtop5,
  yfluxes(i) = flux_estimates(stats_top.yt(i,:),log(stats_top.xt(i,:)));
end
npp = [yfluxes.in_to_p];
npp_alt = npp * (106/16) * (10^-3) * (10^3) * (12.01) * (25);  % Correct units
[f_npp,npp_hist]=hist(npp_alt,20);
bar(npp_hist,f_npp/sum(f_npp));
xlim([200 2000]);
set(gca,'fontsize',18);
xlabel('NPP, mg C m$^{-2}$ day$^{-1}$ ','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Frequency of NPP ','fontsize',20,'verticalalignment','bottom','interpreter','latex');
set(gca,'ytick',[0 0.05 0.1 0.15 0.2]);
ylim([0 0.15]);

% Conversion is C:N (106/16)
% then umol -> mmol (10^-3)
% then 1000 L in 1 m^3
% then 12.01 g C per mol
% assuming a 20 m euphotic zone

% loglog(,, '');
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
