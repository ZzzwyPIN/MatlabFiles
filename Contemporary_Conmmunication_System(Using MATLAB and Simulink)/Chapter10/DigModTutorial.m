function rarg = DigModTutorial (action);
% generates windows to choose experiments

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;

% set path

%addpath ./prgs ./menu ./pulse ./depfun

%warning off;

Buttons = 9;
ButtonText1 = 'Pulse Shape';
ButtonText2 = 'OOK';
ButtonText3 = 'BPSK';
ButtonText4 = '4-ASK';
ButtonText5 = 'QPSK';
ButtonText6 = 'Offset-QPSK';
ButtonText7 = 'MSK';
ButtonText8 = '16-QAM';
ButtonText9 = 'End';


if nargin < 1                                           % no argument -> init 
  action = 'init';
end;


% -----------------------------------------------------------------
% init
% Initialize variables and open window


if strcmp (action, 'init')

  % Cpnstants and definitions

	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');


  MenuWinPos  = [10 (scnsize(4) - (Buttons*28+50)-40)];                                % window position

  DigModTutorial ('openmenuwin');                                % open window
end;


% -----------------------------------------------------------------
% openmenuwin
% open menu window

if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 160 (Buttons*28+50)], ... 
    'Name', 'Tutorial', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'tutorial');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 155 25], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Experiment:');

  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 150 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''DigModTutorial (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;


% -----------------------------------------------------------------
% Button1

if strcmp (action, 'Button1')

  delete(menuwinh);
  pshapemenu;

end;


% -----------------------------------------------------------------
% Button2

if strcmp (action, 'Button2')

  delete(menuwinh); 
  auswahl('ook');

end;


% -----------------------------------------------------------------
% Button3

if strcmp (action, 'Button3')

  delete(menuwinh);
  auswahl('bps');

end;


% -----------------------------------------------------------------
% Button4

if strcmp (action, 'Button4')

  delete(menuwinh);
  auswahl('ask');

end;


% -----------------------------------------------------------------
% Button5

if strcmp (action, 'Button5')

  delete(menuwinh);
  auswahl('qps');

end;


% -----------------------------------------------------------------
% Button6


if strcmp (action, 'Button6')

  delete(menuwinh);
  auswahl('oqp');

end;



% Button7


if strcmp (action, 'Button7')

  delete(menuwinh);

  global name;
  name = 'msk';
  backmen;
  eval(name);

end;


% -----------------------------------------------------------------
% Button8


if strcmp (action, 'Button8')

   delete(menuwinh);
   auswahl('qam');

end;



% -----------------------------------------------------------------
% Button9


if strcmp (action, 'Button9')

  delete(menuwinh);
  endemen;

end;



