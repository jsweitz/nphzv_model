% A Master Pipeline for Documenting the Effects
% of viruses in this simple mechanistic model
% 
% focusing on a set of points already identified
%
clear all
% This data was provided by the analysis of the top 5%
% of optimized solutions
load stability_solution_analysis

% First get the fluxes associated with the "target" points
stats_top.params = stats.xt(stats.topids,:);
stats_top.y = stats.yt(stats.topids,1:9);
stats_top.num = stats.numtop5;
%stats_top.params = stats.xt;
%stats_top.y = stats.yt(:,1:9);
%stats_top.num =4758;

tmp_topids = stats.topids;
for i=1:stats_top.num,
  params=stats_top.params(i,:);
  y  = stats_top.y(i,:);
  [y_noviruses_C y_noviruses_E]=nov_steady(log(params));
  stats_top.y_noviruses_C(i,:) = y_noviruses_C;
  stats_top.y_noviruses_E(i,:) = y_noviruses_E;
  stats_top.flux_wv{i}=flux_estimates(y,log(params));
  stats_top.flux_nov_C{i}=flux_estimates(y_noviruses_C,log(params));
  stats_top.flux_nov_E{i}=flux_estimates(y_noviruses_E,log(params));
  stats_top.flux.ptoz(i)=stats_top.flux_wv{i}.p_to_z;
  stats_top.flux.ptoz_novE(i)=stats_top.flux_nov_E{i}.p_to_z;
  stats_top.flux.ptoz_novC(i)=stats_top.flux_nov_C{i}.p_to_z;
  stats_top.flux.intop(i)=stats_top.flux_wv{i}.in_to_p;
  stats_top.flux.intop_novE(i)=stats_top.flux_nov_E{i}.in_to_p;
  stats_top.flux.intop_novC(i)=stats_top.flux_nov_C{i}.in_to_p;
  stats_top.flux.ptoon(i)=stats_top.flux_wv{i}.p_to_on;
  stats_top.flux.ptoon_novE(i)=stats_top.flux_nov_E{i}.p_to_on;
  stats_top.flux.ptoon_novC(i)=stats_top.flux_nov_C{i}.p_to_on;
  stats_top.flux.export(i)=stats_top.flux_wv{i}.export;
  stats_top.flux.export_novE(i)=stats_top.flux_nov_E{i}.export;
  stats_top.flux.export_novC(i)=stats_top.flux_nov_C{i}.export;
  stats_top.flux.o_return(i)=stats_top.flux_wv{i}.p_to_on+stats_top.flux_wv{i}.b_to_on;
  stats_top.flux.o_return_novE(i)=stats_top.flux_nov_E{i}.p_to_on+stats_top.flux_nov_E{i}.b_to_on;
  stats_top.flux.o_return_novC(i)=stats_top.flux_nov_C{i}.p_to_on+stats_top.flux_nov_C{i}.b_to_on;
end

% Saving
save ss_flux_target


