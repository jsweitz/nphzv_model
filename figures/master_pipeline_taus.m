% A Master Pipeline for Documenting the Effects
% of viruses in this simple mechanistic model
% 
% focusing on a set of points already identified
% and calculating turnover rates
%
clear all
% This data was provided by the analysis of the top 5%
% of optimized solutions
load stability_solution_analysis
load ss_flux_target
load ss_flux_LHS_lowHV
load siminfo_details

% First get the fluxes associated with the "target" points
% Using stats_top
for i=1:stats_top.num,
% with viruses
  tau = turnover_scale(stats_top.y(i,:),stats_top.params(i,:));
  stats_top.tdown_wv(i,:)=tau(:,1)';
  stats_top.tup_wv(i,:)=tau(:,2)';
% no viruses - C solution
  tau = turnover_scale(stats_top.y_noviruses_C(i,:),stats_top.params(i,:));
  stats_top.tdown_nov_C(i,:)=tau(:,1)';
  stats_top.tup_nov_C(i,:)=tau(:,2)';
% no viruses - E solution
  tau = turnover_scale(stats_top.y_noviruses_E(i,:),stats_top.params(i,:));
  stats_top.tdown_nov_E(i,:)=tau(:,1)';
  stats_top.tup_nov_E(i,:)=tau(:,2)';
end

% Get the tau-s
for i=1:length(allywvirmat),
  if (intersect(posnovir_C,i)==i)
    % No viruses - C
    tmpi_C=find(posnovir_C==i);
    tau = turnover_scale(allynovirmat_C(tmpi_C,:),exp(pvalid(tmpi_C,:)));
    flux.tdown_nov_C(i,:)=tau(:,1)';
    flux.tup_nov_C(i,:)=tau(:,2)';
  else
    flux.tdown_nov_C(i,:)=-1;
    flux.tup_nov_C(i,:)=-1;
  end
  if (intersect(posnovir_E,i)==i)
    % No viruses - E
    tmpi_E=find(posnovir_E==i);
    tau = turnover_scale(allynovirmat_E(tmpi_E,:),exp(pvalid(tmpi_E,:)));
    flux.tdown_nov_E(i,:)=tau(:,1)';
    flux.tup_nov_E(i,:)=tau(:,2)';
  else
    flux.tdown_nov_E(i,:)=-1;
    flux.tup_nov_E(i,:)=-1;
  end
% w/viruses
  tau = turnover_scale(allywvirmat(i,1:9),exp(pvalid(i,:)));
  flux.tdown_wv(i,:)=tau(:,1)';
  flux.tup_wv(i,:)=tau(:,2)';
end

%stats_top.params = stats.xt;
%stats_top.y = stats.yt(:,1:9);
%stats_top.num =4758;

% Saving both tau-s and flux-es
save ss_flux_tau_target


