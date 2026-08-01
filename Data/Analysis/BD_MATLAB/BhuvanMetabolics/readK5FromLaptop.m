function [output,bbb]=readK5FromLaptop(fname)
% function [output,bbb]=readK5FromLaptop(fname)
% read data from a K5 breath-by-breath file recorded on the laptop.  
% Note: this will not work for data recorded on the portable unit. 
% Please see readk5Portable to import those data exported via SD card from k5 itself. 
% 
% Inputs: filename of file to be read.
% outputs: two structs, 1:output 2:bbb. the first is all of the data in a
% table, while the second (bbb) can be used directly with the function
% metabolicsBreathByBreath().
opts = detectImportOptions(fname,'Sheet','Data','DataRange','J1');
opts = setvartype(opts,'t',{'datetime'});
opts.SelectedVariableNames={'t','Rf',	'VT',	'VE',	'IV',	'VO2',	'VCO2',	'RQ'};
output = readtable(fname,opts);
output = output(4:end,:);
output.t_sec = output.t.Second+output.t.Minute*60+output.t.Hour*3600;

bbb = struct;
bbb.t = output.t_sec;
bbb.o2mlPmin = output.VO2;
bbb.co2mlPmin = output.VCO2;
bbb.RQ = output.RQ;