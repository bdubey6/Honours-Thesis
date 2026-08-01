%% Basic data analysis for Biofeedback Posture Control Task

clear
close all
clc

 

%% Define participants
subs = {'Cluff_Tyler_TCL' 'Dubey_Bhuvan_BHDU' 'Lee_Christoff_CHLE' 'Dubey_Vridhi_VRDU' 'Kapadia_Shivam_SHKA' 'Banerjee_Amolika_AMBA' 'Jain_Aarav_AAJA'...   
'Lovis_Joshua_JOSLO' 'Nyazuba_Grace_GRNY' 'Petrone_Nate_NAPE' 'Seeley_Morgan_MOSE' 'Young_Madelaine_MAYO'};

%  - paste into 6, 7
%%

for i = 1:length(subs)
    %%% Change the directory here to where you store the processed data
    load(strjoin({'C:\Users\bhuva\Downloads\Honour Program\Data\Analysis\BD_MATLAB\Bhuvan_Dubey_Data\ProcessedData\' subs{i} '.mat'},{''}))
    data(i).data = outputs;
end

clearvars -except data subs

%% Define filenames for spiro ergometry

file_names = {'Cluff_Tyler_BBB' 'Dubey_Bhuvan_BBB' 'Lee_Christoff_BBB' 'Dubey_Vridhi_BBB' 'Kapadia_Shivam_BBB' 'Banerjee_Amolika_BBB' 'Jain_Aarav_BBB'...   
'Lovis_Joshua_BBB' 'Nyazuba_Grace_BBB' 'Petrone_Nate_BBB' 'Seeley_Morgan_BBB' 'Young_Madelaine_BBB'};

%  - paste into 6, 7
for i = 1:length(file_names)
    %%% Change the directory here to where you store the metabolic data
    fname = strcat('C:\Users\bhuva\Downloads\Honour Program\Data\Analysis\BD_MATLAB\Bhuvan_Dubey_Data\MetabolicsData\',file_names{i});
    [outputs,bbb] = readK5FromLaptop(fname);
%     [outputs,bbb] = readK5FromPortableUnit(fname);
    data(i).bbb = bbb;
    clearvars outputs bbb
end

%% Define vec_ends_min
% Note: Round the values a bit.
% Example 1: 5:30 min will be 5.50 below.
% Example 2: 7:20 min will be 7.33 below.
data(1).vec_ends_min = [8.00; 17.33; 30.00; 50.33; 61.66; 71.00; 81.66];
data(2).vec_ends_min = [5.00; 14.00; 25.33; 34.33; 43.00; 52.00; 60.50];
data(3).vec_ends_min = [7.33; 16.33; 29.00; 37.00; 46.33; 52.00];
data(4).vec_ends_min = [7.50; 17.33; 33.00; 41.20; 51.50];
data(5).vec_ends_min = [5.50; 17.33; 32.50; 41.66; 50.00; 59.33];
data(6).vec_ends_min = [9.25; 17.50; 32.25; 44.08];
data(7).vec_ends_min = [5.75; 18.75; 26.58; 34.58; 42.92; 53.17];
data(8).vec_ends_min = [6.25; 20.17; 27.92; 37.08; 44.92; 53.42];
data(9).vec_ends_min = [42.50; 57.08; 65.42; 75.17];
data(10).vec_ends_min = [5.83; 22.25; 30; 37.92; 45.82; 54];
data(11).vec_ends_min = [9.25; 23.50; 32.25; 44.08];
data(12).vec_ends_min = [6.12; 21.03; 29.08; 37.50; 46.83];

%% Define mass
data(1).mass = 92;
data(2).mass = 61;
data(3).mass = 85;
data(4).mass = 60;
data(5).mass = 58;
data(6).mass = 57;
data(7).mass = 75;
data(8).mass = 116;
data(9).mass = 74;
data(10).mass = 84;
data(11).mass = 59;
data(12).mass = 70;

%% run breath by breath analysis

for i = 1:length(data)
    [data(i).bbb_out] = metabolicsBreathByBreath(data(i).bbb,data(i).vec_ends_min,'mass',data(i).mass);
end



%% Define colors
color.BL        = [  0,  0,255]./255;
color.BL_Half   = [255,  0,  0]./255;
color.BL_2fold  = [  0,255,255]./255;
color.BL_4fold  = [255,  0,255]./255;
color.BL_8fold  = [255,255,  0]./255;
color.BL_16fold = [  0,255,  0]./255;

%% Calculate some variables

% sel = 11:40; % discard the first 10 trials
% 
% for i = 1:length(subs)
% 
%     for j = 1:2:length(data(i).data)
%         temp = round(j/2)+1;
%         data(i).data(j).WattsPerKG      = data(i).bbb_out.wattsO2PerKg(temp) - data(i).bbb_out.wattsO2PerKg(1);
%         data(i).data(j).WattsO2         = data(i).bbb_out.wattsO2(temp) - data(i).bbb_out.wattsO2(1);
%         Avg(j).WattsO2(:,i)             = NaN;
%         Avg(j).WattsO2(:,i)             = data(i).data(j).WattsO2;
%     end

% 
%     for j = 1:length(data(i).data)
%         data(i).data(j).Delta_ElbAng    = data(i).data(j).ElbAng - mean(data(i).data(j).ElbAng(1:500,:));
%         data(i).data(j).Delta_ShoAng    = data(i).data(j).ShoAng - mean(data(i).data(j).ShoAng(1:500,:));
% 
%         data(i).data(j).MaxElbAng       = max(data(i).data(j).Delta_ElbAng);
%         data(i).data(j).MaxShoAng       = max(data(i).data(j).Delta_ShoAng);
%         data(i).data(j).MinElbAng       = min(data(i).data(j).Delta_ElbAng);
%         data(i).data(j).MinShoAng       = min(data(i).data(j).Delta_ShoAng);
% 
%         data(i).data(j).SuccessRate     = sum(data(i).data(j).Success(1,sel))/length(sel)*100;
%         data(i).data(j).AvgMovementTime = mean(data(i).data(j).MovementTime(1,sel)) - 1000;
%         data(i).data(j).AvgMaxElbAng    = mean(data(i).data(j).MaxElbAng(1,sel));
%         data(i).data(j).AvgMinElbAng    = mean(data(i).data(j).MinElbAng(1,sel));
%         data(i).data(j).AvgMaxShoAng    = mean(data(i).data(j).MaxShoAng(1,sel));
%         data(i).data(j).AvgMinShoAng    = mean(data(i).data(j).MinShoAng(1,sel));
% 
%         data(i).data(j).Delta_AvgElbAng = mean(data(i).data(j).Delta_ElbAng(:,sel),2);
%         data(i).data(j).Delta_AvgShoAng = mean(data(i).data(j).Delta_ShoAng(:,sel),2);
% 
%         %%% Calculate overall averages
%         Avg(j).Delta_AvgElbAng(:,i)     = data(i).data(j).Delta_AvgElbAng;
%         Avg(j).Delta_AvgShoAng(:,i)     = data(i).data(j).Delta_AvgShoAng;
%         Avg(j).SuccessRate(:,i)         = data(i).data(j).SuccessRate;
%         Avg(j).AvgMovementTime(:,i)     = data(i).data(j).AvgMovementTime;
%         Avg(j).AvgMaxElbAng(:,i)        = data(i).data(j).AvgMaxElbAng;
%         Avg(j).AvgMinElbAng(:,i)        = data(i).data(j).AvgMinElbAng;
%         Avg(j).AvgMaxShoAng(:,i)        = data(i).data(j).AvgMaxShoAng;
%         Avg(j).AvgMinShoAng(:,i)        = data(i).data(j).AvgMinShoAng;
% % 
% %     end
% % 
% end
% 
% 
% 
% clearvars -except data subs color Avg


%% Calculate some variables

% sel = 11:40; % discard the first 10 trials

% preallocate data
for j = 1:2:11
    Avg(j).WattsO2              = NaN(1,length(subs));
end


for j = 1:12
    Avg(j).Delta_AvgElbAng      = NaN(2001,length(subs));
    Avg(j).Delta_AvgShoAng      = NaN(2001,length(subs));

    Avg(j).Delta_AvgHandX       = NaN(2001,length(subs));
    Avg(j).Delta_AvgHandY       = NaN(2001,length(subs));

    Avg(j).SuccessRate          = NaN(1,length(subs));
    Avg(j).ErrorRate            = NaN(1,length(subs));
    Avg(j).AvgMovementTime      = NaN(1,length(subs));
    Avg(j).AvgMaxElbAng         = NaN(1,length(subs));
    Avg(j).AvgMinElbAng         = NaN(1,length(subs));
    Avg(j).AvgMaxShoAng         = NaN(1,length(subs));
    Avg(j).AvgMinShoAng         = NaN(1,length(subs));

    Avg(j).Br                   = NaN(2001,length(subs));
    Avg(j).BB                   = NaN(2001,length(subs));
    Avg(j).TLat                 = NaN(2001,length(subs));
    Avg(j).TLong                = NaN(2001,length(subs));

    Avg(j).Delta_Br             = NaN(2001,length(subs));
    Avg(j).Delta_BB             = NaN(2001,length(subs));
    Avg(j).Delta_TLat           = NaN(2001,length(subs));
    Avg(j).Delta_TLong          = NaN(2001,length(subs));

    Avg(j).Br_pre               = NaN(1,length(subs));
    Avg(j).BB_pre               = NaN(1,length(subs));
    Avg(j).TLat_pre             = NaN(1,length(subs));
    Avg(j).TLong_pre            = NaN(1,length(subs));

    Avg(j).Delta_Br_slr         = NaN(1,length(subs));
    Avg(j).Delta_BB_slr         = NaN(1,length(subs));
    Avg(j).Delta_TLat_slr       = NaN(1,length(subs));
    Avg(j).Delta_TLong_slr      = NaN(1,length(subs));

    Avg(j).Delta_Br_llr         = NaN(1,length(subs));
    Avg(j).Delta_BB_llr         = NaN(1,length(subs));
    Avg(j).Delta_TLat_llr       = NaN(1,length(subs));
    Avg(j).Delta_TLong_llr      = NaN(1,length(subs));


    Avg(j).Br_norm                   = NaN(2001,length(subs));
    Avg(j).BB_norm                   = NaN(2001,length(subs));
    Avg(j).TLat_norm                 = NaN(2001,length(subs));
    Avg(j).TLong_norm                = NaN(2001,length(subs));

    Avg(j).Delta_Br_norm             = NaN(2001,length(subs));
    Avg(j).Delta_BB_norm             = NaN(2001,length(subs));
    Avg(j).Delta_TLat_norm           = NaN(2001,length(subs));
    Avg(j).Delta_TLong_norm          = NaN(2001,length(subs));

    Avg(j).Br_norm_pre               = NaN(1,length(subs));
    Avg(j).BB_norm_pre               = NaN(1,length(subs));
    Avg(j).TLat_norm_pre             = NaN(1,length(subs));
    Avg(j).TLong_norm_pre            = NaN(1,length(subs));

    Avg(j).Delta_Br_norm_slr         = NaN(1,length(subs));
    Avg(j).Delta_BB_norm_slr         = NaN(1,length(subs));
    Avg(j).Delta_TLat_norm_slr       = NaN(1,length(subs));
    Avg(j).Delta_TLong_norm_slr      = NaN(1,length(subs));

    Avg(j).Delta_Br_norm_llr         = NaN(1,length(subs));
    Avg(j).Delta_BB_norm_llr         = NaN(1,length(subs));
    Avg(j).Delta_TLat_norm_llr       = NaN(1,length(subs));
    Avg(j).Delta_TLong_norm_llr      = NaN(1,length(subs));
end


onset = 501;
pre = (-100:0)+onset;
slr = (25:50)+onset;
llr = (50:100)+onset;

% Normalize the EMG to the pre EMG of cond 1 and cond 2
for i = 1:length(subs)
    temp_br1 = mean(data(i).data(1).Br(pre,:),'all');
    temp_br2 = mean(data(i).data(2).Br(pre,:),'all');
    temp_br  = mean([temp_br1,temp_br2]);

    temp_bb1 = mean(data(i).data(1).BB(pre,:),'all');
    temp_bb2 = mean(data(i).data(2).BB(pre,:),'all');
    temp_bb  = mean([temp_bb1,temp_bb2]);

    temp_tlat1 = mean(data(i).data(1).TLat(pre,:),'all');
    temp_tlat2 = mean(data(i).data(2).TLat(pre,:),'all');
    temp_tlat  = mean([temp_tlat1,temp_tlat2]);

    temp_tlong1 = mean(data(i).data(1).TLong(pre,:),'all');
    temp_tlong2 = mean(data(i).data(2).TLong(pre,:),'all');
    temp_tlong  = mean([temp_tlong1,temp_tlong2]);

    for j = 1:length(data(i).data)
        data(i).data(j).Br_norm         = data(i).data(j).Br./temp_br;
        data(i).data(j).BB_norm         = data(i).data(j).BB./temp_br;
        data(i).data(j).TLat_norm       = data(i).data(j).TLat./temp_br;
        data(i).data(j).TLong_norm      = data(i).data(j).TLong./temp_br;
    end
end

for i = 1:length(subs)

    for j = 1:2:length(data(i).data)
        temp = round(j/2);
        data(i).data(j).WattsPerKG      = data(i).bbb_out.wattsO2PerKg(temp) - data(i).bbb_out.wattsO2PerKg(1);
        data(i).data(j).WattsO2         = data(i).bbb_out.wattsO2(temp) - data(i).bbb_out.wattsO2(1);
        Avg(j).WattsO2(:,i)             = NaN;
        Avg(j).WattsO2(:,i)             = data(i).data(j).WattsO2;
    end


    for j = 1:length(data(i).data)
        data(i).data(j).Delta_ElbAng    = data(i).data(j).ElbAng - mean(data(i).data(j).ElbAng(1:500,:));
        data(i).data(j).Delta_ShoAng    = data(i).data(j).ShoAng - mean(data(i).data(j).ShoAng(1:500,:));

        data(i).data(j).Delta_HandX     = 100*(data(i).data(j).HandX - mean(data(i).data(j).HandX(1:500,:)));
        data(i).data(j).Delta_HandY     = 100*(data(i).data(j).HandY - mean(data(i).data(j).HandY(1:500,:)));

        data(i).data(j).MaxElbAng       = max(data(i).data(j).Delta_ElbAng);
        data(i).data(j).MaxShoAng       = max(data(i).data(j).Delta_ShoAng);
        data(i).data(j).MinElbAng       = min(data(i).data(j).Delta_ElbAng);
        data(i).data(j).MinShoAng       = min(data(i).data(j).Delta_ShoAng);

        data(i).data(j).SuccessRate     = sum(data(i).data(j).Success)/length(data(i).data(j).Success)*100;
        data(i).data(j).ErrorRate       = 100 - data(i).data(j).SuccessRate;
        data(i).data(j).AvgMovementTime = mean(data(i).data(j).MovementTime) - 1000;
        data(i).data(j).AvgMaxElbAng    = mean(data(i).data(j).MaxElbAng);
        data(i).data(j).AvgMinElbAng    = mean(data(i).data(j).MinElbAng);
        data(i).data(j).AvgMaxShoAng    = mean(data(i).data(j).MaxShoAng);
        data(i).data(j).AvgMinShoAng    = mean(data(i).data(j).MinShoAng);

        data(i).data(j).Delta_AvgElbAng = mean(data(i).data(j).Delta_ElbAng,2);
        data(i).data(j).Delta_AvgShoAng = mean(data(i).data(j).Delta_ShoAng,2);

        data(i).data(j).Delta_AvgHandX  = mean(data(i).data(j).Delta_HandX,2);
        data(i).data(j).Delta_AvgHandY  = mean(data(i).data(j).Delta_HandY,2);

        data(i).data(j).Delta_Br        = data(i).data(j).Br - mean(data(i).data(j).Br(pre,:));
        data(i).data(j).Delta_BB        = data(i).data(j).BB - mean(data(i).data(j).BB(pre,:));
        data(i).data(j).Delta_TLat      = data(i).data(j).TLat - mean(data(i).data(j).TLat(pre,:));
        data(i).data(j).Delta_TLong     = data(i).data(j).TLong - mean(data(i).data(j).TLong(pre,:));

        data(i).data(j).Delta_Br_norm        = data(i).data(j).Br_norm - mean(data(i).data(j).Br_norm(pre,:));
        data(i).data(j).Delta_BB_norm        = data(i).data(j).BB_norm - mean(data(i).data(j).BB_norm(pre,:));
        data(i).data(j).Delta_TLat_norm      = data(i).data(j).TLat_norm - mean(data(i).data(j).TLat_norm(pre,:));
        data(i).data(j).Delta_TLong_norm     = data(i).data(j).TLong_norm - mean(data(i).data(j).TLong_norm(pre,:));

        data(i).data(j).Br_pre          = mean(data(i).data(j).Br(pre,:));
        data(i).data(j).BB_pre          = mean(data(i).data(j).BB(pre,:));
        data(i).data(j).TLat_pre        = mean(data(i).data(j).TLat(pre,:));
        data(i).data(j).TLong_pre       = mean(data(i).data(j).TLong(pre,:));

        data(i).data(j).Br_norm_pre          = mean(data(i).data(j).Br_norm(pre,:));
        data(i).data(j).BB_norm_pre          = mean(data(i).data(j).BB_norm(pre,:));
        data(i).data(j).TLat_norm_pre        = mean(data(i).data(j).TLat_norm(pre,:));
        data(i).data(j).TLong_norm_pre       = mean(data(i).data(j).TLong_norm(pre,:));

        data(i).data(j).Delta_Br_slr    = mean(data(i).data(j).Delta_Br(slr,:));
        data(i).data(j).Delta_BB_slr    = mean(data(i).data(j).Delta_BB(slr,:));
        data(i).data(j).Delta_TLat_slr  = mean(data(i).data(j).Delta_TLat(slr,:));
        data(i).data(j).Delta_TLong_slr = mean(data(i).data(j).Delta_TLong(slr,:));

        data(i).data(j).Delta_Br_norm_slr          = mean(data(i).data(j).Delta_Br_norm(slr,:));
        data(i).data(j).Delta_BB_norm_slr          = mean(data(i).data(j).Delta_BB_norm(slr,:));
        data(i).data(j).Delta_TLat_norm_slr        = mean(data(i).data(j).Delta_TLat_norm(slr,:));
        data(i).data(j).Delta_TLong_norm_slr       = mean(data(i).data(j).Delta_TLong_norm(slr,:));

        data(i).data(j).Delta_Br_llr    = mean(data(i).data(j).Delta_Br(llr,:));
        data(i).data(j).Delta_BB_llr    = mean(data(i).data(j).Delta_BB(llr,:));
        data(i).data(j).Delta_TLat_llr  = mean(data(i).data(j).Delta_TLat(llr,:));
        data(i).data(j).Delta_TLong_llr = mean(data(i).data(j).Delta_TLong(llr,:));

        data(i).data(j).Delta_Br_norm_llr          = mean(data(i).data(j).Delta_Br_norm(llr,:));
        data(i).data(j).Delta_BB_norm_llr          = mean(data(i).data(j).Delta_BB_norm(llr,:));
        data(i).data(j).Delta_TLat_norm_llr        = mean(data(i).data(j).Delta_TLat_norm(llr,:));
        data(i).data(j).Delta_TLong_norm_llr       = mean(data(i).data(j).Delta_TLong_norm(llr,:));

        %%% Calculate overall averages
        Avg(j).Delta_AvgElbAng(:,i)     = data(i).data(j).Delta_AvgElbAng;
        Avg(j).Delta_AvgShoAng(:,i)     = data(i).data(j).Delta_AvgShoAng;

        Avg(j).Delta_AvgHandX(:,i)      = data(i).data(j).Delta_AvgHandX;
        Avg(j).Delta_AvgHandY(:,i)      = data(i).data(j).Delta_AvgHandY;

        Avg(j).SuccessRate(:,i)         = data(i).data(j).SuccessRate;
        Avg(j).ErrorRate(:,i)           = data(i).data(j).ErrorRate;
        Avg(j).AvgMovementTime(:,i)     = data(i).data(j).AvgMovementTime;
        Avg(j).AvgMaxElbAng(:,i)        = data(i).data(j).AvgMaxElbAng;
        Avg(j).AvgMinElbAng(:,i)        = data(i).data(j).AvgMinElbAng;
        Avg(j).AvgMaxShoAng(:,i)        = data(i).data(j).AvgMaxShoAng;
        Avg(j).AvgMinShoAng(:,i)        = data(i).data(j).AvgMinShoAng;

        Avg(j).Br(:,i)                  = mean(data(i).data(j).Br,2);
        Avg(j).BB(:,i)                  = mean(data(i).data(j).BB,2);
        Avg(j).TLat(:,i)                = mean(data(i).data(j).TLat,2);
        Avg(j).TLong(:,i)               = mean(data(i).data(j).TLong,2);

        Avg(j).Br_norm(:,i)                  = mean(data(i).data(j).Br_norm,2);
        Avg(j).BB_norm(:,i)                  = mean(data(i).data(j).BB_norm,2);
        Avg(j).TLat_norm(:,i)                = mean(data(i).data(j).TLat_norm,2);
        Avg(j).TLong_norm(:,i)               = mean(data(i).data(j).TLong_norm,2);

        Avg(j).Delta_Br(:,i)            = mean(data(i).data(j).Delta_Br,2);
        Avg(j).Delta_BB(:,i)            = mean(data(i).data(j).Delta_BB,2);
        Avg(j).Delta_TLat(:,i)          = mean(data(i).data(j).Delta_TLat,2);
        Avg(j).Delta_TLong(:,i)         = mean(data(i).data(j).Delta_TLong,2);

        Avg(j).Delta_Br_norm(:,i)            = mean(data(i).data(j).Delta_Br_norm,2);
        Avg(j).Delta_BB_norm(:,i)            = mean(data(i).data(j).Delta_BB_norm,2);
        Avg(j).Delta_TLat_norm(:,i)          = mean(data(i).data(j).Delta_TLat_norm,2);
        Avg(j).Delta_TLong_norm(:,i)         = mean(data(i).data(j).Delta_TLong_norm,2);

        Avg(j).Br_pre(:,i)              = mean(data(i).data(j).Br_pre);
        Avg(j).BB_pre(:,i)              = mean(data(i).data(j).BB_pre);
        Avg(j).TLat_pre(:,i)            = mean(data(i).data(j).TLat_pre);
        Avg(j).TLong_pre(:,i)           = mean(data(i).data(j).TLong_pre);
    
        Avg(j).Br_norm_pre(:,i)              = mean(data(i).data(j).Br_norm_pre);
        Avg(j).BB_norm_pre(:,i)              = mean(data(i).data(j).BB_norm_pre);
        Avg(j).TLat_norm_pre(:,i)            = mean(data(i).data(j).TLat_norm_pre);
        Avg(j).TLong_norm_pre(:,i)           = mean(data(i).data(j).TLong_norm_pre);

        Avg(j).Delta_Br_slr(:,i)        = mean(data(i).data(j).Delta_Br_slr);
        Avg(j).Delta_BB_slr(:,i)        = mean(data(i).data(j).Delta_BB_slr);
        Avg(j).Delta_TLat_slr(:,i)      = mean(data(i).data(j).Delta_TLat_slr);
        Avg(j).Delta_TLong_slr(:,i)     = mean(data(i).data(j).Delta_TLong_slr);
    
        Avg(j).Delta_Br_norm_slr(:,i)        = mean(data(i).data(j).Delta_Br_norm_slr);
        Avg(j).Delta_BB_norm_slr(:,i)        = mean(data(i).data(j).Delta_BB_norm_slr);
        Avg(j).Delta_TLat_norm_slr(:,i)      = mean(data(i).data(j).Delta_TLat_norm_slr);
        Avg(j).Delta_TLong_norm_slr(:,i)     = mean(data(i).data(j).Delta_TLong_norm_slr);
    
        Avg(j).Delta_Br_llr(:,i)        = mean(data(i).data(j).Delta_Br_llr);
        Avg(j).Delta_BB_llr(:,i)        = mean(data(i).data(j).Delta_BB_llr);
        Avg(j).Delta_TLat_llr(:,i)      = mean(data(i).data(j).Delta_TLat_llr);
        Avg(j).Delta_TLong_llr(:,i)     = mean(data(i).data(j).Delta_TLong_llr);

        Avg(j).Delta_Br_norm_llr(:,i)        = mean(data(i).data(j).Delta_Br_norm_llr);
        Avg(j).Delta_BB_norm_llr(:,i)        = mean(data(i).data(j).Delta_BB_norm_llr);
        Avg(j).Delta_TLat_norm_llr(:,i)      = mean(data(i).data(j).Delta_TLat_norm_llr);
        Avg(j).Delta_TLong_norm_llr(:,i)     = mean(data(i).data(j).Delta_TLong_norm_llr);
    end

end


clearvars -except data subs color Avg

%% Plot the data - Extension Perturbation
close all

tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

% sel = 11:40; % pick only the last 20 trials

y_lim(1,:) = [-12 5];
y_lim(2,:) = [-16 5];
y_lim(3,:) = [-20 5];
y_lim(4,:) = [-20 5];
y_lim(5,:) = [-20 5];

for i = [1 2]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5,p6],{'BL' 'Half' '2x' '4x' '8x' '16x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end

for i = [3]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5],{'BL' 'Half' '2x' '4x' '8x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end


for i = [4]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4],{'BL' 'Half' '2x' '4x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end



for i = [5]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5],{'BL' 'Half' '2x' '4x' '8x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end


clearvars -except color data subs Avg
%% Plot the data - Flexion Perturbation
close all

tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;

% sel = 11:40; % pick only the last 20 trials

y_lim(1,:) = [-5 12];
y_lim(2,:) = [-5 20];
y_lim(3,:) = [-5 20];
y_lim(4,:) = [-5 20];
y_lim(5,:) = [-5 20];

for i = [1 2]
    figure
    sgtitle('Flexion Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5,p6],{'BL' 'Half' '2x' '4x' '8x' '16x'},'location','northeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on

%     l1 = plot([0 0],[-10 10],'color','k');
%     time = -500:1500;
%     y1 = data(i).data(tp_Nm1).STIM;
%     p1 = plot(time,mean(y1,2),'color','k');
% 
%     y2 = data(i).data(tp_Nm1).ElbTor;
%     p2 = plot(time,mean(y2,2),'color','b');
% 
%     legend([p1 p2],{'Faux Stim' 'ElbTor'},'location','southeast')
% 
%     axis square
%     xlim([-50 200])
%     ylim([-6 2])

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
    p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end


for i = [3]
    figure
    sgtitle('Flexion Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5],{'BL' 'Half' '2x' '4x' '8x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on

%     l1 = plot([0 0],[-10 10],'color','k');
%     time = -500:1500;
%     y1 = data(i).data(tp_Nm1).STIM;
%     p1 = plot(time,mean(y1,2),'color','k');
% 
%     y2 = data(i).data(tp_Nm1).ElbTor;
%     p2 = plot(time,mean(y2,2),'color','b');
% 
%     legend([p1 p2],{'Faux Stim' 'ElbTor'},'location','southeast')
% 
%     axis square
%     xlim([-50 200])
%     ylim([-6 2])

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end


for i = [4]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4],{'BL' 'Half' '2x' '4x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
%     p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end



for i = [5]
    figure
    sgtitle('Extension Perturbation')
    subplot(2,3,1)
    hold on

    l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Delta_ElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    legend([p1,p2,p3,p4,p5],{'BL' 'Half' '2x' '4x' '8x'},'location','southeast')

    axis square
    xlim([-200 800])
    ylim(y_lim(i,:))
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaElbow Angle (deg)')


    subplot(2,3,2)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'Br';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBr (nu)')


    subplot(2,3,3)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLat';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLat (nu)')


    subplot(2,3,4)
    hold on
    axis square

    subplot(2,3,5)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'BB';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaBB (nu)')


    subplot(2,3,6)
    hold on

%     l1 = plot([0 0],[-40 40],'color','k'); % vertical line
    l2 = plot([-500 1500],[0 0],'color','k'); % horizontal line

    time = -500:1500;
    var = 'TLong';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = plot(time,mean(data_1,2),'color',color.BL,'LineWidth',2);
    p2 = plot(time,mean(data_2,2),'color',color.BL_Half,'LineWidth',2);
    p3 = plot(time,mean(data_3,2),'color',color.BL_2fold,'LineWidth',2);
    p4 = plot(time,mean(data_4,2),'color',color.BL_4fold,'LineWidth',2);
    p5 = plot(time,mean(data_5,2),'color',color.BL_8fold,'LineWidth',2);
%     p6 = plot(time,mean(data_6,2),'color',color.BL_16fold,'LineWidth',2);
    
    axis square
    xlim([-50 200])
%     ylim([-10 5])
    xlabel('Time from perturbation onset (ms)')
    ylabel('\DeltaTLong (nu)')
end


clearvars -except color data subs Avg
%% Performance figures
close all

% sel = 11:40;
sz = 50; % marker size

for i = [1 2]
    figure
    %%% Extension
    tp_1 = 1;
    tp_2 = 3;
    tp_3 = 5;
    tp_4 = 7;
    tp_5 = 9;
    tp_6 = 11;

    subplot(2,3,1)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
    p6 = scatter(6,sum(data_6)/length(data_6)*100,sz,color.BL_16fold,'filled');

    legend([p1 p2 p3 p4 p5 p6],{'BL' 'BLx0.5' 'BLx2' 'BLx4' 'BLx8' 'BLx16'},'location','southeast')

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,2)
    title('Extension Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
    p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,3)
    hold on
    var = 'MinElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
    p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')

    %%% Flexion
    tp_1 = 2;
    tp_2 = 4;
    tp_3 = 6;
    tp_4 = 8;
    tp_5 = 10;
    tp_6 = 12;

    subplot(2,3,4)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
    p6 = scatter(6,sum(data_6)/length(data_6)*100,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,5)
    title('Flexion Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
    p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,6)
    hold on
    var = 'MaxElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
    data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
    p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')
end



for i = [3]
    figure
    %%% Extension
    tp_1 = 1;
    tp_2 = 3;
    tp_3 = 5;
    tp_4 = 7;
    tp_5 = 9;
    tp_6 = 11;

    subplot(2,3,1)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    legend([p1 p2 p3 p4 p5],{'BL' 'BLx0.5' 'BLx2' 'BLx4' 'BLx8'},'location','southeast')

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,2)
    title('Extension Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,3)
    hold on
    var = 'MinElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')

    %%% Flexion
    tp_1 = 2;
    tp_2 = 4;
    tp_3 = 6;
    tp_4 = 8;
    tp_5 = 10;
    tp_6 = 12;

    subplot(2,3,4)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,5)
    title('Flexion Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,6)
    hold on
    var = 'MaxElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')
end



for i = [4]
    figure
    %%% Extension
    tp_1 = 1;
    tp_2 = 3;
    tp_3 = 5;
    tp_4 = 7;
    tp_5 = 9;
    tp_6 = 11;

    subplot(2,3,1)
    hold on
    var = 'Success';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
%     p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    legend([p1 p2 p3 p4],{'BL' 'BLx0.5' 'BLx2' 'BLx4'},'location','southeast')

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,2)
    title('Extension Perturbation')
    hold on
    var = 'MovementTime';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
%     p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,3)
    hold on
    var = 'MinElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
%     p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')

    %%% Flexion
    tp_1 = 2;
    tp_2 = 4;
    tp_3 = 6;
    tp_4 = 8;
    tp_5 = 10;
    tp_6 = 12;

    subplot(2,3,4)
    hold on
    var = 'Success';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
%     p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,5)
    title('Flexion Perturbation')
    hold on
    var = 'MovementTime';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
%     p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,6)
    hold on
    var = 'MaxElbAng';

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
%     data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
%     p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')
end



for i = [5]
    figure
    %%% Extension
    tp_1 = 1;
    tp_2 = 3;
    tp_3 = 5;
    tp_4 = 7;
    tp_5 = 9;
    tp_6 = 11;

    subplot(2,3,1)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    legend([p1 p2 p3 p4 p5],{'BL' 'BLx0.5' 'BLx2' 'BLx4' 'BLx8'},'location','southeast')

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,2)
    title('Extension Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,3)
    hold on
    var = 'MinElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')

    %%% Flexion
    tp_1 = 2;
    tp_2 = 4;
    tp_3 = 6;
    tp_4 = 8;
    tp_5 = 10;
    tp_6 = 12;

    subplot(2,3,4)
    hold on
    var = 'Success';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,sum(data_1)/length(data_1)*100,sz,color.BL,'filled');
    p2 = scatter(2,sum(data_2)/length(data_2)*100,sz,color.BL_Half,'filled');
    p3 = scatter(3,sum(data_3)/length(data_3)*100,sz,color.BL_2fold,'filled');
    p4 = scatter(4,sum(data_4)/length(data_4)*100,sz,color.BL_4fold,'filled');
    p5 = scatter(5,sum(data_5)/length(data_5)*100,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,sum(data_6)/length(sel)*100,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Success Rate (%)')


    subplot(2,3,5)
    title('Flexion Perturbation')
    hold on
    var = 'MovementTime';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1)-1000,sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2)-1000,sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3)-1000,sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4)-1000,sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5)-1000,sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6)-1000,sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Movement Time (ms)')


    subplot(2,3,6)
    hold on
    var = 'MaxElbAng';
%     data_1 = data(i).data(tp_1).(var)(:,sel);
%     data_2 = data(i).data(tp_2).(var)(:,sel);
%     data_3 = data(i).data(tp_3).(var)(:,sel);
%     data_4 = data(i).data(tp_4).(var)(:,sel);
%     data_5 = data(i).data(tp_5).(var)(:,sel);
%     data_6 = data(i).data(tp_6).(var)(:,sel);

    data_1 = data(i).data(tp_1).(var);
    data_2 = data(i).data(tp_2).(var);
    data_3 = data(i).data(tp_3).(var);
    data_4 = data(i).data(tp_4).(var);
    data_5 = data(i).data(tp_5).(var);
%     data_6 = data(i).data(tp_6).(var);

    p1 = scatter(1,mean(data_1),sz,color.BL,'filled');
    p2 = scatter(2,mean(data_2),sz,color.BL_Half,'filled');
    p3 = scatter(3,mean(data_3),sz,color.BL_2fold,'filled');
    p4 = scatter(4,mean(data_4),sz,color.BL_4fold,'filled');
    p5 = scatter(5,mean(data_5),sz,color.BL_8fold,'filled');
%     p6 = scatter(6,mean(data_6),sz,color.BL_16fold,'filled');

    axis square
    xlim([0 7])
    ylabel('Peak Elbow Angle (deg)')
end

clearvars -except color data subs Avg

%% Plot 
close all

sz = 50; % marker size

figure
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;


subplot(1,4,1)
hold on
var = 'WattsO2';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

legend([s1 s2 s3 s4 s5 s6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northoutside')

xlim([0 7])
axis square
ylabel('\DeltaMetabolic Cost (Watts)')



subplot(2,4,2)
hold on
var = 'SuccessRate';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Success Rate (%)')


subplot(2,4,3)
title('Extension')
hold on
var = 'AvgMovementTime';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Movement Time (ms)')



subplot(2,4,4)
hold on
var = 'AvgMinElbAng';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Peak Elbow Angle (deg)')


%%% Flexion
tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;


subplot(2,4,6)
hold on
var = 'SuccessRate';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Success Rate (%)')


subplot(2,4,7)
title('Flexion')
hold on
var = 'AvgMovementTime';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Movement Time (ms)')



subplot(2,4,8)
hold on
var = 'AvgMaxElbAng';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
axis square
ylabel('Peak Elbow Angle (deg)')

clearvars -except color data subs Avg

%% Plot Elbow Angles
close all

falpha = 0.3;

figure
sgtitle('Group Averages')

subplot(1,2,1)
title('Extension')
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

hold on
var = 'Delta_AvgElbAng';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 20],'color',[0 0 0]);
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','southeast')

xlim([-100 600])
ylim([-15 5])
axis square
ylabel('\DeltaElbow Angle (deg)')


subplot(1,2,2)
title('Flexion')
%%% Flexion
tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;

hold on
var = 'Delta_AvgElbAng';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 20],'color',[0 0 0]);
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-100 600])
ylim([-5 15])
axis square
ylabel('\DeltaElbow Angle (deg)')


clearvars -except color data subs Avg



%% Plot EMG - Extension normalized
close all

falpha = 0.3;

figure
sgtitle('Group Averages - Extension EMG')
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

subplot(2,2,1)
title('Brachio')

hold on
var = 'Br_norm';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 50],'color',[0 0 0]);
l2 = plot([25 25],[-20 50],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 50],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 50],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northeast')

xlim([-50 200])
ylim([0 40])
axis square
ylabel('EMG relative to self-selected')



subplot(2,2,2)
title('Biceps')

hold on
var = 'BB_norm';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('EMG relative to self-selected')



subplot(2,2,3)
title('TLat')

hold on
var = 'TLat_norm';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 40])
axis square
ylabel('EMG relative to self-selected')



subplot(2,2,4)
title('TLong')

hold on
var = 'TLong_norm';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('EMG relative to self-selected')



clearvars -except color data subs Avg



%% Plot EMG - Extension
close all

falpha = 0.3;

figure
sgtitle('Group Averages - Extension EMG')
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

subplot(2,2,1)
title('Brachio')

hold on
var = 'Br';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 50],'color',[0 0 0]);
l2 = plot([25 25],[-20 50],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 50],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 50],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northeast')

xlim([-50 200])
ylim([0 40])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,2)
title('Biceps')

hold on
var = 'BB';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,3)
title('TLat')

hold on
var = 'TLat';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 40])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,4)
title('TLong')

hold on
var = 'TLong';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('\DeltaEMG (nu)')



clearvars -except color data subs Avg


%% Plot EMG - Flexion
close all

falpha = 0.3;

figure
sgtitle('Group Averages - Flexion EMG')
%%% Flexion
tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;

subplot(2,2,1)
title('Brachio')

hold on
var = 'Br';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 50],'color',[0 0 0]);
l2 = plot([25 25],[-20 50],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 50],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 50],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northeast')

xlim([-50 200])
ylim([0 40])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,2)
title('Biceps')

hold on
var = 'BB';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,3)
title('TLat')

hold on
var = 'TLat';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 40])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,4)
title('TLong')

hold on
var = 'TLong';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
% l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([0 80])
axis square
ylabel('\DeltaEMG (nu)')



clearvars -except color data subs Avg




%% Plot EMG - Delta Extension
close all

falpha = 0.3;

figure
sgtitle('Group Averages - Extension \DeltaEMG')
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

subplot(2,2,1)
title('Brachio')

hold on
var = 'Delta_Br';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 50],'color',[0 0 0]);
l2 = plot([25 25],[-20 50],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 50],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 50],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northeast')

xlim([-50 200])
ylim([-10 30])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,2)
title('Biceps')

hold on
var = 'Delta_BB';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-15 65])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,3)
title('TLat')

hold on
var = 'Delta_TLat';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-10 20])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,4)
title('TLong')

hold on
var = 'Delta_TLong';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-20 60])
axis square
ylabel('\DeltaEMG (nu)')



clearvars -except color data subs Avg




%% Plot EMG - Delta Flexion
close all

falpha = 0.3;

figure
sgtitle('Group Averages - Flexion \DeltaEMG')
%%% Flexion
tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;

subplot(2,2,1)
title('Brachio')

hold on
var = 'Delta_Br';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 50],'color',[0 0 0]);
l2 = plot([25 25],[-20 50],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 50],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 50],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

legend([p2 p1 p3 p4 p5 p6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northeast')

xlim([-50 200])
ylim([-10 30])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,2)
title('Biceps')

hold on
var = 'Delta_BB';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-20 40])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,3)
title('TLat')

hold on
var = 'Delta_TLat';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-10 30])
axis square
ylabel('\DeltaEMG (nu)')



subplot(2,2,4)
title('TLong')

hold on
var = 'Delta_TLong';
data_1 = Avg(tp_1).(var)';
data_2 = Avg(tp_2).(var)';
data_3 = Avg(tp_3).(var)';
data_4 = Avg(tp_4).(var)';
data_5 = Avg(tp_5).(var)';
data_6 = Avg(tp_6).(var)';

l0 = plot([0 0],[-20 100],'color',[0 0 0]);
l2 = plot([25 25],[-20 100],'color',[0 0 0],'linestyle','--');
l3 = plot([50 50],[-20 100],'color',[0 0 0],'linestyle','--');
l4 = plot([100 100],[-20 100],'color',[0 0 0],'linestyle','--');
l1 = plot([-500 1500],[0 0],'color',[0 0 0]);

time = -500:1500;

a1 = patch([time,fliplr(time)],...
    [(mean(data_1,1,'omitnan') - std(data_1,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_1,1,'omitnan') + std(data_1,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL,'edgecolor','none','facealpha',falpha);

a2 = patch([time,fliplr(time)],...
    [(mean(data_2,1,'omitnan') - std(data_2,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_2,1,'omitnan') + std(data_2,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_Half,'edgecolor','none','facealpha',falpha);

a3 = patch([time,fliplr(time)],...
    [(mean(data_3,1,'omitnan') - std(data_3,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_3,1,'omitnan') + std(data_3,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_2fold,'edgecolor','none','facealpha',falpha);

a4 = patch([time,fliplr(time)],...
    [(mean(data_4,1,'omitnan') - std(data_4,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_4,1,'omitnan') + std(data_4,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_4fold,'edgecolor','none','facealpha',falpha);

a5 = patch([time,fliplr(time)],...
    [(mean(data_5,1,'omitnan') - std(data_5,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_5,1,'omitnan') + std(data_5,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_8fold,'edgecolor','none','facealpha',falpha);

a6 = patch([time,fliplr(time)],...
    [(mean(data_6,1,'omitnan') - std(data_6,0,1,'omitnan')./sqrt(length(subs)))';...
    flipud((mean(data_6,1,'omitnan') + std(data_6,0,1,'omitnan')./sqrt(length(subs)))')]',...
    1,'facecolor',color.BL_16fold,'edgecolor','none','facealpha',falpha);


p1 = plot(time,mean(data_1,1,'omitnan'),'color',color.BL,'linewidth',1);
p2 = plot(time,mean(data_2,1,'omitnan'),'color',color.BL_Half,'linewidth',1);
p3 = plot(time,mean(data_3,1,'omitnan'),'color',color.BL_2fold,'linewidth',1);
p4 = plot(time,mean(data_4,1,'omitnan'),'color',color.BL_4fold,'linewidth',1);
p5 = plot(time,mean(data_5,1,'omitnan'),'color',color.BL_8fold,'linewidth',1);
p6 = plot(time,mean(data_6,1,'omitnan'),'color',color.BL_16fold,'linewidth',1);

xlim([-50 200])
ylim([-20 60])
axis square
ylabel('\DeltaEMG (nu)')



clearvars -except color data subs Avg

%% Plot Performance Summary
close all

sz = 50; % marker size

figure
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;


hold on
var = 'WattsO2';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% yyaxis right
hold on
% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+0.5;zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+4;zeros(1,length(subs))+8;zeros(1,length(subs))+16],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

% s1 = scatter(zeros(1,length(subs))+1,data_2,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
% s2 = scatter(zeros(1,length(subs))+2,data_1,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
% s3 = scatter(zeros(1,length(subs))+3,data_3,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
% s4 = scatter(zeros(1,length(subs))+4,data_4,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
% s5 = scatter(zeros(1,length(subs))+5,data_5,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
% s6 = scatter(zeros(1,length(subs))+6,data_6,sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

s1 = scatter(0.5,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(1,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(2,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(8,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(16,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

% legend([s1 s2 s3 s4 s5 s6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northoutside')

xlim([0 17])
xticks([0.5 1 2 4 8 16])
axis square
ylabel('\DeltaMetabolic Cost (Watts)')

figure

hold on
var = 'ErrorRate';
data_1 = mean([Avg(1).(var); Avg(2).(var)],'omitnan');
data_2 = mean([Avg(3).(var); Avg(4).(var)],'omitnan');
data_3 = mean([Avg(5).(var); Avg(6).(var)],'omitnan');
data_4 = mean([Avg(7).(var); Avg(8).(var)],'omitnan');
data_5 = mean([Avg(9).(var); Avg(10).(var)],'omitnan');
data_6 = mean([Avg(11).(var);Avg(12).(var)],'omitnan');

% yyaxis right
hold on
% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+0.5;zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+4;zeros(1,length(subs))+8;zeros(1,length(subs))+16],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(0.5,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(1,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(2,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(8,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(16,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

% legend([s1 s2 s3 s4 s5 s6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northoutside')

xlim([0 17])
xticks([0.5 1 2 4 8 16])
axis square
ylabel('Error Rate (%)')



clearvars -except color data subs Avg


%% Plot Performance Summary Version 2
close all

sz = 50; % marker size

figure
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;


hold on
var = 'WattsO2';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

% yyaxis right
hold on
% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

legend([s1 s2 s3 s4 s5 s6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northoutside')

xlim([0 7])
% xticks([0.5 1 2 4 8 16])
axis square
ylabel('\DeltaMetabolic Cost (Watts)')

figure

hold on
var = 'ErrorRate';
data_1 = mean([Avg(1).(var); Avg(2).(var)],'omitnan');
data_2 = mean([Avg(3).(var); Avg(4).(var)],'omitnan');
data_3 = mean([Avg(5).(var); Avg(6).(var)],'omitnan');
data_4 = mean([Avg(7).(var); Avg(8).(var)],'omitnan');
data_5 = mean([Avg(9).(var); Avg(10).(var)],'omitnan');
data_6 = mean([Avg(11).(var);Avg(12).(var)],'omitnan');

% yyaxis right
hold on
% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

legend([s1 s2 s3 s4 s5 s6],{'0.5x' '1x' '2x' '4x' '8x' '16x'},'location','northoutside')

xlim([0 7])
% xticks([0.5 1 2 4 8 16])
axis square
ylabel('Error Rate (%)')



clearvars -except color data subs Avg

%% Exemplar Hand Paths
close all

figure
hold on
id = 2;
%%% Extension
tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

% plot circle
th = 0:pi/50:2*pi;
r = 2; x = 0; y = 0;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'color','k');

varx = 'Delta_AvgHandX';
vary = 'Delta_AvgHandY';
data_1x = Avg(tp_1).(varx)(:,id);
data_2x = Avg(tp_2).(varx)(:,id);
data_3x = Avg(tp_3).(varx)(:,id);
data_4x = Avg(tp_4).(varx)(:,id);
data_5x = Avg(tp_5).(varx)(:,id);
data_6x = Avg(tp_6).(varx)(:,id);

data_1y = Avg(tp_1).(vary)(:,id);
data_2y = Avg(tp_2).(vary)(:,id);
data_3y = Avg(tp_3).(vary)(:,id);
data_4y = Avg(tp_4).(vary)(:,id);
data_5y = Avg(tp_5).(vary)(:,id);
data_6y = Avg(tp_6).(vary)(:,id);

p2 = plot(data_2x,data_2y,'color',color.BL_Half);
p1 = plot(data_1x,data_1y,'color',color.BL);
p3 = plot(data_3x,data_3y,'color',color.BL_2fold);
p4 = plot(data_4x,data_4y,'color',color.BL_4fold);
p5 = plot(data_5x,data_5y,'color',color.BL_8fold);
p6 = plot(data_6x,data_6y,'color',color.BL_16fold);

%%% Flexion
tp_1 = 2;
tp_2 = 4;
tp_3 = 6;
tp_4 = 8;
tp_5 = 10;
tp_6 = 12;


varx = 'Delta_AvgHandX';
vary = 'Delta_AvgHandY';
data_1x = Avg(tp_1).(varx)(:,id);
data_2x = Avg(tp_2).(varx)(:,id);
data_3x = Avg(tp_3).(varx)(:,id);
data_4x = Avg(tp_4).(varx)(:,id);
data_5x = Avg(tp_5).(varx)(:,id);
data_6x = Avg(tp_6).(varx)(:,id);

data_1y = Avg(tp_1).(vary)(:,id);
data_2y = Avg(tp_2).(vary)(:,id);
data_3y = Avg(tp_3).(vary)(:,id);
data_4y = Avg(tp_4).(vary)(:,id);
data_5y = Avg(tp_5).(vary)(:,id);
data_6y = Avg(tp_6).(vary)(:,id);

p2 = plot(data_2x,data_2y,'color',color.BL_Half);
p1 = plot(data_1x,data_1y,'color',color.BL);
p3 = plot(data_3x,data_3y,'color',color.BL_2fold);
p4 = plot(data_4x,data_4y,'color',color.BL_4fold);
p5 = plot(data_5x,data_5y,'color',color.BL_8fold);
p6 = plot(data_6x,data_6y,'color',color.BL_16fold);

axis square
xlim([-12 12])
ylim([-12 12])


clearvars -except color data subs Avg

%% Summary Movement Time
sz = 50;

close all

figure

subplot(2,2,1)
hold on
var = 'AvgMovementTime';
data_1 = mean([Avg(1).(var);Avg(2).(var)]);
data_2 = mean([Avg(3).(var);Avg(4).(var)]);
data_3 = mean([Avg(5).(var);Avg(6).(var)]);
data_4 = mean([Avg(7).(var);Avg(8).(var)]);
data_5 = mean([Avg(9).(var);Avg(10).(var)]);
data_6 = mean([Avg(11).(var);Avg(12).(var)]);

data_5(1,3) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
ylim([200 500])
yticks([200:100:500])
axis square
ylabel('Movement Time (ms)')


subplot(2,2,2)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(1,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(2,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(3,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(5,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(6,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 7])
ylim([200 500])
yticks([200:100:500])
axis square
ylabel('Movement Time (ms)')


subplot(2,2,3)
hold on
var = 'AvgMovementTime';
data_1 = mean([Avg(1).(var);Avg(2).(var)]);
data_2 = mean([Avg(3).(var);Avg(4).(var)]);
data_3 = mean([Avg(5).(var);Avg(6).(var)]);
data_4 = mean([Avg(7).(var);Avg(8).(var)]);
data_5 = mean([Avg(9).(var);Avg(10).(var)]);
data_6 = mean([Avg(11).(var);Avg(12).(var)]);

data_5(1,3) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+0.5;zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+4;zeros(1,length(subs))+8;zeros(1,length(subs))+16],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(0.5,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(1,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(2,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(8,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(16,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([200 500])
yticks([200:100:500])
axis square
ylabel('Movement Time (ms)')


subplot(2,2,4)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(0.5,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(1,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(2,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(8,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(16,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([200 500])
yticks([200:100:500])
axis square
ylabel('Movement Time (ms)')

clearvars -except color data subs Avg

%% Error Rate
sz = 50;

close all

figure

subplot(2,2,1)
hold on
var = 'ErrorRate';
data_1 = mean([Avg(1).(var);Avg(2).(var)]);
data_2 = mean([Avg(3).(var);Avg(4).(var)]);
data_3 = mean([Avg(5).(var);Avg(6).(var)]);
data_4 = mean([Avg(7).(var);Avg(8).(var)]);
data_5 = mean([Avg(9).(var);Avg(10).(var)]);
data_6 = mean([Avg(11).(var);Avg(12).(var)]);

data_5(1,3) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
ylim([0 70])
yticks([0:10:70])
axis square
ylabel('Error Rate (%)')


subplot(2,2,2)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(1,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(2,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(3,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(5,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(6,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 7])
ylim([0 70])
yticks([0:10:70])
axis square
ylabel('Error Rate (%)')


subplot(2,2,3)
hold on
var = 'ErrorRate';
data_1 = mean([Avg(1).(var);Avg(2).(var)]);
data_2 = mean([Avg(3).(var);Avg(4).(var)]);
data_3 = mean([Avg(5).(var);Avg(6).(var)]);
data_4 = mean([Avg(7).(var);Avg(8).(var)]);
data_5 = mean([Avg(9).(var);Avg(10).(var)]);
data_6 = mean([Avg(11).(var);Avg(12).(var)]);

data_5(1,3) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+0.5;zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+4;zeros(1,length(subs))+8;zeros(1,length(subs))+16],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(0.5,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(1,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(2,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(8,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(16,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([0 70])
yticks([0:10:70])
axis square
ylabel('Error Rate (%)')


subplot(2,2,4)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(0.5,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(1,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(2,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(8,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(16,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([0 70])
yticks([0:10:70])
axis square
ylabel('Error Rate (%)')

clearvars -except color data subs Avg

%% Metabolic Cost
sz = 50;

close all

figure

tp_1 = 1;
tp_2 = 3;
tp_3 = 5;
tp_4 = 7;
tp_5 = 9;
tp_6 = 11;

subplot(2,2,1)
hold on
var = 'WattsO2';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

data_1(1,5) = NaN;
data_2(1,5) = NaN;
data_3(1,5) = NaN;
data_4(1,5) = NaN;
data_5(1,5) = NaN;
data_6(1,5) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+3;zeros(1,length(subs))+4;zeros(1,length(subs))+5;zeros(1,length(subs))+6],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(1,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(2,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(3,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(5,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(6,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 7])
ylim([0 100])
yticks([0:20:100])
axis square
ylabel('Metabolic Cost (watts)')


subplot(2,2,2)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([1:6],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(1,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(2,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(3,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(5,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(6,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 7])
ylim([0 100])
yticks([0:20:100])
axis square
ylabel('Metabolic Cost (watts)')


subplot(2,2,3)
hold on
var = 'WattsO2';
data_1 = Avg(tp_1).(var);
data_2 = Avg(tp_2).(var);
data_3 = Avg(tp_3).(var);
data_4 = Avg(tp_4).(var);
data_5 = Avg(tp_5).(var);
data_6 = Avg(tp_6).(var);

data_1(1,5) = NaN;
data_2(1,5) = NaN;
data_3(1,5) = NaN;
data_4(1,5) = NaN;
data_5(1,5) = NaN;
data_6(1,5) = NaN;

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

p1 = plot([zeros(1,length(subs))+0.5;zeros(1,length(subs))+1;zeros(1,length(subs))+2;zeros(1,length(subs))+4;zeros(1,length(subs))+8;zeros(1,length(subs))+16],...
    [data_2;data_1;data_3;data_4;data_5;data_6],'color',[0.5 0.5 0.5]);

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

s1 = scatter(0.5,mean(data_2,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_Half);
s2 = scatter(1,mean(data_1,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL);
s3 = scatter(2,mean(data_3,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_2fold);
s4 = scatter(4,mean(data_4,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_4fold);
s5 = scatter(8,mean(data_5,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_8fold);
s6 = scatter(16,mean(data_6,2,'omitnan'),sz,'MarkerEdgeColor','none','MarkerFaceColor',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([0 100])
yticks([0:20:100])
axis square
ylabel('Metabolic Cost (watts)')


subplot(2,2,4)
hold on

% p0 = plot([0 4],[0 0],'color',[0 0 0]);

se_1 = std(data_1,'omitnan')/sqrt(sum(~isnan(data_1)));
se_2 = std(data_2,'omitnan')/sqrt(sum(~isnan(data_2)));
se_3 = std(data_3,'omitnan')/sqrt(sum(~isnan(data_3)));
se_4 = std(data_4,'omitnan')/sqrt(sum(~isnan(data_4)));
se_5 = std(data_5,'omitnan')/sqrt(sum(~isnan(data_5)));
se_6 = std(data_6,'omitnan')/sqrt(sum(~isnan(data_6)));

p2 = plot([0.5,1,2,4,8,16],mean([data_2;data_1;data_3;data_4;data_5;data_6],2,'omitnan')','color',[0 0 0]);

e1 = errorbar(0.5,mean(data_2,2,'omitnan'),se_2,'LineStyle','none','Color',color.BL_Half);
e2 = errorbar(1,mean(data_1,2,'omitnan'),se_1,'LineStyle','none','Color',color.BL);
e3 = errorbar(2,mean(data_3,2,'omitnan'),se_3,'LineStyle','none','Color',color.BL_2fold);
e4 = errorbar(4,mean(data_4,2,'omitnan'),se_4,'LineStyle','none','Color',color.BL_4fold);
e5 = errorbar(8,mean(data_5,2,'omitnan'),se_5,'LineStyle','none','Color',color.BL_8fold);
e6 = errorbar(16,mean(data_6,2,'omitnan'),se_6,'LineStyle','none','Color',color.BL_16fold);

xlim([0 17])
xticks([0.5 1 2 4 8 16])
ylim([0 60])
yticks([0:20:60])
axis square
ylabel('Metabolic Cost (watts)')

clearvars -except color data subs Avg

%% END