function [ ratio_array ] = ratio_calculations( index_trash, index_decision, communicative_component, mean_disturbance )
%RATÝO_CALCULATÝONS Summary of this function goes here
%   Detailed explanation goes here
        index_ratio = index_trash / index_decision;     
        score_ratio = communicative_component / mean_disturbance;
        
        ratio_array = [index_ratio score_ratio];


end

