%Closes receiver

function closmskr(system)

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

    close_system([system, '/Receiver/r(t)']);
    close_system([system, '/Receiver/x_c(t)']);
    close_system([system, '/Receiver/x_s(t)']);
    close_system([system, '/Receiver/s_rc(t)']);
    close_system([system, '/Receiver/s_rs(t)']);
    close_system([system, '/Receiver/v(t)']);
    close_system([system, '/Receiver/y(t)']);
    close_system([system, '/Receiver']);

%    open_system([system, '/Binärsignal']);
%    open_system([system, '/gesendetes',13,'Symbol']);
%    open_system([system, '/s(t)']);
%    open_system([system, '/r(t)']);
%    open_system([system, '/empfangenes',13,'Symbol']);

  end;

end;
