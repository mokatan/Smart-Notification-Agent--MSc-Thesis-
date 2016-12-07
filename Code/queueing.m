%%
%app id 1 whatsapp,2 facebook,3 email,4 twitter are priority 1 
%app id 5 tinder,6 shazam,7 linkedin ,8 9gag ,9 instagram,10 spotify,11 dropbox are priority 2 
%app id 12 nordea,13 netflix,14 couchsurfing,15 youtube are priority 3

load dataset_user_mehmet.mat
load dataset_message_10.mat
dataset_not_modified = dataset_message;

queue_pool = [];
index_pool = 1;

queue_priority1 = [];
index_priority1 = 1;

queue_priority2 = [];
index_priority2 = 1;

queue_priority3 = [];
index_priority3 = 1;

decided_messages = [];
index_decision = 1;

trash_messages = [];
index_trash = 1;

alphabetaarray = level_to_ratio(level);
alpha = alphabetaarray(1);
beta = alphabetaarray(2);
ratio = abs(alpha / beta);

previous = 1; %1 queue 2 trash
recycled = 0;

index_communication_score = 1;
index_disturbance_score = 1;


time = uicontrol('Style','text','String','','pos',[140 375 100 20]);
communicative = uicontrol('Style','text','String','','pos',[420 260 100 30]);
disturbance = uicontrol('Style','text','String','','pos',[420 210 100 30]);

priority1 = uicontrol('Style','text','String','','pos',[420 140 100 20]); 
priority2 = uicontrol('Style','text','String','','pos',[420 110 100 20]); 
priority3 = uicontrol('Style','text','String','','pos',[420 80 100 20]); 
decided = uicontrol('Style','text','String','','pos',[420 50 100 20]); 
trash = uicontrol('Style','text','String','','pos',[420 20 100 20]);
%pool = uicontrol('Style','text','String','','pos',[420 0 100 20]);

appname = uicontrol('Style','text','String','','pos',[140 140 100 20]);
apppriority = uicontrol('Style','text','String','','pos',[140 110 100 20]);
attending = uicontrol('Style','text','String','','pos',[140 80 100 20]);

focus = uicontrol('Style','text','String','','pos',[140 345 100 20]);
illumination = uicontrol('Style','text','String','','pos',[140 315 100 20]);
sound = uicontrol('Style','text','String','','pos',[140 285 100 20]);
speaking = uicontrol('Style','text','String','','pos',[140 255 100 20]);
physical = uicontrol('Style','text','String','Walking','pos',[140 225 100 20]);

auditory = uicontrol('Style','text','String','Auditory','BackgroundColor','white','pos',[75 20 45 20]);
visual = uicontrol('Style','text','String','Visual','BackgroundColor','white','pos',[125 20 45 20]);
haptic = uicontrol('Style','text','String','Haptic','BackgroundColor','white','pos',[175 20 45 20]);

tic; %start the time


%%
while toc < max(dataset_message(:,1))  
%% UPDATE USER STATUS
    if toc > dataset_user(1,1)
        dataset_user(1,:) = [];
    end
    %Panel Update
    if dataset_user(1,2) == 1
        set(focus,'String','Phone');
    else
        set(focus,'String','Environment');
    end
    
    if dataset_user(1,3) == 1
        set(illumination,'String', 'Low');
    elseif dataset_user(1,3) == 2
        set(illumination,'String', 'Middle');
    else
        set(illumination,'String', 'High');
    end
    
    if dataset_user(1,4) == 1
        set(sound,'String','Silent');
    elseif dataset_user(1,4) == 2
        set(sound,'String','Middle');
    elseif dataset_user(1,4) == 3
        set(sound,'String','Loud');
    else
        set(sound,'String','Headset');
    end
    
    if dataset_user(1,5) == 1
        set(speaking,'String','Yes');
    else
        set(speaking,'String','No');
    end
    
    if dataset_user(1,6) == 1
        set(physical,'String','Walking');
    elseif dataset_user(1,6) == 2
        set(physical,'String','Sitting');
    else
        set(physical,'String','Standing');
    end
    drawnow
    %Panel Update
    
%% SCORE AND RATIO CALCULATIONS
    score_array = score_calculations(decided_messages, trash_messages,queue_priority1, queue_priority2, queue_priority3);
    communicative_component = score_array(1);
    mean_disturbance = score_array(2);

    ratio_array = ratio_calculations(index_trash, index_decision, communicative_component, mean_disturbance);
    index_ratio = ratio_array(1);
    score_ratio = ratio_array(2);
    
    score_development_matrix(1,index_communication_score) = communicative_component;
    index_communication_score = index_communication_score + 1;
    score_development_matrix(2,index_disturbance_score) = mean_disturbance;
    index_disturbance_score = index_disturbance_score + 1;
    
%% PANEL UPDATE
    set(time,'String',num2str(toc));
    set(communicative,'String',num2str(communicative_component));
    set(disturbance,'String',num2str(mean_disturbance));
    drawnow

    %% QUEUEING
    while toc > dataset_message(1,1) 
        %% UPDATE USER STATUS
        if toc > dataset_user(1,1)
            dataset_user(1,:) = [];
        end
        %Panel Update
        if dataset_user(1,2) == 1
            set(focus,'String','Phone');
        else
            set(focus,'String','Environment');
        end

        if dataset_user(1,3) == 1
            set(illumination,'String', 'Low');
        elseif dataset_user(1,3) == 2
            set(illumination,'String', 'Middle');
        else
            set(illumination,'String', 'High');
        end

        if dataset_user(1,4) == 1
            set(sound,'String','Silent');
        elseif dataset_user(1,4) == 2
            set(sound,'String','Middle');
        elseif dataset_user(1,4) == 3
            set(sound,'String','Loud');
        else
            set(sound,'String','Headset');
        end

        if dataset_user(1,5) == 1
            set(speaking,'String','Yes');
        else
            set(speaking,'String','No');
        end

        if dataset_user(1,6) == 1
            set(physical,'String','Walking');
        elseif dataset_user(1,6) == 2
            set(physical,'String','Sitting');
        else
            set(physical,'String','Standing');
        end
        drawnow
        %Panel Update

        %% SCORE AND RATIO CALCULATIONS
        score_array = score_calculations(decided_messages, trash_messages,queue_priority1, queue_priority2, queue_priority3);
        communicative_component = score_array(1);
        mean_disturbance = score_array(2);
        
        ratio_array = ratio_calculations(index_trash, index_decision, communicative_component, mean_disturbance);
        index_ratio = ratio_array(1);
        score_ratio = ratio_array(2);

        score_development_matrix(1,index_communication_score) = communicative_component;
        index_communication_score = index_communication_score + 1;
        score_development_matrix(2,index_disturbance_score) = mean_disturbance;
        index_disturbance_score = index_disturbance_score + 1;
        
        %% PANEL UPDATE
        set(time,'String',num2str(toc));
        set(communicative,'String',num2str(communicative_component));
        set(disturbance,'String',num2str(mean_disturbance));
        drawnow
        %% RECYCLE
        recycled = 0;
        if size(trash_messages,1) > 0
            %i = 1;
            for i=1: size(trash_messages,1)
                if trash_messages(i,2) >= 1 && trash_messages(i,2) <= 4 
                    %pr1 
                    queue_pool(index_pool,:) = trash_messages(i,:);
                    index_pool = index_pool + 1;
                    trash_messages(i,:) = [];
                    index_trash = index_trash - 1;
                    recycled = 1;
                    disp('111')
                    break;  
                end
            end
            if recycled == 0 && rand > 0.5
                for i=1: size(trash_messages,1)
                    queue_pool(index_pool,:) = trash_messages(i,:);
                    index_pool = index_pool + 1;
                    trash_messages(i,:) = [];
                    index_trash = index_trash - 1;
                    recycled = 1;
                    disp('222')
                    break;  
                end
            end
            if recycled == 0 && rand > 0.8
                for i=1: size(trash_messages,1)
                    queue_pool(index_pool,:) = trash_messages(i,:);
                    index_pool = index_pool + 1;
                    trash_messages(i,:) = [];
                    index_trash = index_trash - 1;
                    recycled = 1;
                    disp('333')
                    break;  
                end
            end
        end       
        
            %% PANEL UPDATE
        set(priority1,'String',num2str(size(queue_priority1,1)));
        set(priority2,'String',num2str(size(queue_priority2,1)));
        set(priority3,'String',num2str(size(queue_priority3,1)));
        set(decided,'String',num2str(size(decided_messages,1)));
        set(trash,'String',num2str(size(trash_messages,1)));
%        set(pool,'String',num2str(size(queue_pool,1)));
        drawnow
        %% QUEUE OR TRASH DECISION FOR INCOMING MESSAGE
        if dataset_message(1,2) >= 1 && dataset_message(1,2) <=4           
            if ratio <= 1  && score_ratio > 1 % mismatch, send to queue
                queue_priority1(index_priority1,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_priority1 = index_priority1 + 1;
                previous = 1;
                disp('mismatch')
            elseif ratio > 1  && score_ratio < 1 %mismatch, send to trash          
                trash_messages(index_trash,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_trash = index_trash + 1;
                previous = 2;
                disp('mismatch')
            else %match
                %check the ratios and do the same as previous or not
                if score_ratio  <= ratio + 0.2 * ratio  && score_ratio  >= ratio - 0.2 * ratio
                    
                    if previous == 1
                        queue_priority1(index_priority1,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_priority1 = index_priority1 + 1;
                        previous = 1;
                    else   
                        trash_messages(index_trash,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_trash = index_trash + 1;
                        previous = 2;
                    end
                    disp('same as previous')
                elseif score_ratio  < ratio - 0.2 * ratio  
                    %trash
                    trash_messages(index_trash,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_trash = index_trash + 1;
                    previous = 2; 
                    
                else                                                      
                    %queue
                    queue_priority1(index_priority1,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_priority1 = index_priority1 + 1;
                    previous = 1;                        
                end   
                
            end

        elseif dataset_message(1,2) > 4 && dataset_message(1,2) <=11    
            
            if ratio <= 1  && score_ratio > 1 % send to queue
                queue_priority2(index_priority2,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_priority2 = index_priority2 + 1;
                previous = 1;
                disp('mismatch')
            elseif ratio > 1  && score_ratio < 1 %send to trash
                trash_messages(index_trash,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_trash = index_trash + 1;
                previous = 2;
                disp('mismatch')
            else %do the same as previous
                if score_ratio  <= ratio + 0.2 * ratio && score_ratio  >= ratio - 0.2 * ratio
                    
                    if previous == 1
                        queue_priority2(index_priority2,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_priority2 = index_priority2 + 1;
                        previous = 1;                     
                    else
                        trash_messages(index_trash,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_trash = index_trash + 1;
                        previous = 2;
                    end
                    disp('same as previous')
                elseif index_ratio < ratio - 0.2 * ratio
                    %trash
                    trash_messages(index_trash,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_trash = index_trash + 1;
                    previous = 2; 
                    
                else
                    %queue
                    queue_priority2(index_priority2,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_priority2 = index_priority2 + 1;
                    previous = 1;                  
                end   
            end

        else  
            
            if ratio <= 1  && score_ratio > 1 % send to queue
                queue_priority3(index_priority3,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_priority3 = index_priority3 + 1;
                previous = 1;
                disp('mismatch')
            elseif ratio > 1  && score_ratio < 1 %send to trash
                trash_messages(index_trash,:) = dataset_message(1,:);
                dataset_message(1,:) = [];
                index_trash = index_trash + 1;
                previous = 2;
                disp('mismatch')
            else %do the same as previous
                if score_ratio <= ratio + 0.2 * ratio && score_ratio  >= ratio - 0.2 * ratio
                    
                    if previous == 1
                        queue_priority3(index_priority3,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_priority3 = index_priority3 + 1;
                        previous = 1;
                    else
                        trash_messages(index_trash,:) = dataset_message(1,:);
                        dataset_message(1,:) = [];
                        index_trash = index_trash + 1;
                        previous = 2;
                    end
                    disp('same as previous')
                elseif score_ratio  < ratio - 0.2 * ratio
                    %trash    
                    trash_messages(index_trash,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_trash = index_trash + 1;
                    previous = 2;
                    
                else
                    %queue
                    queue_priority3(index_priority3,:) = dataset_message(1,:);
                    dataset_message(1,:) = [];
                    index_priority3 = index_priority3 + 1;
                    previous = 1;                   
                end   
            end
        end
        %% PANEL UPDATE
        set(priority1,'String',num2str(size(queue_priority1,1)));
        set(priority2,'String',num2str(size(queue_priority2,1)));
        set(priority3,'String',num2str(size(queue_priority3,1)));
        set(decided,'String',num2str(size(decided_messages,1)));
        set(trash,'String',num2str(size(trash_messages,1)));
%        set(pool,'String',num2str(size(queue_pool,1)));
        drawnow
        %% QUEUE OR TRASH DECISION FOR POOL QUEUE MESSAGES
        for i = size(queue_pool,1):-1:1
            if queue_pool(1,2) >= 1 && queue_pool(1,2) <=4         
                if ratio <= 1  && score_ratio > 1 % mismatch, send to queue
                    queue_priority1(index_priority1,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_priority1 = index_priority1 + 1;
                    previous = 1;
                elseif ratio > 1  && score_ratio < 1 %mismatch, send to trash          
                    trash_messages(index_trash,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_trash = index_trash + 1;
                    previous = 2;
                else %match
                    %check the ratios and do the same as previous or not
                    if score_ratio  <= ratio + 0.2 * ratio  && score_ratio  >= ratio - 0.2 * ratio

                        if previous == 1
                            queue_priority1(index_priority1,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_priority1 = index_priority1 + 1;
                            previous = 1;
                        else   
                            trash_messages(index_trash,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_trash = index_trash + 1;
                            previous = 2;
                        end

                    elseif score_ratio  < ratio - 0.2 * ratio  
                        %trash
                        trash_messages(index_trash,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_trash = index_trash + 1;
                        previous = 2; 

                    else                                                      
                        %queue
                        queue_priority1(index_priority1,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_priority1 = index_priority1 + 1;
                        previous = 1;                        
                    end   

                end

            elseif queue_pool(1,2) > 4 && queue_pool(1,2) <=11 

                if ratio <= 1  && score_ratio > 1 % send to queue
                    queue_priority2(index_priority2,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_priority2 = index_priority2 + 1;
                    previous = 1;
                elseif ratio > 1  && score_ratio < 1 %send to trash
                    trash_messages(index_trash,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_trash = index_trash + 1;
                    previous = 2;
                else %do the same as previous
                    if score_ratio  <= ratio + 0.2 * ratio && score_ratio  >= ratio - 0.2 * ratio

                        if previous == 1
                            queue_priority2(index_priority2,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_priority2 = index_priority2 + 1;
                            previous = 1;                     
                        else
                            trash_messages(index_trash,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_trash = index_trash + 1;
                            previous = 2;
                        end

                    elseif index_ratio < ratio - 0.2 * ratio
                        %trash
                        trash_messages(index_trash,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_trash = index_trash + 1;
                        previous = 2; 

                    else
                        %queue
                        queue_priority2(index_priority2,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_priority2 = index_priority2 + 1;
                        previous = 1;                  
                    end   
                end

            elseif queue_pool(1,2) >= 12 

                if ratio <= 1  && score_ratio > 1 % send to queue
                    queue_priority3(index_priority3,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_priority3 = index_priority3 + 1;
                    previous = 1;
                elseif ratio > 1  && score_ratio < 1 %send to trash
                    trash_messages(index_trash,:) = queue_pool(1,:);
                    queue_pool(1,:) = [];
                    index_pool = index_pool - 1;
                    index_trash = index_trash + 1;
                    previous = 2;
                else %do the same as previous
                    if score_ratio <= ratio + 0.2 * ratio && score_ratio  >= ratio - 0.2 * ratio

                        if previous == 1
                            queue_priority3(index_priority3,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_priority3 = index_priority3 + 1;
                            previous = 1;
                        else
                            trash_messages(index_trash,:) = queue_pool(1,:);
                            queue_pool(1,:) = [];
                            index_pool = index_pool - 1;
                            index_trash = index_trash + 1;
                            previous = 2;
                        end

                    elseif score_ratio  < ratio - 0.2 * ratio
                        %trash    
                        trash_messages(index_trash,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_trash = index_trash + 1;
                        previous = 2;

                    else
                        %queue
                        queue_priority3(index_priority3,:) = queue_pool(1,:);
                        queue_pool(1,:) = [];
                        index_pool = index_pool - 1;
                        index_priority3 = index_priority3 + 1;
                        previous = 1;                   
                    end   
                end
            end        
        end      

        %% PANEL UPDATE
        set(priority1,'String',num2str(size(queue_priority1,1)));
        set(priority2,'String',num2str(size(queue_priority2,1)));
        set(priority3,'String',num2str(size(queue_priority3,1)));
        set(decided,'String',num2str(size(decided_messages,1)));
        set(trash,'String',num2str(size(trash_messages,1)));
%        set(pool,'String',num2str(size(queue_pool,1)));
        drawnow

    end
    %% SCORE AND RATIO CALCULATIONS
    score_array = score_calculations(decided_messages, trash_messages,queue_priority1, queue_priority2, queue_priority3);
    communicative_component = score_array(1);
    mean_disturbance = score_array(2);

    ratio_array = ratio_calculations(index_trash, index_decision, communicative_component, mean_disturbance);
    index_ratio = ratio_array(1);
    score_ratio = ratio_array(2);
    
    score_development_matrix(1,index_communication_score) = communicative_component;
    index_communication_score = index_communication_score + 1;
    score_development_matrix(2,index_disturbance_score) = mean_disturbance;
    index_disturbance_score = index_disturbance_score + 1;
    %% PANEL UPDATE
    set(time,'String',num2str(toc));
    set(communicative,'String',num2str(communicative_component));
    set(disturbance,'String',num2str(mean_disturbance));
    drawnow

    %% DISTRIBUTION OF ONE MESSAGE FOR EACH LOOP
    if ~isempty(queue_priority1)
        
        switch queue_priority1(1,2)
            case 1
                set(appname,'String','Whatsapp');
            case 2
                set(appname,'String','Facebook');
            case 3
                set(appname,'String','e-Mail');
            case 4
                set(appname,'String','Twitter');
        end
        
        set(apppriority,'String','1');
        drawnow
        % the amount of seconds that user attends 
        if dataset_user(1,2) == 1
            attendance_time = 5.8;
        else
            attendance_time = 4.2;
        end
        %% mrt  
        interference = MRT_score(dataset_user(1,:))
        index = channel_decision(level, interference);
      
        switch index
            case 1 %auditory
                set(auditory,'BackgroundColor','green');
            case 2 %visual
                set(visual,'BackgroundColor','green');
            case 3 %haptic
                set(haptic,'BackgroundColor','green');
            case 4 %auditory + visual
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
            case 5 %auditory + haptic
                set(auditory,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 6 %visual + haptic
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 7 %auditory + visual + haptic
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
        end
        drawnow
        
            if mean(interference) < 4.5
            %send to user
                decided_messages(index_decision,:) = queue_priority1(1,:);
                % 28.4.16
                decided_messages_property(index_decision,1) = toc - queue_priority1(1,1);  %delay
                decided_messages_property(index_decision,2) = index; % modality
                decided_messages_property(index_decision,3) = interference(index); %disturbance
                decided_messages_property(index_decision,4) = 1;  %priority
                decided_messages_property(index_decision,5) = toc; %delivery time time
                decided_messages_property(index_decision,6) = queue_priority1(1,1); % message arrival time
                decided_messages_property(index_decision,7) = index; %modality
                % 28.4.16
                queue_priority1(1,:) = [];
                index_priority1 = index_priority1 - 1;
                index_decision = index_decision + 1;
                       
            if dataset_user(1,2) == 1 && rand > 0.1
                set(attending,'String','YES');
                drawnow       

                time_current = toc;
                while toc <= time_current + attendance_time
                    %user is attending to the message
                    set(time,'String',num2str(toc));
                    drawnow
                end
                % the amount of seconds that user attends passes
            elseif dataset_user(1,2) == 2 && rand > 0.4
                  set(attending,'String','YES');
                  drawnow      

                  time_current = toc;
                  while toc <= time_current + attendance_time
                      %user is attending to the message
                      set(time,'String',num2str(toc));
                      drawnow
                  end
                % the amount of seconds that user attends passes            
            end
            else
                %send to trash
                trash_messages(index_trash,:) = queue_priority1(1,:);
                queue_priority1(1,:) = [];
                index_priority1 = index_priority1 - 1;
                index_trash = index_trash + 1;
            end
            
        
         set(attending,'String','');
         drawnow

            
    elseif ~isempty(queue_priority2)
        switch queue_priority2(1,2)
            case 5
                set(appname,'String','Tinder');
            case 6
                set(appname,'String','Shazam');
            case 7
                set(appname,'String','Linkedin');
            case 8
                set(appname,'String','9GAG');
            case 9
                set(appname,'String','Instagram');
            case 10
                set(appname,'String','Spotify');
            case 11
                set(appname,'String','Dropbox');
        end
        set(apppriority,'String','2');
        drawnow
        % the amount of seconds that user attends passes
        if dataset_user(1,2) == 1
            attendance_time = 5.8;
        else
            attendance_time = 4.2;
        end
        %% mrt hesaplanacak 
        interference = MRT_score(dataset_user(1,:))
        index = channel_decision(level, interference);
      
        switch index
            case 1 %auditory
                set(auditory,'BackgroundColor','green');
            case 2 %visual
                set(visual,'BackgroundColor','green');
            case 3 %haptic
                set(haptic,'BackgroundColor','green');
            case 4 %auditory + visual
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
            case 5 %auditory + haptic
                set(auditory,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 6 %visual + haptic
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 7 %auditory + visual + haptic
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
        end
        drawnow
        if mean(interference) < 3.5
            %send to user
            decided_messages(index_decision,:) = queue_priority2(1,:);
            % 28.4.16
            decided_messages_property(index_decision,1) = toc - queue_priority2(1,1);
            decided_messages_property(index_decision,2) = index;
            decided_messages_property(index_decision,3) = interference(index);
            decided_messages_property(index_decision,4) = 2;  
            decided_messages_property(index_decision,5) = toc; 
            decided_messages_property(index_decision,6) = queue_priority2(1,1); 
            decided_messages_property(index_decision,7) = index; %modality
            % 28.4.16
            queue_priority2(1,:) = [];
            index_priority2 = index_priority2 - 1;
            index_decision = index_decision + 1;

            if dataset_user(1,2) == 1 && rand > 0.3
    %             %panel 1
                  set(attending,'String','YES');
                  drawnow
    %             %panel 1
                time_current = toc;
                while toc <= time_current + attendance_time
                    %panel 1&2
                    set(time,'String',num2str(toc));
                    drawnow
                    %panel 1&2
                end
                % the amount of seconds that user attends passes
            elseif dataset_user(1,2) == 2 && rand > 0.6
    %             %panel 1
                  set(attending,'String','YES');
                  drawnow
    %             %panel 1
                time_current = toc;
                while toc <= time_current + attendance_time
                    %panel 1&2
                    set(time,'String',num2str(toc));
                    drawnow
                    %panel 1&2
                end
                % the amount of seconds that user attends passes            
            end
        else
            trash_messages(index_trash,:) = queue_priority2(1,:);
            queue_priority2(1,:) = [];
            index_priority2 = index_priority2 - 1;
            index_trash = index_trash + 1;
        end
%         %panel 1
        set(attending,'String','');
        drawnow
        %panel 1
    

    elseif ~isempty(queue_priority3)
        switch queue_priority3(1,2)
            case 12
                set(appname,'String','Nordea');
            case 13
                set(appname,'String','Netflix');
            case 14
                set(appname,'String','Couchsurfing');
            case 15
                set(appname,'String','Youtube');
        end
        
        set(apppriority,'String','3');
        drawnow
        % the amount of seconds that user attends passes
        if dataset_user(1,2) == 1
            attendance_time = 5.8;
        else
            attendance_time = 4.2;
        end
        %% mrt hesaplanacak 
        interference = MRT_score(dataset_user(1,:))       
        index = channel_decision(level, interference);
        
        switch index
            case 1 %auditory
                set(auditory,'BackgroundColor','green');
            case 2 %visual
                set(visual,'BackgroundColor','green');
            case 3 %haptic
                set(haptic,'BackgroundColor','green');
            case 4 %auditory + visual
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
            case 5 %auditory + haptic
                set(auditory,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 6 %visual + haptic
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
            case 7 %auditory + visual + haptic
                set(auditory,'BackgroundColor','green');
                set(visual,'BackgroundColor','green');
                set(haptic,'BackgroundColor','green');
        end
        drawnow
        if mean(interference) < 2.5
            %send to user
            decided_messages(index_decision,:) = queue_priority3(1,:);
            % 28.4.16
            decided_messages_property(index_decision,1) = toc - queue_priority3(1,1);
            decided_messages_property(index_decision,2) = index;
            decided_messages_property(index_decision,3) = interference(index);
            decided_messages_property(index_decision,4) = 3;  
            decided_messages_property(index_decision,5) = toc; 
            decided_messages_property(index_decision,6) = queue_priority3(1,1); 
            decided_messages_property(index_decision,7) = index; %modality
            % 28.4.16
            queue_priority3(1,:) = [];
            index_priority3 = index_priority3 - 1;
            index_decision = index_decision + 1;

            if dataset_user(1,2) == 1 && rand > 0.5
    %             %panel 1
                set(attending,'String','YES');
                drawnow
    %             %panel 1

                time_current = toc;
                while toc <= time_current + attendance_time
                    %panel 1&2
                    set(time,'String',num2str(toc));
                    drawnow
                    %panel 1&2
                end
                % the amount of seconds that user attends passes
            elseif dataset_user(1,2) == 2 && rand > 0.8
    %             %panel 1
                set(attending,'String','YES');
                drawnow
    %             %panel 1

                time_current = toc;
                while toc <= time_current + attendance_time
                    %panel 1&2
                    set(time,'String',num2str(toc));
                    drawnow
                    %panel 1&2
                end
                % the amount of seconds that user attends passes            
            end
        else
            trash_messages(index_trash,:) = queue_priority3(1,:);
            queue_priority3(1,:) = [];
            index_priority3 = index_priority3 - 1;
            index_trash = index_trash + 1;
        end
        
        %panel 1
        set(attending,'String','');
        drawnow
        %panel 1 
        
    end
    %% CLEAR GREEN PARTS TO WHITE
    time_current = toc;
    while toc <= time_current + 0.5

    end
    set(auditory,'BackgroundColor','white');
    set(visual,'BackgroundColor','white');
    set(haptic,'BackgroundColor','white');
    set(appname,'String','');
    set(apppriority,'String','');
    drawnow
    %% SCORE AND RATIO CALCULATIONS
    score_array = score_calculations(decided_messages, trash_messages,queue_priority1, queue_priority2, queue_priority3);
    communicative_component = score_array(1);
    mean_disturbance = score_array(2);

    ratio_array = ratio_calculations(index_trash, index_decision, communicative_component, mean_disturbance);
    index_ratio = ratio_array(1);
    score_ratio = ratio_array(2);
    
    score_development_matrix(1,index_communication_score) = communicative_component;
    index_communication_score = index_communication_score + 1;
    score_development_matrix(2,index_disturbance_score) = mean_disturbance;
    index_disturbance_score = index_disturbance_score + 1;
    %% PANEL UPDATE
    set(time,'String',num2str(toc));
    set(communicative,'String',num2str(communicative_component));
    set(disturbance,'String',num2str(mean_disturbance));
    drawnow
    %% PANEL UPDATE
    set(priority1,'String',num2str(size(queue_priority1,1)));
    set(priority2,'String',num2str(size(queue_priority2,1)));
    set(priority3,'String',num2str(size(queue_priority3,1)));
    set(decided,'String',num2str(size(decided_messages,1)));
    set(trash,'String',num2str(size(trash_messages,1)));
%        set(pool,'String',num2str(size(queue_pool,1)));
    drawnow
end