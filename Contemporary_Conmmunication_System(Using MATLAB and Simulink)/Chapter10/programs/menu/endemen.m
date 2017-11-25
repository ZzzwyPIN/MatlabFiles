
function rarg = endemen (action);
% menu for end of tutorial

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;

Buttons = 2;
ButtonText1 = 'Yes';
ButtonText2 = 'No';


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

  endemen ('openmenuwin');                                % open window
end;


% -----------------------------------------------------------------
% openmenuwin


if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 160 (Buttons*28+40)], ... 
    'Name', 'End', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'endemen');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 160 20], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Exit tutorial ?');

  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 150 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''endemen (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1


if strcmp (action, 'Button1')

  delete(menuwinh);

  %abschuss;

  exit;

end;


% -----------------------------------------------------------------
% Button2


if strcmp (action, 'Button2')

  delete(menuwinh);

  DigModTutorial;

end;
