Data_file=readmatrix('subject1_Cal_03_normal_cadence_1.csv');
%Data_file=readmatrix('subject1_Cal_03_normal_cadence_1.csv');
%SACR_data=Data_file(5:1015,72:77); % first three columns are left pelvis x,y,z, and next three are right pelvis x,y,z
Data_file = fillmissing(Data_file,'linear');



%% import data cleaned up
opts = detectImportOptions('subject1_Cal_03_normal_cadence_1.csv');
dat_file=readmatrix('subject1_Cal_03_normal_cadence_1.csv',opts);

%% Dow code

RTIB_data=dat_file(66:1015,108:110);
RANK_data=dat_file(66:1015,119:121);
RKNE_data=dat_file(66:1015,105:107);
SACR_data=Data_file(5:1015,72:77); % This has to be averaged
SACR_COM_X=(SACR_data(:,1)+SACR_data(:,4))/2;
SACR_COM_Y=(SACR_data(:,2)+SACR_data(:,5))/2;
SACR_COM_Z=(SACR_data(:,3)+SACR_data(:,6))/2;

frames=dat_file(66:1015,1);
for i=1:length(frames)
    rx1(i)=abs(RKNE_dataI(i,1)-RTIB_dataI(i,1));
    rx2(i)=abs(RKNE_dataI(i,1)-RANK_dataI(i,1));
    ry1(i)=abs(RKNE_dataI(i,2)-RTIB_dataI(i,2));
    ry2(i)=abs(RKNE_dataI(i,2)-RANK_dataI(i,2));
end

%% R1 is RTIB. R2 is RANK (we are assuming that the roation is circular)

R1=mean(sqrt(rx1.^2+ry1.^2));

R2=mean(sqrt(rx2.^2+ry2.^2));

% indices1 = find(isnan(R1) == 1);

% R1(indices1) = [];

% indices2 = find(isnan(R2) == 1);

% R2(indices2) = [];

%% calculating s from t

t=0:.01:(.01*frames);

for i=length(t)-1

    sx1=abs(RTIB_dataI(i,1)-RTIB_dataI(i+1,1));

    sx2=abs(RANK_dataI(i,1)-RANK_dataI(i+1,1));

    sy1=abs(RTIB_dataI(i,2)-RTIB_dataI(i+1,2));

    sy2=abs(RANK_dataI(i,2)-RANK_dataI(i+1,2));

end

S1=mean(sqrt(sx1.^2+sy1.^2));

S2=mean(sqrt(sx2.^2+sy2.^2));

% indices3 = find(isnan(S1) == 1);

% S1(indices3) = [];

% indices4 = find(isnan(S2) == 1);

% S2(indices4) = [];

%% calculating theta

theta1=(S1/R1);

theta2=(S2/R2);

 

%% Angular Speed
Omega1=theta1/0.01;
Omega2=theta2/0.01;
Omega=mean([Omega1,Omega2])

%% Angular Acceleration

Alpha1=Omega1/0.01;

Alpha2=Omega2/0.01;

Alpha=mean([Alpha1,Alpha2]);

 

%% save the outputs

Shank_angular_Data=[Omega Alpha];

save Shank_angular_Data

