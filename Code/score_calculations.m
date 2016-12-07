function [score_array ] = score_calculations( decided_messages, trash_messages,queue_priority1, queue_priority2, queue_priority3)
%SCORE_AND_CALCULATÝONS Summary of this function goes here
%   Detailed explanation goes here
 %% Calculate communicative score
        if size(decided_messages,1) > 0 || size(trash_messages,1) > 0 || size(queue_priority1,1) > 0 || size(queue_priority2,1) > 0 || size(queue_priority3,1) > 0
            communicative_component = communicative_score( decided_messages, trash_messages, queue_priority1, queue_priority2, queue_priority3 );
        else
            communicative_component = 1;
        end
        %% Get total mean disturbance
        if size(decided_messages,1) > 0 || size(trash_messages,1) > 0 || size(queue_priority1,1) > 0 || size(queue_priority2,1) > 0 || size(queue_priority3,1) > 0
            mean_disturbance = calculate_mean_disturbance( decided_messages, trash_messages, queue_priority1, queue_priority2, queue_priority3);  
        else
            mean_disturbance = 0;
        end
        %% Return the array
        score_array = [communicative_component mean_disturbance];
end

