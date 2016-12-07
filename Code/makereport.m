
%% percentage calculation
number_of_p1_messages = 0;
number_of_p2_messages = 0;
number_of_p3_messages = 0;

number_of_p1_notifications = 0;
number_of_p2_notifications = 0;
number_of_p3_notifications = 0;

number_of_messages_sent_to_user = size(decided_messages,1);
number_of_trash_messages = size(trash_messages,1);

number_of_arrived_messages = size(dataset_not_modified,1) - size(dataset_message,1);

for i = 1: number_of_arrived_messages
    if dataset_not_modified(i,2) >= 1 && dataset_not_modified(i,2) < 5
        number_of_p1_messages = number_of_p1_messages + 1;
    elseif dataset_not_modified(i,2) >=5 && dataset_not_modified(i,2) < 12
        number_of_p2_messages = number_of_p2_messages + 1;
    else
        number_of_p3_messages = number_of_p3_messages + 1;
    end
end

for i = 1: size(decided_messages_property,1)
    if decided_messages_property(i,4) == 1
        number_of_p1_notifications = number_of_p1_notifications + 1;
    elseif decided_messages_property(i,4) == 2
        number_of_p2_notifications = number_of_p2_notifications + 1;
    else
        number_of_p3_notifications = number_of_p3_notifications + 1;
    end
end

percentage_priority1_notifications = number_of_p1_notifications / number_of_p1_messages;
percentage_priority2_notifications = number_of_p2_notifications / number_of_p2_messages;
percentage_priority3_notifications = number_of_p3_notifications / number_of_p3_messages;

%% Score plots

communication_score_plot = remove_duplicates(score_development_matrix(1,:));
disturbanec_score_plot = remove_duplicates(score_development_matrix(2,:));
figure()
plot(disturbanec_score_plot,'DisplayName','disturbanec_score_plot','LineWidth',2');hold all;plot(communication_score_plot,'DisplayName','communication_score_plot','LineWidth',2);hold off;
title('Score Plot')
xlabel('Iteration')
ylabel('Value')
grid on
legend('Disturbance Score','Communication Score')


%% average delay for a message
average_delay = mean(decided_messages_property(1,:));

%% timeline
%including trash
%message_timeline = [decided_messages_property(:,5:6); zeros(size(trash_messages,1),1) trash_messages(:,1)];
%only the sent ones
message_timeline = decided_messages_property(:,5:6);
%sort by incoming time
message_timeline = sortrows(message_timeline,2);
a = message_timeline(:,2);
a(:,2) = 2;

b = message_timeline(:,1);
b(:,2) = 1;
createfigure(message_timeline)

% figure()
% 
% stem(message_timeline)
% title('Arrival and Sending Time for Notifications')
% xlabel('Incoming Message')
% ylabel('Time (Seconds)')
% legend('Sent','Arrived')