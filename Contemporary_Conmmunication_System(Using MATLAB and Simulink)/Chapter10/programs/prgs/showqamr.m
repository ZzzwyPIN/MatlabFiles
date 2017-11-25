%Shows receiver 

function showqamr(system)

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


    close_system([system, '/a_s(t) (transmitter)']);
    close_system([system, '/a_c(t) (transmitter)']);
    close_system([system, '/transmitted symbols']);
    close_system([system, '/r(t)']);
    close_system([system, '/u(t)']);
    close_system([system, '/detected symbols']);


    open_system([system, '/Receiver']);


  end;

end;
