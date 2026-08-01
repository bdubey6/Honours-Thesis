function [stats] = paired_ttest_pm(cond1,cond2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

delta = cond1 - cond2;

[~,p,ci,stats] = ttest(delta);
stats.p = p;
stats.ci= ci;

sd1 = std(cond1,'omitnan');
sd2 = std(cond2,'omitnan');

avg = nanmean(delta);
stats.avg = avg;
sd_pool = sqrt((sd1^2 + sd2^2)/2);
stats.CohensD = avg/sd_pool;

end