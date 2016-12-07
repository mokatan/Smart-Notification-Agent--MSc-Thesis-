function [ total_interference] = MRT_score( message )
%% Biggest value for the current dataset is 6.6050
%   Thisunction computes the demand and conflict for the current job
%   Values from 0 to 3
%   0 = no dependence, 1 = some dependence, 2 = significant dependence, 3 = extreme dependence
%   USER VS ENVIRONMENT

%% Conflict model from Horrey & Wickens
conflict_model = ...
[0.8 0.6 0.6 0.4 0.7 0.5 0.4 0.2 ; 
 0   0.8 0.4 0.6 0.5 0.7 0.2 0.4 ; 
 0   0   0.8 0.4 0.7 0.5 0.4 0.2 ; 
 0   0   0   0.8 0.5 0.7 0.2 0.4 ; 
 0   0   0   0   0.8 0.6 0.6 0.4 ; 
 0   0   0   0   0   0.8 0.4 0.6 ; 
 0   0   0   0   0   0   0.8 0.6 ; 
 0   0   0   0   0   0   0   1  ];

%% Values from dataset for the user state 
            %Vf Va As Av Cs Cv Rs Rv
task_user = [0  0  0  0  0  0  0  0];

%% Values from dataset for the current task 
%1 auditory, 2 visual, 3 vibration, 4 aud+vis, 5 aud+vib, 6 vis+vib, 7 aud+vis+vib 

%Vf Va As Av Cs Cv Rs Rv
task_message = ...
[0 0 1 0    0 1    0 0; %alarm
 1 0 0 0    1 0    0 0; %symbol
 0 0 0 1    1 0    0 0; %vibration
 1 0 1 0    1 1    0 0; %alarm + symbol
 0 0 1 1    1 1    0 0; %alarm + vibration
 1 0 0 1    2 0    0 0; %symbol + vibration
 1 0 1 1    2 1    0 0]; % alarm + symbol + vibration

%% User state
for i = 2: 6
    if i == 2 %focus of attention // phone or environment
        if message(1,i) == 1
            task_user(1) = task_user(1) + 2; %Vf
            task_user(5) = task_user(5) + 2; %Cs
        elseif message(1,i) == 2
            task_user(2) = task_user(2) + 1; %Va
            task_user(5) = task_user(5) + 1; %Cs
        end
    elseif i == 3 %illumination // low, mid or high
        if message(1,i) == 2
            if message(1,i) == 1
                task_user(2) = task_user(2) + 2; %Va
            elseif message(1,i) == 2
                task_user(2) = task_user(2) + 1; %Va
            elseif message(1,i) == 3
                task_user(2) = task_user(2) + 0; %Va
            end
        end
    elseif i == 4 %sound // silent, mid, loud, headphones/handset
        if message(1,i) == 1
            task_user(3) = task_user(3) + 0; %As
        elseif message(1,i) == 2
            task_user(3) = task_user(3) + 1; %As
            task_user(6) = task_user(6) + 1; %Cv
        elseif message(1,i) == 3
            task_user(3) = task_user(3) + 2; %As
            task_user(6) = task_user(6) + 1; %Cv
        elseif message(1,i) == 4
            task_user(4) = task_user(4) + 2; %Av
            task_user(6) = task_user(6) + 2; %Cv
        end
    elseif i == 5 %speaking // not speaking or speaking
        if message(1,i) == 1
            task_user(8) = task_user(8) + 0; %Rv
        elseif message(1,i) == 2
            task_user(8) = task_user(8) + 2; %Rv
        end
    elseif i == 6 %physical // walking, sitting or standing 
        if message(1,i) == 1
            task_user(5) = task_user(5) + 2; %Cs
            task_user(7) = task_user(7) + 2; %Rs
        elseif message(1,i) == 2
            task_user(5) = task_user(5) + 1; %Cs
            task_user(7) = task_user(7) + 0; %Rs
        elseif message(1,i) == 3
            task_user(5) = task_user(5) + 1; %Cs
            task_user(7) = task_user(7) + 1; %Rs
        end
    end
end

%% Calculating Total Demand
user_demand = sum(task_user)/8;
for i = 1: 7
    message_demand(i) = sum(task_message(i,:))/8;
    total_demand(i) = user_demand + message_demand(i);
end

%% Calculating Total Conflict
conflict = zeros(1,7);
max_demand = zeros(1,8);
for i = 1: 7
    max_demand(i) = max_demand(i) + sum(task_message(i,:));
    for j = 1: 8
        for k = 1: 8
            if task_user(j)~=0 && task_message(i,k)~=0
                conflict(i) = conflict(i) + conflict_model(j,k);
            end
        end
    end
end
max_demand(8) = sum(task_user);
normalization_constant = 0.3; 
normalized_conflict = conflict .* normalization_constant;

%% Calculating Total Interference
total_interference = normalized_conflict + total_demand;
end