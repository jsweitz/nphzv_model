clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figtarget_fluxes_v2';

tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

tmppos= [0.2 0.1 0.7 0.8];
tmpa1 = axes('position',tmppos);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');
set(gcf,'Position',[214 100 782 775]);

% main data goes here
load param_search_results_flux_lowHV.mat
tmpnames={
'$log_{10}$ Heterotrophs, /L';
'$log_{10}$ Cyanobacteria, /L';
'$log_{10}$ Euk. autotrophs, /L';
'$log_{10}$ Zooplankton, /L';
'$log_{10}$ Viruses of H, /L';
'$log_{10}$ Viruses of C, /L';
'$log_{10}$ Viruses of E, /L';
'DON $\mu$mol/L';
'DIN $\mu$mol/L';
'V to B ratio'
'\% of H mortality due to V-s';
'\% of C mortality due to V-s';
'\% of E mortality due to V-s';
}
[tmpdvals tmpdlist] =sort(stats.dev);
numds=floor(0.05*length(tmpdlist));
goodlist=tmpdlist(1:numds);

for i=1:7
  subplot(5,3,i);
  [tmpn tmpyval]=hist(log10(stats.yt(tmpdlist(1:numds),i)),25);
  bar(tmpyval,tmpn);
  hold on
  tmph=plot(log10(y_data_flux(i)),0,'ro');
  set(tmph,'markerfacecolor','r');
  set(tmph,'markersize',12);
  [tmpm tmpi]=min(stats.dev);
  tmph=plot(log10(stats.yt(tmpi,i)),0,'gd');
  set(tmph,'markerfacecolor','g');
  set(tmph,'markersize',12);
  tmpt=title(tmpnames{i},'fontsize',14);
  set(tmpt,'interpreter','latex');
  set(gca,'fontsize',14);
%  set(tmpt,'interpreter','latex');
  xlim([-0.5+min(tmpyval) 0.5+max(tmpyval)]);
end
for i=8:13
  subplot(5,3,i);
  [tmpn tmpyval]=hist(stats.yt(tmpdlist(1:numds),i),25);
  bar(tmpyval,tmpn);
  hold on
  tmph=plot(y_data_flux(i),0,'ro');
  set(tmph,'markerfacecolor','r');
  set(tmph,'markersize',12);
  [tmpm tmpi]=min(stats.dev);
  tmph=plot(stats.yt(tmpi,i),0,'gd');
  set(tmph,'markerfacecolor','g');
  set(tmph,'markersize',12);
  tmpt=title(tmpnames{i},'fontsize',14);
  set(tmpt,'interpreter','latex');
  set(gca,'fontsize',14);
%  set(tmpt,'interpreter','latex');
  xlim([0 1]);
  if (i==13)
    xlim([0 0.2]);
  elseif (i==10)
    xlim([5 30]);
  elseif (i==9)
    xlim([0 0.2]);
  elseif (i==8)
    xlim([0 10]);
  end
end

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

xlabel('','fontsize',24,'verticalalignment','top');
ylabel('','fontsize',24,'verticalalignment','bottom');
% title('','fontsize',24)
% 'horizontalalignment','left');

% for writing over the top
% coordinates are normalized again to (0,1.0)
tmpa2 = axes('Position', tmppos);
set(tmpa2,'visible','off');
tmpt= text (0.34,0.14,'Distribution of top 5\% of model predictions');
set(tmpt,'interpreter','latex','fontsize',14);
tmpt = text (0.34,0.08,'Target output for parameter optimization scheme');
set(tmpt,'interpreter','latex','fontsize',14);
tmpt = text (0.34,0.02,'Best hit within a single model replicate');
set(tmpt,'interpreter','latex','fontsize',14);

% More annotation
tmpa2 = axes('Position',[0.385 0.11 0.05 0.125]);
tmpt = plot(0.6,0.45,'ro');
set(tmpt,'markersize',12,'markerfacecolor','r');
hold on
xlim([0 1]);
ylim([0 1]);
tmpt = plot(0.6,0.05,'gd');
set(tmpt,'markersize',12,'markerfacecolor','g');
tmpt = patch(-0.2+[0.7 0.9 0.9 0.7 0.7],-0.025+[0.8 0.8 1 1 0.8],'k');
set(tmpt,'facecolor','b');
axis off
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
