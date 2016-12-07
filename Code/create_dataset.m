disp('dataset example');
clear all
timestamp(1) = 2;
for i=2: 500
    timestamp(i,1) = timestamp(i-1) + rand(1)*10;
end

for i=1:500
    app_id(i,1) = floor(rand(1)*15+1);
    focus_of_attention(i,1) = floor(rand(1)*2+1); %phone, environment (Vf,Va)   3
    illumination(i,1) = floor(rand(1)*3+1); %low, mid, high (Va)
    environment_sound(i,1) = floor(rand(1)*4+1); %silent, mid, loud, headphones/handset on (As, Av&Cv listening)
    user_speaking(i,1) = floor(rand(1)*2+1); %not-speaking, speaking (Rv)
    user_physical(i,1) = floor(rand(1)*3+1); %walking, sitting, standing (Cs, Rs)
    
    if app_id(i,1) >=1 && app_id(i,1) <= 4
        time_spent(i,1) = 3 * (rand + 1);
    elseif app_id(i,1) > 4 && app_id(i,1) <= 11
        time_spent(i,1) = 2 * (rand + 1);
    else
        time_spent(i,1) = (rand + 1);
    end
end

dataset_message = [timestamp app_id time_spent];

for i=2: 500
    timestamp(i,1) = timestamp(i-1) + rand(1)*10;
end

dataset_user = [timestamp focus_of_attention illumination environment_sound user_speaking user_physical];
% 31 03 2016

