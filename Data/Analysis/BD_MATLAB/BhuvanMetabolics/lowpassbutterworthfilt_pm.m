function [datafilt] = lowpassbutterworthfilt_pm(data,order,fc_low,fs)
% Low pass butterworth filter
%   data    data array
%   order   order of the filter
%   fc_low  cut off frequency
%   fs      sampling frequency

[b,a] = butter(order,fc_low/(fs/2));
datafilt = filtfilt(b,a,data);
end

