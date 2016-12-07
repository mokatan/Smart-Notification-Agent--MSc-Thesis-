function [  ] = myinterface(  )
%MYÝNTERFACE Summary of this function goes here
%   Detailed explanation goes here
figure('Name', 'Notification Brokering Algorithm');

%panel 1 + 2
uipanel('Title','Time & User & Environment Status','Units','Pixels','FontSize',9,'BackgroundColor','white','Position',[10 215 250 200]);
uicontrol('Style','text','String','Current Time','pos',[20 375 100 20]);
uicontrol('Style','text','String','Visual Focus','pos',[20 345 100 20]);
uicontrol('Style','text','String','Illumination','pos',[20 315 100 20]);
uicontrol('Style','text','String','Noise','pos',[20 285 100 20]);
uicontrol('Style','text','String','Speaking','pos',[20 255 100 20]);
uicontrol('Style','text','String','Physical','pos',[20 225 100 20]);
%panel 1 + 2

%panel 3
uipanel('Title','Notification','Units','Pixels','FontSize',9,'BackgroundColor','white','Position',[10 10 250 180]);
uicontrol('Style','text','String','Application','pos',[20 140 100 20]);
uicontrol('Style','text','String','Priority','pos',[20 110 100 20]);
uicontrol('Style','text','String','Attendance','pos',[20 80 100 20]);
uicontrol('Style','text','String','Channels','pos',[20 50 100 20]);
uicontrol('Style','text','String','Auditory','pos',[75 20 45 20]);
uicontrol('Style','text','String','Visual','pos',[125 20 45 20]);
uicontrol('Style','text','String','Haptic','pos',[175 20 45 20]);
%panel 3

%panel 4 slider and start button
uipanel('Title','User Preference Ratio','Units','Pixels','FontSize',9,'BackgroundColor','white','Position',[280 325 250 90]);
slider_label = uicontrol('Style', 'edit', 'Position', [475 370 50 20],'Callback', @updategraph);
level_slider = uicontrol('Style', 'Slider','Min',-4,'Max',4,'Value',0,'Position', [290 370 180 20],'Callback', @updategraph); 
assignin('base','level',0);
    function updategraph(hObj, event)
        returned = get(hObj,'Value'); 
        labelstring1 = num2str(abs(returned) + 1);
        if returned < 0
            labelstring1 = num2str((abs(returned) + 1)*-1);
        end
        labelstring2 = 'x';
        labelstring = strcat(labelstring1,labelstring2);
        set(slider_label, 'String', labelstring)
        assignin('base','level',returned); 
    end

start_button = uicontrol('Style', 'pushbutton', 'String', 'Start','Position', [470 330 50 20],'Callback', 'queueing');   
%panel 4

%panel 5
uipanel('Title','Scores','Units','Pixels','FontSize',9,'BackgroundColor','white','Position',[280 200 250 120]);   %  solasaðakaydýr  aþaðýyukarýkaydýr eninideðiþtir boyunudeðiþtir
uicontrol('Style','text','String','Communication Score','pos',[290 260 100 30]);
uicontrol('Style','text','String','Disturbance Score','pos',[290 210 100 30]);
%panel 5

%panel 6
uipanel('Title','Queues & Sent & Trash','Units','Pixels','FontSize',9,'BackgroundColor','white','Position',[280 10 250 180]);
uicontrol('Style','text','String','Queue 1','pos',[290 140 100 20]);
uicontrol('Style','text','String','Queue 2','pos',[290 110 100 20]);
uicontrol('Style','text','String','Queue 3','pos',[290 80 100 20]);
uicontrol('Style','text','String','Sent','pos',[290 50 100 20]);
uicontrol('Style','text','String','Trash','pos',[290 20 100 20]);
%uicontrol('Style','text','String','Pool','pos',[290 0 100 20]);
%panel 6

drawnow %to update the interface immediately
end
