function [datafilt] = bandstopfilter_pm(data,order,fc_low,fc_high,fs)
%UNTITLED2 Summary of this function goes here
%   data    data array
%   order   filter order (2 or 3 order)
%   fc_low  lowpass cutoff (e.g. 20)
%   fc_high highpass cutoff (e.g. 450) 
%   fs      sampling frequency (e.g. 1000)

[b,a] = butter(order,[fc_low,fc_high]/fs/2,'stop');

datafilt = filtfilt(b,a,data);
end

