function distance= get_distance(start_point,end_point,wrist_data)


punch=wrist_data(start_point:end_point,:);

distance_vector=zeros(length(punch)-1,1);



for i=1:length(distance_vector)-1
    distance_instance=sqrt(((punch(i+1,1)-punch(i,1))^2)+((punch(i+1,2)-punch(i,2))^2)+((punch(i+1,3)-punch(i,3))^2));
    distance_vector(i)=distance_instance;
end
distance= sum(distance_vector);

end

