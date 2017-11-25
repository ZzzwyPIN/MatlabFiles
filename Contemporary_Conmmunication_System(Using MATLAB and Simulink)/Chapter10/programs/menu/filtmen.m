
function rarg = filtmen (action);
% menu to choose receive filter

global name;

global Buttons;
global menuwinh;
global buttonh;
global MenuWinPos;


Buttons = 3;
ButtonText1 = 'Matched Filter';
ButtonText2 = 'Butterworth';
ButtonText3 = 'Main Menu';


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

  filtmen ('openmenuwin');                                % open window
end;


% -----------------------------------------------------------------
% openmenuwin
% open window

if strcmp (action, 'openmenuwin')
 
  menuwinh = figure ('Color', 'white', ...              % open window
    'Position', [MenuWinPos 140 (Buttons*28+50)], ... 
    'Name', 'Tutorial', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Resize', 'off', ...
    'UserData', 'filtmen');

  uicontrol (menuwinh, ...
    'Style', 'text', ...
    'Position', [5 (Buttons*28+10) 130 30], ...
    'BackgroundColor', 'white', ...
    'HorizontalAlignment', 'center', ...
    'String', 'Receive Filter:');

  for k = 1:Buttons
    ypos = (Buttons- k) * 28 + 10;
    ButtonTextString = eval (['ButtonText'  num2str(k)]);
    CallBackFunction = ['Button' num2str(k)];
    createbutton = ['buttonh(' num2str(k) ') = uicontrol (menuwinh, ' ...
                        '''Position'', [5 ' num2str(ypos) ' 130 22], ' ...
                         '''String'', ''' ButtonTextString ''', ' ...
                         '''BackgroundColor'', ''white'', ' ...
                         '''CallBack'', ''filtmen (''''' CallBackFunction ''''')'');'];
   eval (createbutton);
  end;
  clear createbutton ypos ButtonTextStr CallBackFunction;
end;



% -----------------------------------------------------------------
% Button1


if strcmp (action, 'Button1')

  delete(menuwinh);

  name=[name,'mf'];

  backmen;
  eval(name);

end;


% -----------------------------------------------------------------
% Button2


if strcmp (action, 'Button2')

  delete(menuwinh);

  name=[name,'bw'];

  backmen;
  eval(name);

end;


% -----------------------------------------------------------------
% Button3


if strcmp (action, 'Button3')

  delete(menuwinh);

  DigModTutorial;

end;
