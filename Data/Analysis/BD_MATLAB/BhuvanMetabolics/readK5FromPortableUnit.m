function [output,bbb]=readK5FromPortableUnit(fname)
% function [output,bbb]=readK5convertedCSV(fname)
% function [output,bbb]=readK5(fname)
% read data from a K5 breath-by-breath file recorded on the unit.  
% Note: this will not work for data recorded on the laptop itself. 
% For data recorded on the laptop, please use 'readk5'
% 
% Inputs: filename of file to be read.
% outputs: two structs, 1:output 2:bbb. the first is all of the data in a
% table, while the second (bbb) can be used directly with the function
% metabolicsBreathByBreath().

output = readtable(fname);

rowDataStart = 3;
duration = table2array(output(rowDataStart:end,25));
ymdhms=datevec(duration);
t_sec = ymdhms(:,4)*60*60+ymdhms(:,5)*60+ymdhms(:,6);

bbb = struct;
bbb.t = t_sec;
bbb.o2mlPmin = table2array(output(rowDataStart:end,5));
bbb.co2mlPmin = table2array(output(rowDataStart:end,6));
bbb.RQ = table2array(output(rowDataStart:end,7));


