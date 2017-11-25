%Closes receiver

function closqamr(system)

ss = get(0, 'ScreenSize');
sw = ss(3);

if (nargin == 0)
  % find current system
  system = get_param(0,'CurrentSystem');
  % find Root System
  while (~isempty(get_param(system, 'parent')))
    system = get_param(system, 'parent');
  end;
  % check if  System loaded
  if (exist(system) ~= 4)
    clear system; 
  end;
end;

if (exist('system') == 0)
  disp('No Simulink model found!');
else

  if (exist(system) ~= 4)
    disp(['System ',system,' not found.'])
  else;

    close_system([system, '/Receiver/x_c(t)']);
    close_system([system, '/Receiver/x_s(t)']);
    close_system([system, '/Receiver/r(t)']);
    close_system([system, '/Receiver/s_rc(t)']);
    close_system([system, '/Receiver/s_rs(t)']);
    close_system([system, '/Receiver/v_c(t)']);
    close_system([system, '/Receiver/v_s(t)']);
    close_system([system, '/Receiver/v(t)']);
    close_system([system, '/Receiver']);

  end;

end;
