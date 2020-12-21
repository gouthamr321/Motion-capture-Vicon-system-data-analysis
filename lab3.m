%% subject 1
mass=125*0.453;
cd '/Users/goutham/Documents/Senior_year/senior_spring/work_physio/lab3/Lab3_data/Friday_jumping_data/subject1'
files = dir('*.csv');
Tbl = readtable(files(1).name); % just for visualizaton
%start jump points chronological order
knee_bend_angels=[27.17,26.06,25.79,26.34,26.34;28.06,25.02,23.6,21.63,27.24;22.83,23.32,24.26,24.13,23.51];  % knee angle was missing information for some reason so inputted some values
l_value=903.7;% this is euclidean distance between the hip to the knee. determined through the RKNE and RPSI markers; unit is in millimeters
crouch=[116,415,691,943,1181;97,414,703,1006,1300;50,367,619,866,1118];
top_jump=[190,485,767,1014,1257;173,487,783,1079,1370;122,431,689,939,1189];
end_jump=[232,528,816,1061,1299;220,531,830,1124,1405;161,472,730,983,1229];
time_rate=0.01;
insertion_point_distance_muscle_knee=0.01; %in meters
A_COM_Maximum=zeros(3,5);
A_COM_Minimum=zeros(3,5);
for i=1:length(files) % experiments
    table=readmatrix(files(i).name);
    dat_file=fillmissing(table,'linear');
    data=dat_file(:,83); % this is the RPSI marker
    V_COM=zeros(length(data)-1,1);
    A_COM=zeros(length(V_COM)-1,1);
    for a=1:length(V_COM)-1
        V_COM(a)=((data(a+1)-data(a))/time_rate); %conversion from mm to m
    end
    for b=1:length(A_COM)-1
        A_COM(b)=0.001*(V_COM(b+1)-V_COM(b))/(time_rate);  
    end
    
    for j=1:length(crouch) % each jump
        crouch_jump_height=data(crouch(i,j));
        velocity_jump_crouch=V_COM(crouch(i,j));
        velocity_jump_top=V_COM(top_jump(i,j));
        velocity_jump_end=V_COM(end_jump(i,j));
        top_jump_height=data(top_jump(i,j));
        end_jump_height=data(end_jump(i,j));
        
        A_COM_jumping=abs(A_COM(crouch(i,j):crouch(i,j)+10));
        A_COM_Maximum(i,j)=max(A_COM_jumping);
        A_COM_Minimum(i,j)=min(A_COM_jumping);
        
        
        acceleration_jumping(i,j)=(0.001*(V_COM(crouch(i,j)+10)-V_COM(crouch(i,j)))/(time_rate*10));
        PE_crouch(i,j)=mass*(9.81)*crouch_jump_height*0.001;
        PE_top_jump(i,j)=mass*(9.81)*top_jump_height*0.001;
        PE_end_jump(i,j)=mass*(9.81)*end_jump_height*0.001;   
        Kinetic_energy_crouch(i,j)=0.5*mass*(velocity_jump_crouch^2)*0.001;
        Kinetic_energy_top(i,j)=0.5*mass*((velocity_jump_top*0.001)^2)*0.001;
        Kinetic_energy_end(i,j)=0.5*mass*((velocity_jump_end*0.001)^2)*0.001;
        force_jumping(i,j)=acceleration_jumping(i,j).*mass;
        d=(l_value*0.001)*cosd(knee_bend_angels(i,j)); % distance from hip to knee
        Torque(i,j)=force_jumping(i,j)*d; % torque for COM from hip to knee
        Force_muscles(i,j)= (Torque(i,j)/insertion_point_distance_muscle_knee); 
    end
end

force_maximum=max(A_COM_Maximum,[],2).*mass;
force_minimum=min(A_COM_Minimum,[],2).*mass;

PE_Final_subject1_start=mean(PE_crouch,2);
PE_Final_subject1_top=mean(PE_top_jump,2);
PE_Final_subject1_end=mean(PE_end_jump,2);
Force_muscles_final=mean(Force_muscles,2);

KE_Final_subject1_start=mean(Kinetic_energy_crouch,2);
KE_Final_subject1_top=mean(Kinetic_energy_top,2);
KE_Final_subject1_end=mean(Kinetic_energy_end,2);
force_jumping2=mean(force_jumping,2);

%%
%%SUbject 2
clear
clc
knee_bend_angels=[19.81,20.23,19.71,19.91;17.83,18.01,18.94,18.26;20.64,19.62,19.27,19.97];  % knee angle was missing information for some reason so inputted some values
mass=125*0.453;
l_value=967.68;
insertion_point_distance_muscle_knee=0.01;
cd '/Users/goutham/Documents/Senior_year/senior_spring/work_physio/lab3/Lab3_data/Friday_jumping_data/subject2'
files = dir('*.csv');
Tbl = readtable(files(1).name);
%start jump points chronological order
crouch=[135,366,589,847;108,320,561,797;104,307,554,784];
top_jump=[201,428,652,906;175,389,631,867;162,371,618,849];
end_jump=[237,471,687,945;213,428,671,930;202,409,655,890];
time_rate=0.01;
A_COM_Maximum=zeros(3,4);
A_COM_Minimum=zeros(3,4);
for i=1:length(files) % experiments
    table=readmatrix(files(i).name);
    dat_file=fillmissing(table,'linear');
    data=dat_file(:,83);
    V_COM=zeros(length(data)-1,1);
    A_COM=zeros(length(V_COM)-1,1);
    for a=1:length(V_COM)-1
        V_COM(a)=((data(a+1)-data(a))/time_rate); %conversion from mm to m
    end
    for b=1:length(A_COM)-1
        A_COM(b)=0.001*(V_COM(b+1)-V_COM(b))/(time_rate);  
    end
    for j=1:length(crouch) % each jump
        crouch_jump_height=data(crouch(i,j));
        velocity_jump_crouch=V_COM(crouch(i,j));
        velocity_jump_top=V_COM(top_jump(i,j));
        top_jump_height=data(top_jump(i,j));
        velocity_jump_end=V_COM(end_jump(i,j));
        end_jump_height=data(end_jump(i,j));
        
        A_COM_jumping=abs(A_COM(crouch(i,j):crouch(i,j)+10));
        A_COM_Maximum(i,j)=max(nonzeros(A_COM_jumping));
        A_COM_Minimum(i,j)=min(nonzeros(A_COM_jumping));
        
        
        
        acceleration_jumping(i,j)=(0.001*(V_COM(crouch(i,j)+10)-V_COM(crouch(i,j)))/(time_rate*10));
        PE_crouch(i,j)=mass*(9.81)*crouch_jump_height*0.001;
        PE_top_jump(i,j)=mass*(9.81)*top_jump_height*0.001;
        PE_end_jump(i,j)=mass*(9.81)*end_jump_height*0.001;   
        Kinetic_energy_crouch(i,j)=0.5*mass*(velocity_jump_crouch^2)*0.001;
        Kinetic_energy_top(i,j)=0.5*mass*((velocity_jump_top*0.001)^2)*0.001;
        Kinetic_energy_end(i,j)=0.5*mass*((velocity_jump_end*0.001)^2)*0.001;
        force_jumping(i,j)=acceleration_jumping(i,j).*mass;
        d=(l_value*0.001)*cosd(knee_bend_angels(i,j)); % distance from hip to knee
        Torque(i,j)=force_jumping(i,j)*d; % torque for COM from hip to knee
        Force_muscles(i,j)= (Torque(i,j)/insertion_point_distance_muscle_knee);
    end
end

PE_Final_subject2_start=mean(PE_crouch,2);
PE_Final_subject2_top=mean(PE_top_jump,2);
PE_Final_subject2_end=mean(PE_end_jump,2);

KE_Final_subject2_start=mean(Kinetic_energy_crouch,2);
KE_Final_subject2_top=mean(Kinetic_energy_top,2);
KE_Final_subject2_end=mean(Kinetic_energy_end,2);
force_jumping=mean(force_jumping,2);
Force_muscles_final=mean(Force_muscles,2);

force_maximum=max(A_COM_Maximum,[],2).*mass;
force_minimum=min(A_COM_Minimum,[],2).*mass;
