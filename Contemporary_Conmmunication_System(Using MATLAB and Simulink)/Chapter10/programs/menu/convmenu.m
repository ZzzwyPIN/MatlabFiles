function rarg = convmenu (action);
% generates menu

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;


Buttons = 6;
ButtonText1 = 'NRZ Rectangular * NRZ Rectangular';
ButtonText2 = 'Raised-Cosine * Raised-Cosine';
ButtonText3 = 'Root-RC * Root-RC';
ButtonText4 = 'NRZ Rectangular * Butterworth';
ButtonText5 = 'Menu Pulse Shape';
ButtonText6 = 'Main Menu';



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

  convmenu ('openmenuwin');                                % open window

end;


% -----------------------------------------------------------------
% openmenuwin
% 

if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 230 (Buttons*28+50)], ... 
    'Name', 'Tutorial', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'convmenu');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 230 25], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Convolution');


  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 220 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''convmenu (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1


if strcmp (action, 'Button1')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

  convnrz;
  convmenu;

end;

% -----------------------------------------------------------------
% Button2


if strcmp (action, 'Button2')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

  convnyq(0);
  convmenu;

end;


% -----------------------------------------------------------------
% Button3


if strcmp (action, 'Button3')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

  convwny(0);
  convmenu;

end;


% -----------------------------------------------------------------
% Button4


if strcmp (action, 'Button4')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

  bwthui;
  convmenu;

end;


% -----------------------------------------------------------------
% Button5


if strcmp (action, 'Button5')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

  pshapemenu;

end;


% -----------------------------------------------------------------
% Button6


if strcmp (action, 'Button6')

  delete(menuwinh);

  % close all Matlab windows
  delete(get (0, 'Children'));

DigModTutorial;

end;
