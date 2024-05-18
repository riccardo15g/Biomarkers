clc
close all
clear
%%
data=readtable("Patient_Master.csv");

idx_HC= find(string(data.COHORT)=='HC');
HC= data(idx_HC,:);

caudate=HC{:,[105,106]};
putamen=HC{:,107:110};


figure
boxplot(caudate)

figure
histogram(caudate(:,1))
hold on
histogram(caudate(:,2))

[h,p]=lillietest(caudate(:,1));
[h,p]=lillietest(caudate(:,2));

[p,h]=ranksum(caudate(:,1),caudate(:,2));


