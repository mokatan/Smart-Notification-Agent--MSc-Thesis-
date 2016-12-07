function [ index ] = channel_decision( level, interference )
%CHANNEL_DECÝSÝON Summary of this function goes here
%   Detailed explanation goes here
%level [-4 4]
if level == 4
    level = level - 0.1;
end
level = level + 4;
place = floor(level*7/8) + 1;

[a,b] = sort(interference,'descend');

index = b(place);
end

