function rarg = pshapemenu (action);

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;


Buttons = 6;
ButtonText1 = 'NRZ Rectangular';
ButtonText2 = 'Raised-Cosine';
ButtonText3 = 'Root-RC';
ButtonText4 = 'Butterworth';
ButtonText5 = 'Convolution';
ButtonText6 = 'Main Menu';


if nargin < 1                                           % no argument -> init 
  action = 'init';
end;


% -----------------------------------------------------------------
% init
% initialize variables and open window


if strcmp (action, 'init')

  % Constants and definitions

   set(0,'Units','pixels');
   scnsize = get(0,'ScreenSize');

  MenuWinPos  = [10 (scnsize(4) - (Buttons*28+50)-40)];  % window position

  pshapemenu ('openmenuwin');                                % open window
end;


% -----------------------------------------------------------------
% openmenuwin
% 

if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 160 (Buttons*28+50)], ... 
    'Name', 'Tutorial', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'pshapemenu');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 150 25], ...
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
                         '''CallBack'', ''pshapemenu (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1


if strcmp (action, 'Button1')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  nrz;
  pshapemenu;

end;

% -----------------------------------------------------------------
% Button2

if strcmp (action, 'Button2')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  nyqui(0);
  pshapemenu;

end;

% -----------------------------------------------------------------
% Button3

if strcmp (action, 'Button3')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  wnyqui(0);
  pshapemenu;

end;

% -----------------------------------------------------------------
% Button4

if strcmp (action, 'Button4')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  bwthui;
  pshapemenu;

end;

% -----------------------------------------------------------------
% Button5
%

if strcmp (action, 'Button5')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  convmenu;
 
end;

% -----------------------------------------------------------------
% Button6


if strcmp (action, 'Button6')

  delete(menuwinh);

  %close all Matlab windows
  delete(get (0, 'Children'));

  DigModTutorial;

end;
