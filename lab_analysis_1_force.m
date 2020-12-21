%% read in data
Zach_mass=125*0.453;
Harman_mass=110*0.453;
time_rate=0.01;
%%
% to test for diffrent subjects, change files dir + dat_file dir + modify
% the mass
% subject 1 is zach and subject 2 is harman
files = dir('subject_2/*.csv');

results=zeros(6,3);
resultant_forces=zeros(6,1);
resultant_forces_maximum=zeros(6,1);
resultant_forces_minimum=zeros(6,1);
mass=Harman_mass;
for num=1:length(files)
    dat_file=readmatrix(strcat('subject_2/',files(num).name)); 
    dat_file = fillmissing(dat_file,'linear');
    SACR_data=dat_file(1:end,72:77);
    SACR_COM_X=(SACR_data(:,1)+SACR_data(:,4))/2;
    SACR_COM_Y=(SACR_data(:,2)+SACR_data(:,5))/2;
    SACR_COM_Z=(SACR_data(:,3)+SACR_data(:,6))/2;   
    V_COM=zeros(length(SACR_COM_X)-1,3);
    A_COM=zeros(length(V_COM)-1,3);
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
    
    for i=1:length(A_COM)
        resultant_acceleration(i)=sqrt((A_COM(i,1)^2)+(A_COM(i,2)^2)+(A_COM(i,3)^2));
    end
    Forces=(resultant_acceleration.*mass)*0.001;
    resultant_forces_maximum(num,1)=max(Forces);
    resultant_forces_minimum(num,1)=min(Forces);
    
    Forces_XYZ=mean(A_COM.*mass)*0.001;
    Forces_result=sqrt((Forces_XYZ(1))^2+(Forces_XYZ(2))^2+(Forces_XYZ(3))^2);
    results(num,:)=Forces_XYZ;
    resultant_forces(num,1)=Forces_result;
    
    
    
end
mean_minimum_forces=zeros(3,1);
mean_maximum_forces=zeros(3,1);

mean_resultant_forces=zeros(3,1);
std_deviation_forces=zeros(3,1);
for number=1:(length(resultant_forces)/2)
    index=number*2;
    mean_value=(resultant_forces(index-1)+resultant_forces(index))/2;
    mean_minimum_forces(number)=(resultant_forces_minimum(index-1)+resultant_forces_minimum(index))/2;
    mean_maximum_forces(number)=(resultant_forces_maximum(index-1)+resultant_forces_maximum(index))/2;
    vec=[resultant_forces(index-1),resultant_forces(index)];
    std_force=std(vec);
    mean_resultant_forces(number)=mean_value;
    std_deviation_force(number)=std_force;
end

mean_minimum_forces=(mean_minimum_forces/2);
%% bar plot

x=['Normal Gait','Fast Gait','Fast Gait No hands'];
bar(mean_resultant_forces);
hold on
%error_high=[];
%er = errorbar(x,std_deviation_force); 
title('Average force on legs')


%% 
% get resultant accelerati