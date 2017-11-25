
function rarg = backmen (action);
% menu to return to main menu

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;

Buttons = 1;
ButtonText1 = 'Main Menu';


if nargin < 1                                           % no argument -> init 
  action = 'init';
end;



% -----------------------------------------------------------------
% init
% initialize variables and open window


if strcmp (action, 'init')

  % constants and definitions

   set(0,'Units','pixels');
   scnsize = get(0,'ScreenSize');

  MenuWinPos  = [10 (scnsize(4) - (Buttons*28+50)-40)];  % window position

                                 

  backmen ('openmenuwin');                                % open window
end;


% -----------------------------------------------------------------
% openmenuwin
% open window

if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 160 (Buttons*28+50)], ... 
    'Name', 'Tutorial', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'backmen');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 150 25], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'End of Experiment');

  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 150 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''backmen (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1


if strcmp (action, 'Button1')
 
    global name;
    if exist('name') == 1
      if ~isempty(name)
        eval(['abschuss ',name]);
      end;
    end

    delete (menuwinh);

    close;

    DigModTutorial;

end;
