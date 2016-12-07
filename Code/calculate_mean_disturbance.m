function [ mean_disturbance ] = calculate_mean_disturbance( decided_messages, trash_messages, queue_priority1, queue_priority2, queue_priority3)
%CALCULATE_TOTAL_DİSTURBANCE Summary of this function goes here
%   Detailed explanation goes here
mean_disturbance = 0;

%% Decided messages
mysize = size(decided_messages,1);
if mysize > 0
    for i = 1: mysize
        if decided_messages(i,2) >= 1 && decided_messages(i,2) <= 4
            mean_disturbance = mean_disturbance + 6;
        elseif decided_messages(i,2) >= 5 && decided_messages(i,2) <= 11
            mean_disturbance = mean_disturbance + 8;
        else
            mean_disturbance = mean_disturbance + 10;
        end
    end
end

%% Trash messages
mysize = size(trash_messages,1);
if mysize > 0
    for i = 1: mysize
        if trash_messages(i,2) >= 1 && trash_messages(i,2) <= 4
            mean_disturbance = mean_disturbance - 6;
        elseif trash_messages(i,2) >= 5 && trash_messages(i,2) <= 11
            mean_disturbance = mean_disturbance - 8;
        else
            mean_disturbance = mean_disturbance - 10;
        end
    end
end

%% Queued messages
if ~isempty(queue_priority1)
     queue_size = size(queue_priority1,1);
     mean_disturbance = mean_disturbance + queue_size * 3;     
end
if ~isempty(queue_priority2)
     queue_size = size(queue_priority2,1);
     mean_disturbance = mean_disturbance + queue_size * 4;
end    
if ~isempty(queue_priority3)
     queue_size = size(queue_priority3,1);
     mean_disturbance = mean_disturbance + queue_size * 5;
end

%% Division
total_size = size(decided_messages,1) + size(trash_messages,1) + size(queue_priority1,1) + size(queue_priority2,1) + size(queue_priority3,1);
mean_disturbance = mean_disturbance / total_size;

%% Normalization // 5.4414    2.9436
maximum = 10;
minimum = -10;
mean_disturbance = (mean_disturbance - minimum)/(maximum - minimum);
%% isnan
if isnan(mean_disturbance)
    mean_disturbance = 0;
end
end