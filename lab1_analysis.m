% read input data
[~,~,Data_file_headers]=xlsread('subject1_Cal_03_normal_cadence_1');
Data_file=xlsread('subject1_Cal_03_normal_cadence_1');
SACR_data=Data_file(5:1015,72:77); % first three columns are left pelvis x,y,z, and next three are right pelvis x,y,z
%Data_file = fillmissing(Data_file,'linear');
%% parameters
Zach_mass=125*0.453; %mass of a zach in kg
time_rate=.01;


%% getting center of mass by averaging right and left pelvis---SACR
SACR_COM_X=(SACR_data(:,1)+SACR_data(:,4))/2;
SACR_COM_Y=(SACR_data(:,2)+SACR_data(:,5))/2;
SACR_COM_Z=(SACR_data(:,3)+SACR_data(:,6))/2;

SACR_COM_X=(SACR_data(:,1)+SACR_data(:,4))/2;
SACR_COM_Y=(SACR_data(:,2)+SACR_data(:,5))/2;
SACR_COM_Z=(SACR_data(:,3)+SACR_data(:,6))/2;

%% velocity and acceleration of COM
V_COM=zeros(length(SACR_COM_X)-1,3);
A_com=zeros(length(V_COM)-1,3);
for i=1:length(SACR_COM_X)-1
    V_COM(i,1)=(SACR_COM_X(i+1)-SACR_COM_X(i))/time_rate;
    V_COM(i,2)=(SACR_COM_Y(i+1)-SACR_COM_Y(i))/time_rate;
    V_COM(i,3)=(SACR_COM_Z(i+1)-SACR_COM_Z(i))/time_rate;
end

for j=1:length(V_COM)-1
    A_COM(j,1)= V_COM(j+1,1)-V_COM(j,1)/time_rate;
    A_COM(j,2)= V_COM(j+1,2)-V_COM(j,2)/time_rate;
    A_COM(j,3)= V_COM(j+1,3)-V_COM(j,3)/time_rate;
end

%% force calculations 
Forces_XYZ=mean(A_COM.*Zach_mass)*0.001;
% convert to newtons bc dist was in millimeters
