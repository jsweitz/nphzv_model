clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figflux_export_contours_targets';

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

% main data goes here
%
%  Data 1
%  this is the LHS sampled data with flux measurements
load ss_flux_LHS_lowHV.mat
%
%  Data 2
%  gives names to all events, species and parameters
load siminfo_details.mat
%
%  Data 3
%  Provides targeted information for the flux
load stability_solution_analysis
%
%  Data 4
%  first run master_pipeline_targets.m in this directory
load ss_flux_target

% Plot the targets
% Fix 
%x=(stats_top.flux.export_novE+stats_top.flux.export_novC)/2;
x=stats_top.flux.export_novC;
y=stats_top.flux.export;
tmph=plot(x,y,'ko');
set(tmph,'markersize',6);
hold on
% tmpvalid = intersect(posnovir_C,posnovir_E);  % Both valid solutions
tmpvalid = intersect(posnovir_C,posnovir_C);  % Both valid solutions
% x=((flux.export_novE(tmpvalid)+flux.export_novC(tmpvalid))/2)';
x=(flux.export_novC(tmpvalid))';
y=(flux.export(tmpvalid))';
mYX = [y,x];
nxbins=25;
nybins=25;
minx = min(x);
maxx = max(x);
miny = min(y);
maxy = max(y);
stepx = (maxx-minx)/(nxbins+1);
stepy = (maxy-miny)/(nybins+1);
xc = (linspace(minx,maxx,nxbins+1))';
yc = (linspace(miny,maxy,nybins+1))';
nXBins = length(xc);
nYBins = length(yc);
vXLabel = 0.5*(xc(1:(nXBins-1))+xc(2:nXBins)); 
vYLabel = 0.5*(yc(1:(nYBins-1))+yc(2:nYBins)); 
mHist2d = hist2d_mat(mYX,yc,xc);
contour(vXLabel,vYLabel,mHist2d/sum(sum(mHist2d)),20);
set(gca,'fontsize',20);

% Plot 1:1 line  
vmin=min([x;y]);
vmax=max([x;y]);
tmph=plot([vmin vmax],[vmin vmax],'r-');
set(tmph,'linewidth',3);
axis square
xlim([vmin vmax]);
ylim([vmin vmax]);
set(gca,'xtick',[0:0.05:0.2]);
set(gca,'ytick',[0:0.05:0.2]);
title('Trophic transfer','fontsize',20,'interpreter','latex','horizontalalignment','center');
xlabel('without Viruses','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('with Viruses','fontsize',20,'verticalalignment','bottom','interpreter','latex');

% Plot the top stuff over again
% x=(stats_top.flux.export_novE+stats_top.flux.export_novC)/2;
x=stats_top.flux.export_novC;
y=stats_top.flux.export;
tmph=plot(x,y,'ko');
set(tmph,'markersize',6,'markerfacecolor',[0.3 0.3 0.3]);



  

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
