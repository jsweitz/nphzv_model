clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figdists_wv_nov_contours_targets';

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
set(gcf,'Position',[    275         214        1039         579]);

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

% Now plot target points
tmpvlist = [1 2 3 4 8 9];
more off
for i=1:6,
  if (i==2)
    subplot(2,3,i);
 % Plot the top stuff
 %   loglog(allynovirmat_C(posnovir_C,tmpvlist(i)),allywvirmat(posnovir_C,tmpvlist(i)),'k.');
    tmph=loglog(stats_top.y_noviruses_C(:,tmpvlist(i)),stats_top.y(:,tmpvlist(i)),'ko');
    set(tmph,'markersize',6,'markerfacecolor',[0.3 0.3 0.3]);
    hold on
    x=log10(allynovirmat_C(posnovir_C,tmpvlist(i)));
    y=log10(allywvirmat(posnovir_C,tmpvlist(i)));
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
    contour(10.^vXLabel,10.^vYLabel,mHist2d/sum(sum(mHist2d)),10);
    hold on
  elseif (i==3)
    subplot(2,3,i);
 % Plot the top stuff
 %   loglog(allynovirmat_C(posnovir_C,tmpvlist(i)),allywvirmat(posnovir_C,tmpvlist(i)),'k.');
    tmph=loglog(stats_top.y_noviruses_E(:,tmpvlist(i)),stats_top.y(:,tmpvlist(i)),'ko');
    set(tmph,'markersize',6,'markerfacecolor',[0.3 0.3 0.3]);
    hold on
    x=log10(allynovirmat_E(posnovir_E,tmpvlist(i)));
    y=log10(allywvirmat(posnovir_E,tmpvlist(i)));
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
    contour(10.^vXLabel,10.^vYLabel,mHist2d/sum(sum(mHist2d)),10);
    hold on
  else
    subplot(2,3,i);
 % Plot the top stuff
    loglog(allynovirmat_C(posnovir_C,tmpvlist(i)),allywvirmat(posnovir_C,tmpvlist(i)),'k.');
 %   tmph=loglog((stats_top.y_noviruses_E(:,tmpvlist(i))+stats_top.y_noviruses_C(:,tmpvlist(i)))/2,stats_top.y(:,tmpvlist(i)),'ko');
    tmph=loglog((stats_top.y_noviruses_C(:,tmpvlist(i))+stats_top.y_noviruses_C(:,tmpvlist(i)))/2,stats_top.y(:,tmpvlist(i)),'ko');
    set(tmph,'markersize',6,'markerfacecolor',[0.3 0.3 0.3]);
    hold on
    x=log10(allynovirmat_C(posnovir_C,tmpvlist(i)));
    y=log10(allywvirmat(posnovir_C,tmpvlist(i)));
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
    contour(10.^vXLabel,10.^vYLabel,mHist2d/sum(sum(mHist2d)),10);
    hold on
  end
end
for i=1:6,
  i
  subplot(2,3,i);
  vmin=min(allywvirmat(posnovir_C,tmpvlist(i)));
  vmax=max(allywvirmat(posnovir_C,tmpvlist(i)));
  if (i==6)
    vmin =10^-3;
    vmax=10^1;
  elseif (i==5)
    vmin =10^-2;
    vmax=10^2;
  end
  tmph=loglog([vmin vmax],[vmin vmax],'r-');
  set(tmph,'linewidth',3);
  axis square
  xlim([0.9*vmin 1.1*vmax]);
  ylim([0.9*vmin 1.1*vmax]);
  set(gca,'xtick',10.^[-15:1:15]);
  set(gca,'ytick',10.^[-15:1:15]);
  title(siminfo.species.fullnames{tmpvlist(i)},'fontsize',12,'interpreter','latex','horizontalalignment','center');
  if (i==5),
    title('Organic N','fontsize',12,'interpreter','latex','horizontalalignment','center');
  end
  xlabel('without Viruses','fontsize',14,'verticalalignment','top','interpreter','latex');
  ylabel('with Viruses','fontsize',14,'verticalalignment','bottom','interpreter','latex');
end

% Plot the top stuff
for i=1:6,
  if (i~=3)
    subplot(2,3,i);
 % Plot the top stuff
 %   loglog(allynovirmat_C(posnovir_C,tmpvlist(i)),allywvirmat(posnovir_C,tmpvlist(i)),'k.');
    tmph=loglog(stats_top.y_noviruses_C(:,tmpvlist(i)),stats_top.y(:,tmpvlist(i)),'ko');
    set(tmph,'markersize',8,'color',[0.3 0.3 0.3],'markerfacecolor',[0.5 0.5 0.5]);
  end
  if (i==3)
    subplot(2,3,i);
 % Plot the top stuff
 %   loglog(allynovirmat_C(posnovir_C,tmpvlist(i)),allywvirmat(posnovir_C,tmpvlist(i)),'k.');
    tmph=loglog(stats_top.y_noviruses_E(:,tmpvlist(i)),stats_top.y(:,tmpvlist(i)),'ko');
    set(tmph,'markersize',8,'color',[0.3 0.3 0.3],'markerfacecolor',[0.5 0.5 0.5]);
  end
end

if (i==6)
  xlim([10^-3 10^1]);
  ylim([10^-3 10^1]);
end
if (i==5)
  xlim([10^-2 10^2]);
  ylim([10^-2 10^2]);
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
more on
