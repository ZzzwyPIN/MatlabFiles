%Shows receiver 

function showmskr(system)

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


    close_system([system, '/u(t)']);
    close_system([system, '/v(t)']);
    close_system([system, '/a(t)']);
    close_system([system, '/r(t)']);
    close_system([system, '/phi(t)']);

    open_system([system, '/Receiver']);
%    open_system([system, '/Empfänger/r(t)']);
%    open_system([system, '/Empfänger/x_eI(t)']);
%    open_system([system, '/Empfänger/d_eI(t)']);
%    open_system([system, '/Empfänger/v_eI(t)']);
%    open_system([system, '/Empfänger/x_eQ(t)']);
%    open_system([system, '/Empfänger/d_eQ(t)']);
%    open_system([system, '/Empfänger/v_eQ(t)']);
%    open_system([system, '/Empfänger/v(t)']);

  end;

end;
