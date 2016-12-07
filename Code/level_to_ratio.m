function [ alphabetaarray ] = level_to_ratio( level )
%LEVEL_TO_RATÝO Summary of this function goes here
%   Detailed explanation goes here
if level == 0
    alpha = 1;
    beta = 1;
elseif level > 0
    beta = 1;
    alpha = 1 + level;
else
    alpha = 1;
    beta = -1 + level;
end

alphabetaarray = [alpha beta];

end

