function Forces_result= get_force(start_point,end_point,wrist_data,zach_mass_arm)

time_rate=0.01;

punch=wrist_data(start_point:end_point,:);
Velocity_punch=zeros(length(punch)-1,3);

for i=1:length(Velocity_punch)-1
        Velocity_punch(i,1)=(punch(i+1,1)-punch(i,1))/time_rate;
        Velocity_punch(i,2)=(punch(i+1,2)-punch(i,2))/time_rate;
        Velocity_punch(i,3)=(punch(i+1,3)-punch(i,3))/time_rate;
end
Velocity_punch(end,:) = [];
Acceleration_punch=zeros(length(Velocity_punch)-1,3);

for j=1:length(Acceleration_punch)-1
    Acceleration_punch(j,1)= ((Velocity_punch(j+1,1)-Velocity_punch(j,1))/time_rate);
    Acceleration_punch(j,2)= ((Velocity_punch(j+1,2)-Velocity_punch(j,2))/time_rate);
    Acceleration_punch(j,3)= ((Velocity_punch(j+1,3)-Velocity_punch(j,3))/time_rate);  
end
Acceleration_punch(end,:)=[];

Forces_XYZ=mean(Acceleration_punch.*zach_mass_arm)*0.001; % 0.001 bc millimeters
Forces_result=sqrt((Forces_XYZ(1))^2+(Forces_XYZ(2))^2+(Forces_XYZ(3))^2);

end

