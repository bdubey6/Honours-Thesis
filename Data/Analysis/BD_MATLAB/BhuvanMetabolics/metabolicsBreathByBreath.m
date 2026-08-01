function out = metabolicsBreathByBreath(bbb,vec_ends_min,varargin)
% function out = metabolicsBreathByBreath(bbb,tEndRecsMin,varargin)
% 
% Input:
% 1. bbb: a struct containing 4 fields (usually gotten from a readK5FromLaptop() or ..FromPortableUnit
% function): 
%   bbb.t, o2mlPmin, co2mlPmin, RQ
% 2. vec_ends_min: vector of end-times for the metabolic conditions.
% 
% OPTIONAL:
% verbose: binary (0 or 1) [default 1] 1-> plot the results.
% window: the duration for the averaging. Usually we use 3 or 2, longer is better. 
% mass: will compute W/kg if provided. 
%
% Output:
% a struct containing averaged o2, co2, and estimated watts using Brockway 1987, and the
% coefficients used in the calculation. 
% Brockway has 2 calculations, via O2 alone or [O2, CO2]. we return both and plot both.
% 
% Reference:
% Brockway, J. M. (1987). Derivation of formulae used to calculate energy expenditure in man.
% Human nutrition. Clinical nutrition, 41(6), 463-471.

%%%default parameters
windowMin = 3;%s
verbose = 1;
mass = [];

% process optional args
for i = 1 : 2 : length(varargin)
  option = varargin{i};
  value = varargin{i + 1};
  switch option
    case 'verbose'
      verbose = value;
    case 'window'
      windowMin = value;
    case 'mass'
      mass = value;
  end
end%%%

o2mlPmin = bbb.o2mlPmin;
co2mlPmin = bbb.co2mlPmin;
t = bbb.t;

if verbose
    figure;
    subplot(2,2,1);
    plot(t/60,o2mlPmin,'color','k');hold on;box off
end

tEndRecsSec = vec_ends_min*60;
durAvgWindowSec = windowMin*60;

[o2PerMinTests,co2PerMinTests,indTests]=deal(cell(length(vec_ends_min)));
[o2PerMinMeans,co2PerMinMeans]=deal(zeros(length(vec_ends_min),1));

for i =1:length(vec_ends_min)  
    % FIRST find all breaths that occurred 
    % durAvgWindowSec back from each tEndRecsSec
    tsec_cur =tEndRecsSec(i);
    inds=find(t>(tsec_cur-durAvgWindowSec) & t < tsec_cur);
    if isempty(inds) || length(inds)<2
      fprintf('Warning! recording %i has no breaths in it.\n',i);
      break
    end
    
    % SECOND,
    % we take the average o2 and co2 per minute, for each breath, multiply
    % by the breath duration, and then divide again by total time, to get
    % average ventilation over all the breaths within that window.
    tBase = diff(t(inds));
    tTotal = sum(tBase);
    indsBreathsInside = inds(2:end);
    indTests{i} = indsBreathsInside;
    o2PerMinTests{i} = o2mlPmin(indsBreathsInside);
    co2PerMinTests{i} = co2mlPmin(indsBreathsInside);
    o2PerMinMeans(i) = o2mlPmin(indsBreathsInside)' * tBase / tTotal; %weighted sum (cute dot product notation), then average.
    co2PerMinMeans(i) = co2mlPmin(indsBreathsInside)' * tBase / tTotal;
    
    % catch if we found nans.
    if isnan(o2PerMinMeans(i))
      fprintf('nan problem!\n');
    end
    % plot the results.
    if verbose
      plot(t(indsBreathsInside)/60,o2PerMinTests{i}); hold on;
      plot(t(indsBreathsInside)/60,repmat(o2PerMinMeans(i),length(t(indsBreathsInside)),1),'color','k');
    end
end
% plot the oxygen and RQ over time. 
if verbose
    xlabel('Time (min)');
    ylabel('O2 consumed (mL/min)');
    ylim([0,2500]);
    subplot(2,2,2);
    plot(t/60,bbb.RQ);
    xlabel('Time (min)');
    ylabel('RQ');
    ylim([0,1]);box off
end

%Brockway 1987
brockwayO2 = 20.96;
wattsO2 = brockwayO2 * o2PerMinMeans / 60;%W
wattsO2all = o2mlPmin*brockwayO2/60;

brockwayO2CO2 = [16.58, 4.51];
wattsO2CO2 = brockwayO2CO2(1) * o2PerMinMeans / 60 + ...
    brockwayO2CO2(2) * co2PerMinMeans / 60;%W
wattsO2CO2all = brockwayO2CO2(1) * o2mlPmin / 60 + ...
    brockwayO2CO2(2) * co2mlPmin / 60;

% Plot the estimated Watts
if verbose
  subplot(2,2,3);
  plot(t/60,wattsO2all,'k'); hold on;box off
  for i =1:length(wattsO2)
    inds = indTests{i};
    plot(t(inds)/60,wattsO2all(inds)); hold on;
    plot(t(inds)/60,repmat(wattsO2(i),length(inds),1),'color','k');
  end
  xlabel('time (min)');
  ylabel('Power via O2 (watts)');
  
  subplot(2,2,4);
  figParam={'linestyle','none','linewidth',2,'markersize',10,'marker'};
  plot(wattsO2,figParam{:},'o');hold on;
  plot(wattsO2CO2,figParam{:},'s');
  plot(wattsO2-wattsO2CO2,figParam{:},'^');
  legend('O2','O2CO2','delta','Location','best');
  
  xlabel('test recording index')
  ylabel('Power (W)');
  set(gcf(),'color','w');
  box off;
end

% return structure of useful things. o2, co2, coefficients, and watts. 
out=struct;
out.o2PerMinTests=o2PerMinTests;
out.co2PerMinTests=co2PerMinTests;
out.t = t;
out.brockwayO2 = brockwayO2;
out.brockwayO2CO2 = brockwayO2CO2;
out.wattsO2 = wattsO2;
out.wattsO2all = wattsO2all;

out.wattsO2CO2 = wattsO2CO2;
out.wattsO2CO2all = wattsO2CO2all;

% div by mass
if ~isempty(mass)
    out.wattsO2PerKg = out.wattsO2./mass;
    out.wattsO2CO2PerKg = out.wattsO2CO2./mass;
else
    %fprintf('warning! no mass provided. please provide for W/kg measures.\n');
end