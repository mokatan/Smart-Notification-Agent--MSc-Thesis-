function [ any_array ] = remove_duplicates( any_array )
%REMOVE_DUPLÝCATES Summary of this function goes here
%   Detailed explanation goes here
for i = 1: size(any_array,2)
    if i < size(any_array,2)
        if any_array(i) == any_array (i + 1) 
            any_array(i) = 999;
        end
    end
end
for i = size(any_array,2) : -1 : 1
    if any_array(i) == 999
        any_array(i) = [];
    end
end
end

