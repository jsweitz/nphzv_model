clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figcomm_comp_threestack_targets';
tmpfilebwname = sprintf('%s_noname_bw',tmpfilename);
tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

set(gcf,'PaperPositionMode','auto');

% main data goes here
load ss_flux_tau_target

fp=fopen('stats_comm_structure.mat')
if (fp<0)
  for i=1:4,
    stats_top.Ntot(:,i)=stats_top.y(:,i).*stats_top.params(:,27+i);
  end
  for i=5:7,
    stats_top.Ntot(:,i)=stats_top.y(:,i).*stats_top.params(:,32);
  end
  for i=8:9,
    stats_top.Ntot(:,i)=stats_top.y(:,i);
  end
  
  % Now compare to the without virus case
  % 
  i=1;
  stats_top.Ntot_nov(:,i)= (stats_top.y_noviruses_C(:,i).*stats_top.params(:,27+i)+stats_top.y_noviruses_E(:,i).*stats_top.params(:,27+i))/2;
  i=2;
  stats_top.Ntot_nov(:,i)= (stats_top.y_noviruses_C(:,i).*stats_top.params(:,27+i));
  i=3;
  stats_top.Ntot_nov(:,i)= (stats_top.y_noviruses_E(:,i).*stats_top.params(:,27+i));
  i=4;
  stats_top.Ntot_nov(:,i)= (stats_top.y_noviruses_C(:,i).*stats_top.params(:,27+i)+stats_top.y_noviruses_E(:,i).*stats_top.params(:,27+i))/2;
  for i=5:7,
    stats_top.Ntot_nov(:,i)=0;
  end
  for i=8:9,
    stats_top.Ntot_nov(:,i)= (stats_top.y_noviruses_C(:,i)+stats_top.y_noviruses_E(:,i))/2;
  end
  % Now compare to the without virus case, each by each
  % 
  for i=1:4,
    stats_top.Ntot_nov_C(:,i)= (stats_top.y_noviruses_C(:,i).*stats_top.params(:,27+i));
  end
  for i=5:7,
    stats_top.Ntot_nov_C(:,i)=0;
  end
  for i=8:9,
    stats_top.Ntot_nov_C(:,i)= stats_top.y_noviruses_C(:,i);
  end
  for i=1:4,
    stats_top.Ntot_nov_E(:,i)= (stats_top.y_noviruses_E(:,i).*stats_top.params(:,27+i));
  end
  for i=5:7,
    stats_top.Ntot_nov_E(:,i)=0;
  end
  for i=8:9,
    stats_top.Ntot_nov_E(:,i)= stats_top.y_noviruses_E(:,i);
  end
  % Save
  save stats_comm_structure stats_top siminfo
else
  fclose(fp);
  load stats_comm_structure
end

% Now sort
stats_top.Ntot_sum=(sum(stats_top.Ntot'))'; 
[tmpv tmpi]=sort(stats_top.Ntot_sum);

% Plot
% without viruses, E
tmppos= [0.1 0.1 0.7 0.25];
tmpa2 = axes('position',tmppos);
bar(1:238, stats_top.Ntot_nov_E(tmpi,:), 0.5, 'stack');
ylim([0 45]);
xlim([0 239]);
set(gca,'ytick',[0 5 10 15 20 30 40]);
set(gca,'xtick',[0 50 100 150 200 238]);
set(gca,'fontsize',20);
xlabel('Parameter set','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Density, $\mu$M','fontsize',20,'verticalalignment','bottom','interpreter','latex');
tmpt=text(10,39,'without viruses, $E^{\ast}>0$');
set(tmpt,'interpreter','latex','fontsize',18);

% without viruses, C
tmppos= [0.1 0.35 0.7 0.25];
tmpa2 = axes('position',tmppos);
bar(1:238, stats_top.Ntot_nov_C(tmpi,:), 0.5, 'stack');
ylim([0 20]);
xlim([0 239]);
set(gca,'ytick',[0 5 10 15 20 30 40]);
set(gca,'xtick',[0 50 100 150 200 238]);
set(gca,'fontsize',20);
% xlabel('Parameter set','fontsize',20,'verticalalignment','top','interpreter','latex');
xlabel('','fontsize',20,'verticalalignment','top','interpreter','latex');
set(gca,'xtick',[]);
set(gca,'fontsize',20);
ylabel('Density, $\mu$M','fontsize',20,'verticalalignment','bottom','interpreter','latex');
tmpt=text(10,39/45*20,'without viruses, $C^{\ast}>0$');
set(tmpt,'interpreter','latex','fontsize',18);

% with viruses
tmppos= [0.1 0.6 0.7 0.25];
tmpa1 = axes('position',tmppos);
bar(1:238, stats_top.Ntot(tmpi,:), 0.5, 'stack');
ylim([0 20]);
xlim([0 239]);
set(gca,'ytick',[0 5 10 15 20 30 40]);
set(gca,'xtick',[0 50 100 150 200 238]);
xlabel('','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Density, $\mu$M','fontsize',20,'verticalalignment','bottom','interpreter','latex');
set(gca,'xtick',[]);
set(gca,'fontsize',20);
tmpt=text(10,39/45*20,'with viruses');
set(tmpt,'interpreter','latex','fontsize',18);

% Now generate side labels
tmpsnames = {'$H$';'$C$';'$E$';'$Z$';'$V_H$';'$V_C$';'$V_E$';'$x_{on}$';'$x_{in}$'};

% Viruses 
tmppos= [0.85 0.6 0.1 0.25];
tmpa1 = axes('position',tmppos);
tmpbh=bar(1:2,repmat(mean(stats_top.Ntot),2,1),0.5,'stack');
xlim([0.5 1.5]);
tmpb=get(tmpbh(1),'BaseLine');
set(tmpb,'Visible','off');
tmp_avg = mean(stats_top.Ntot);
tmp_cumsum = cumsum(tmp_avg);
tmp_cumsum = [0 tmp_cumsum];
tmp_cummid = (tmp_cumsum(1:end-1)+tmp_cumsum(2:end))/2;
axis off
for i=[1:4 8 9]
  tmpt=text(0.4,tmp_cummid(i),tmpsnames(i));
  set(tmpt,'fontsize',16,'interpreter','latex');
  tmpt=text(1.3,tmp_cummid(i),sprintf('%4.2f',tmp_avg(i)));
  set(tmpt,'fontsize',16,'interpreter','latex');
end
i=6;
tmpt=text(0.4,tmp_cummid(i),'$V$');
set(tmpt,'fontsize',16,'interpreter','latex');
tmpt=text(1.3,tmp_cummid(i),sprintf('%4.2f',sum(tmp_avg(5:7))));
set(tmpt,'fontsize',16,'interpreter','latex');
%for i=8:9,
%  tmpt=text(0.4,tmp_cumsum(i+1),tmpsnames(i));
%  set(tmpt,'fontsize',16,'interpreter','latex');
%  tmpt=text(1.3,tmp_cumsum(i+1),sprintf('%4.2f',tmp_avg(i)));
%  set(tmpt,'fontsize',16,'interpreter','latex');
%end
ylim([0 1.25*tmp_cumsum(end)]);

% No viruses, C
tmppos= [0.85 0.35 0.1 0.25];
tmpa1 = axes('position',tmppos);
tmpbh=bar(1:2,repmat(mean(stats_top.Ntot_nov_C),2,1),0.5,'stack');
xlim([0.5 1.5]);
tmpb=get(tmpbh(1),'BaseLine');
set(tmpb,'Visible','off');
axis off
% Add labels
tmp_avg = mean(stats_top.Ntot_nov_C);
tmp_cumsum = cumsum(tmp_avg);
tmp_cumsum = [0 tmp_cumsum];
tmp_cummid = (tmp_cumsum(1:end-1)+tmp_cumsum(2:end))/2;
for i=1:4,
  tmpt=text(0.4,tmp_cummid(i),tmpsnames(i));
  set(tmpt,'fontsize',16,'interpreter','latex');
  tmpt=text(1.3,tmp_cummid(i),sprintf('%4.2f',tmp_avg(i)));
  set(tmpt,'fontsize',16,'interpreter','latex');
end
for i=8:9,
  tmpt=text(0.4,tmp_cumsum(i)+0.5*(i==9),tmpsnames(i));
  set(tmpt,'fontsize',16,'interpreter','latex');
  tmpt=text(1.3,tmp_cumsum(i)+0.5*(i==9),sprintf('%4.2f',tmp_avg(i)));
  set(tmpt,'fontsize',16,'interpreter','latex');
end
ylim([0 1.25*tmp_cumsum(end)]);

% No viruses, E
tmppos= [0.85 0.1 0.1 0.25];
tmpa1 = axes('position',tmppos);
tmpbh=bar(1:2,repmat(mean(stats_top.Ntot_nov_E),2,1),0.5,'stack');
xlim([0.5 1.5]);
tmpb=get(tmpbh(1),'BaseLine');
set(tmpb,'Visible','off');
axis off
% Add labels
tmp_avg = mean(stats_top.Ntot_nov_E);
tmp_cumsum = cumsum(tmp_avg);
tmp_cumsum = [0 tmp_cumsum];
tmp_cummid = (tmp_cumsum(1:end-1)+tmp_cumsum(2:end))/2;
for i=1:4,
  tmpt=text(0.4,tmp_cummid(i),tmpsnames(i));
  set(tmpt,'fontsize',16,'interpreter','latex');
  tmpt=text(1.3,tmp_cummid(i),sprintf('%4.2f',tmp_avg(i)));
  set(tmpt,'fontsize',16,'interpreter','latex');
end
for i=8:9,
  tmpt=text(0.4,tmp_cumsum(i)+0.5*(i==9),tmpsnames(i));
  set(tmpt,'fontsize',16,'interpreter','latex');
  tmpt=text(1.3,tmp_cumsum(i)+0.5*(i==9),sprintf('%4.2f',tmp_avg(i)));
  set(tmpt,'fontsize',16,'interpreter','latex');
end
ylim([0 1.25*tmp_cumsum(end)]);

% Idea
% Do two bar plots, 
% Characteristic composition on top
% as reference
%
% Then all 238 below
% row - one bar plot per sim
% x - umol/L (N)
% Pair this left and right, so that one can compare
% the world with and without viruses


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
