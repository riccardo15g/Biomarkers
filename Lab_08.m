clc
close all
clear

%% Load study 1
data=readtable("DATASETS_STUDY1.xlsx");
data1.Whole_striatum_Ki= str2double(data1.Whole_striatum_Ki);

data1_drug= data1(1:20,:);
data1_placebo= data1(21:40, :);


%% Load study 2
% data2=readtable("DATASETS_STUDY2.xlsx");
% data2.Whole_striatum_Ki= str2double(data2.Whole_striatum_Ki);


%% 
Ki_baseline=data1.Whole_striatum_Ki;
Ki_baseline_drug=Ki_baseline(1:20);
Ki_baseline_placebo=Ki_baseline(21:40);

Ki_after=data1.Whole_striatum_Ki_1;
Ki_after_drug= Ki_after(1:20);
Ki_after_placebo= Ki_after(21:40);

lillietest(Ki_baseline)
lillietest(Ki_after)
[h_drug,p_drug]= ttest(Ki_baseline_drug, Ki_after_drug);
[h_placebo,p_placebo]= ttest(Ki_baseline_placebo, Ki_after_placebo);



%% 0a 

figure
boxplot([data1_drug.Age, data1_placebo.Age])

figure
subplot(121)
histogram(data1_drug.Gender)
subplot(122)
histogram(data1_placebo.Gender)

figure, corrplot(data1{:,2:7})

%% 0b
deltaKi_drug= (Ki_after_drug-Ki_baseline_drug)./Ki_baseline_drug*100;
figure, stem(deltaKi_drug)

deltaKi_placebo= (Ki_after_placebo-Ki_baseline_placebo)./Ki_baseline_placebo*100;
figure, stem(deltaKi_placebo)

deltaKi=vertcat(deltaKi_drug, deltaKi_placebo);


%% 0c
figure
subplot(121)
boxplot([Ki_baseline, Ki_after])
subplot(122)
boxplot(deltaKi)

mean(Ki_baseline)
mean(Ki_after)
mean(deltaKi)

std(Ki_baseline)
std(Ki_after)
std(deltaKi)


%%  1
[h_delta, p_delta]=ttest(deltaKi_drug, deltaKi_placebo);

%% 2
model=fitlm(Ki_baseline, deltaKi/100);

figure, plot(model)

