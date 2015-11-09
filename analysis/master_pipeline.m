% A Master Pipeline for Documenting the Effects
% of viruses in this simple mechanistic model
% Joshua Weitz

clear all
more off
% Uncomment if you have to also find the "optimal" starting point
% for simulations
%opt_params_search

% Alternatively, use the prior settings
clear all
more off
load param_search_results_flux_lowHV

%Number of Resamples when doing Latin hypercube
nruns = 10;
%Number of Samples in Latin Hypercube
nS = 10^5;

% Perform the LHS
fracfeasible = zeros(1,nruns);
count=0;
for j=1:nruns,
    j
    %Sample between upper and lower bounds (uniform prob. distribution)
    %We are sampling uniformly in log-space
    LHSample = LHSmid(nS,xl_array,xu_array);
    %Loop through sampled points
    for k=1:size(LHSample,1)
        %this is your function
        y_wviruses=voc_steady_flux(LHSample(k,:));
        [y_noviruses_C y_noviruses_E]=nov_steady(LHSample(k,:));
        if numel(y_wviruses(y_wviruses<=0))<1 & (sum(y_noviruses_C~=0)>0) & (sum(y_noviruses_E~=0)>0) % All positive
          if ((LHSample(k,11)*LHSample(k,32)<LHSample(k,28)) & (LHSample(k,12)*LHSample(k,32)<LHSample(k,29)) & (LHSample(k,13)*LHSample(k,32)<LHSample(k,30)) ) % q-values okay
            count=count+1;
            allywvirmat(count,:)=y_wviruses;
            allynovirmat_C(count,:)=y_noviruses_C;
            allynovirmat_E(count,:)=y_noviruses_E;
            yfluxes_wv{count}=flux_estimates(y_wviruses,LHSample(k,:));
            yfluxes_nov_C{count}=flux_estimates(y_noviruses_C,LHSample(k,:));
            yfluxes_nov_E{count}=flux_estimates(y_noviruses_E,LHSample(k,:));
            pvalid(count,:)=LHSample(k,:);
          end
        end
    end
end

% Find the overall statistics
cnt_C=0;
cnt_E=0;
for i=1:length(allywvirmat),
  tmpi=find(allynovirmat_C(i,:)<0);
  if isempty(tmpi)
    cnt_C=cnt_C+1;
    posnovir_C(cnt_C)=i;
  end
  tmpi=find(allynovirmat_E(i,:)<0);
  if isempty(tmpi)
    cnt_E=cnt_E+1;
    posnovir_E(cnt_E)=i;
  end
end


%% Calculate fluxes
for i=1:length(allywvirmat),
  flux.ptoz(i)=yfluxes_wv{i}.p_to_z;
  flux.ptoz_novE(i)=yfluxes_nov_E{i}.p_to_z;
  flux.ptoz_novC(i)=yfluxes_nov_C{i}.p_to_z;
  flux.intop(i)=yfluxes_wv{i}.in_to_p;
  flux.intop_novE(i)=yfluxes_nov_E{i}.in_to_p;
  flux.intop_novC(i)=yfluxes_nov_C{i}.in_to_p;
  flux.ptoon(i)=yfluxes_wv{i}.p_to_on;
  flux.ptoon_novE(i)=yfluxes_nov_E{i}.p_to_on;
  flux.ptoon_novC(i)=yfluxes_nov_C{i}.p_to_on;
  flux.export(i)=yfluxes_wv{i}.export;
  flux.export_novE(i)=yfluxes_nov_E{i}.export;
  flux.export_novC(i)=yfluxes_nov_C{i}.export;
  flux.o_return(i)=yfluxes_wv{i}.p_to_on+yfluxes_wv{i}.b_to_on;
  flux.o_return_novE(i)=yfluxes_nov_E{i}.p_to_on+yfluxes_nov_E{i}.b_to_on;
  flux.o_return_novC(i)=yfluxes_nov_C{i}.p_to_on+yfluxes_nov_C{i}.b_to_on;
end

% Saving
save ss_flux_LHS_lowHV


