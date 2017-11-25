
function rarg = abschuss(system);

% kills Simulink system 
%
% -all systems or specified system 
% -all windows are closed

if nargin < 1                  % no argument -> kill all

  % find all systems


while (~isempty(get_param(0,'CurrentSystem')))
	system=get_param(0,'CurrentSystem');

    isempty(get_param(0,'CurrentSystem'))
    
    % find root system
    root=system
    while ~isempty(get_param(root,'Parent')),
        
      root=get_param(root,'Parent');
      
    end;
    
   % stop root system (simulation)
    
    set_param(system, 'SimulationCommand','Stop');

  
    % close system

    close_system(system,0)
    clear functions

    % close all windows of the system

    children = get (0, 'Children');
    for child = children'
      pos = findstr(get (child, 'Name'), [system,'/']);
      if ~isempty(pos)
        if pos(1) == 1
          delete (child);
        end;
      end
    end;
    clear children child pos;

  end;


else                           % kill only specified system


 %disp(['Kill  ',system,' ']);

  % check if system exists
  if ~(exist(system) == 4)

    disp([' ',system,' not found'])
   else

    % find root system
    root=system;
    while ~isempty(get_param(root,'Parent')),
      root=get_param(root,'Parent');
    end;

    
    if ~isempty(root)
      
        % stop root system (simulation)
    
        set_param(system, 'SimulationCommand','Stop');

    
    end

    % kill system
    close_system(system,0)
    clear functions

  end;

   % close all windows of the system

    children = get (0, 'Children');
    for child = children'
      pos = findstr(get (child, 'Name'), [system,'/']);
      if ~isempty(pos)
        if pos(1) == 1
          delete (child);
        end;
      end;
    end;
    clear children child pos;

end;
