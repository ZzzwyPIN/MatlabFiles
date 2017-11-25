function rarg = pulsemenu (action);
% menu for choice of pulse shape

global name;

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;


Buttons = 4;
ButtonText1 = 'NRZ Rectangular';
ButtonText2 = 'Raised-Cosine';
ButtonText3 = 'Root-RC';
ButtonText4 = 'Main Menu';


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

  pulsemenu ('openmenuwin');                                % open window
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
    'UserData', 'pulsemenu');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+5) 150 30], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Pulse Shape');

  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;	
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 150 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''pulsemenu (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1

if strcmp (action, 'Button1')

  delete(menuwinh);

  name=[name,'nrz'];
  filtmen;

end;


% -----------------------------------------------------------------
% Button2

if strcmp (action, 'Button2')

  delete(menuwinh);

  name=[name,'nyq'];
  name=[name,'mf'];

  backmen;
  eval(name);

end;


% -----------------------------------------------------------------
% Button3


if strcmp (action, 'Button3')

  delete(menuwinh);

  name=[name,'wny'];
  name=[name,'mf'];

  backmen;
  eval(name);

end;


% -----------------------------------------------------------------
% Button4


if strcmp (action, 'Button4')

  delete(menuwinh);

  DigModTutorial;

end;
