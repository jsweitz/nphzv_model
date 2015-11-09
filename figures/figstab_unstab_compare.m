clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figstab_unstab_compare';
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
% main data goes here

% Redoanalysis if no .mat file
fp=fopen('stability_solution_analysis.mat');
if (fp<0) % Redo

% Original data in
% /Users/jsweitz/Dropbox/projects/nimbios_core/param_search/target_ss_fluxes
% Moved locally to:
clear stats
load param_search_results_flux_lowHV.mat

% Makes sure we can access the jacobian/steady state codes
% addpath /Users/jsweitz/Dropbox/projects/nimbios_core/analysis/shared

% Do the calculation
stabVec = [];
for i=1:length(stats.dev),
  param=stats.xt(i,:);
  steadyDen = steady_states(param);  % Calculate steady state
  jac =  evaluate_jacobian(steadyDen, param);
  eigenvalue = eig(jac);
  [~,ind] = max(real(eigenvalue));
  maxEigenvalue = eigenvalue(ind(1));
  stabVec = [stabVec what_type_stability(maxEigenvalue)];
end

% Stability vector has 1-4
% 1 - stable, 2 - stableSpiral, 3 - unstable, 4 - unstableSpiral
% Probably should log10 the first 9 
% and leave the last 4 alone
stabinfo.stabVec = stabVec;
stabinfo.stable = find(stabVec==1 | stabVec==2);
stabinfo.unstable = find(stabVec==3 | stabVec==4);
stabinfo.logyt_stable_mean = mean(log10(stats.yt(stabinfo.stable,:)));
stabinfo.logyt_unstable_mean = mean(log10(stats.yt(stabinfo.unstable,:)));
stabinfo.logyt_stable_std = std(log10(stats.yt(stabinfo.stable,:)));
stabinfo.logyt_unstable_std = std(log10(stats.yt(stabinfo.unstable,:)));
stabinfo.numstable = length(stabinfo.stable);
stabinfo.numunstable = length(stabinfo.unstable);

% Calculate the original differences
stabinfo.mdiff=abs(stabinfo.logyt_stable_mean-stabinfo.logyt_unstable_mean);
stabinfo.mdiff_real=(stabinfo.logyt_stable_mean-stabinfo.logyt_unstable_mean);
% Now do the statistics
nreps = 10000;
ntrials = length(stats.dev);

% Generate the random deviates using a 
% relabeling scheme that preserves the actual numbers and labels
for i=1:nreps,
  % Create random labels
  [tmpv tmpi] = sort(rand(1,ntrials));
  tmpstable = tmpi(1:stabinfo.numstable);
  tmpunstable=tmpi(stabinfo.numstable+1:end);
  % Then estimage group means with random labels
  tmpstable_mean = mean(log10(stats.yt(tmpstable,:)));
  tmpunstable_mean = mean(log10(stats.yt(tmpunstable,:)));
  stabinfo.mdiff_rand(i,:)=(tmpstable_mean-tmpunstable_mean);
end

% Calculate p-values for significant differences (in a two-sided sense)
% of the mean
for i=1:13,
  stabinfo.meandiff_p(i)= length(find(abs(stabinfo.mdiff(i))<=abs(stabinfo.mdiff_rand(:,i))))/nreps;
end
% Note that they are different

% Identify top 5% of all trials
stats.numtop5= round(0.05*ntrials);  
[tmpdev tmpids]=sort(stats.dev);    
stats.topdev = tmpdev(1:stats.numtop5);
stats.topids = tmpids(1:stats.numtop5);
% Calculate fraction stable/usntable
stats.top_fracstable = length(intersect(stats.topids,stabinfo.stable))/stats.numtop5;
stats.top_fracunstable = length(intersect(stats.topids,stabinfo.unstable))/stats.numtop5;
% But, crucially, the "best hits" are all stable
% according to this analysis, the top 5% of all hits are all stable
%
% One issue could be that there is a bias of discovery
% to avoid that bias, check out the KS-test
[stats.hsmaller,stats.psmaller]=kstest2(stats.dev(stabinfo.stable),stats.dev(stabinfo.unstable),0.05,'smaller');

% Now save all of this
save stability_solution_analysis stats stabinfo

else % Already complete
  fclose(fp);
  load('stability_solution_analysis.mat');
end

% Finally, do some plotting
tmph=plot(sort(stats.dev(stabinfo.stable)),(1:stabinfo.numstable)/stabinfo.numstable,'k-')
set(tmph,'linewidth',2);
hold on
tmph=plot(sort(stats.dev(stabinfo.unstable)),(1:stabinfo.numunstable)/stabinfo.numunstable,'k--')
set(tmph,'linewidth',2);

% k
% loglog(,, '');
%
%
% Some helpful plot commands
% tmph=plot(x,y,'ko');
% set(tmph,'markersize',10,'markerfacecolor,'k');
% tmph=plot(x,y,'k-');
% set(tmph,'linewidth',2);

set(gca,'fontsize',20);

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
tmplh = legend('Stable sets','Unstable sets',4);
set(tmplh,'interpreter','latex','fontsize',16);
% remove box
% set(tmplh,'visible','off')
tmpp = get(tmplh,'Position');
tmpp(1)=tmpp(1)*0.95;
set(tmplh,'Position',tmpp);
legend('boxoff');

xlabel('Deviation, $d$','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('$P_{\leq}(d)$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
% title('','fontsize',24)
% 'horizontalalignment','left');
% Make labels

% Show inset
tmppos= [0.55 0.45 0.3 0.3];
tmpa1 = axes('position',tmppos);
% Finally, do some plotting
tmph=plot(sort(stats.dev(stabinfo.stable)),(1:stabinfo.numstable)/stabinfo.numstable,'k-')
set(tmph,'linewidth',2);
hold on
tmph=plot(sort(stats.dev(stabinfo.unstable)),(1:stabinfo.numunstable)/stabinfo.numunstable,'k--')
set(tmph,'linewidth',2);
% Show the smallest
tmph=plot(min(stats.dev(stabinfo.stable)),0,'ko');
set(tmph,'markerfacecolor','k','markersize',12);
hold on
tmph=plot(min(stats.dev(stabinfo.unstable)),0,'ko');
set(tmph,'markersize',12);
xlim([0 20]);
set(gca,'fontsize',18);
set(gca,'ytick',[0.05 0.25 0.5 0.75 1]);
set(gca,'xtick',[0 4 8 12 16 20]);
xlabel('Deviation, $d$','fontsize',18,'verticalalignment','top','interpreter','latex');
ylabel('$P_{\leq}(d)$','fontsize',18,'verticalalignment','bottom','interpreter','latex');


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
