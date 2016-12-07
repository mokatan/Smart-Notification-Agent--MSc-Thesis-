function [ score ] = communicative_score( decided_messages, trash_messages, queue_priority1, queue_priority2, queue_priority3 )
%COMMUNİCATİVE_SCORE Summary of this function goes here
%   Detailed explanation goes here
score = 0;

%% Decided messages
mysize = size(decided_messages,1);
if mysize > 0
    for i = 1: mysize
        if decided_messages(i,2) >= 1 && decided_messages(i,2) <= 4
            score = score - 10;
        elseif decided_messages(i,2) >= 5 && decided_messages(i,2) <= 11
            score = score - 8;
        else
            score = score - 6;
        end
    end
end

%% Trash messages
mysize = size(trash_messages,1);
if mysize > 0
    for i = 1: mysize
        if trash_messages(i,2) >= 1 && trash_messages(i,2) <= 4
            score = score + 10;
        elseif trash_messages(i,2) >= 5 && trash_messages(i,2) <= 11
            score = score + 8;
        else
            score = score + 6;
        end
    end
end

%% Queued messages
if ~isempty(queue_priority1)
     queue_size = size(queue_priority1,1);
     score = score + queue_size * 5;     
end
if ~isempty(queue_priority2)
     queue_size = size(queue_priority2,1);
     score = score + queue_size * 4;
end    
if ~isempty(queue_priority3)
     queue_size = size(queue_priority3,1);
     score = score + queue_size * 3;
end

%% Division
total_size = size(decided_messages,1) + size(trash_messages,1) + size(queue_priority1,1) + size(queue_priority2,1) + size(queue_priority3,1);
score = score / total_size;

%% Normalization 
maximum = 10;
minimum = -10;
score = (score - minimum)/(maximum - minimum);

end