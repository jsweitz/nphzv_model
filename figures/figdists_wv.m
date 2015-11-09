clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figdists_wv';

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
set(gcf,'Position',[499 279 827 522]);

% main data goes here
load ss_flux_LHS_lowHV
[tmpyh,tmpyhi]=hist(log10(allywvirmat(:,1:9)),100); 
tmpyh=tmpyh/length(allywvirmat);
tmph=plot(tmpyhi,tmpyh);
set(tmph,'linewidth',3);
tmplabels=['Het';'Cya';'Euk';'Zoo';'ViH';'ViC';'ViE';'OrN';'InN'];
[mval mvali]=max(tmpyh);
tmpoffset = [1.1 1.1 1.1 1.1 0.7 1 1.1 1.1 1.05];
tmpxoffset =[ 0.3  -0.6   0    0  1.75    1.0   0.1    -0.2  0 ];
for i=1:9,
  tmpth=text(tmpxoffset(i)-0.5+tmpyhi(mvali(i)),mval(i)*tmpoffset(i),tmplabels(i,:));
  tmpc=get(tmph(i),'Color');
  set(tmpth,'Color',tmpc);
  set(tmpth,'interpreter','latex');
end
set(gca,'fontsize',20);
xlim([-5 15]);
ylim([0 0.25]);
xlabel('organisms/L and \mumol/L');
xlabel('Log$_{10}$ organisms/L and $\mu$mol/L','fontsize',24,'verticalalignment','top','interpreter','latex');
ylabel('Frequency of density','fontsize',24,'verticalalignment','bottom','interpreter','latex');

  

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
set(gca,'xtick',[-5:1:15]);

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
