% opens slider for noise variance

function setnoise(varianz,action)

% find simulink system
system = get_param(0,'CurrentSystem');
if isempty(system)
  disp('No system found.');
else
  while ~isempty(get_param(system,'Parent'))
    system = get_param(system,'Parent');
  end;

  % check if system exists
  if ~(exist(system) == 4)
    disp(['no system  ',system,' found.'])
  else

    % check if system has block Channel.
    if (get_param([system,'/','Channel'],'Parent') ~= system)
      disp(['System  ',system,' has no block Channel.'])
    else

      % no argument: read mask parameter variance

      if nargin < 1
        
	    varianz=get_param([system,'/','Channel'],'variance');
       
      end;

      if ischar(varianz) 
		varianz = str2num(varianz); 
	end;


	% adapt variance to range of slider 

	if (varianz > 100)
		varianz = 100;
		set_param([system,'/','Channel'],'variance',num2str(varianz));
	elseif (varianz < 10^-10)
		varianz = 10^-10;
		set_param([system,'/','Channel'],'variance',num2str(varianz));
	end;



      if (nargin<2)
        action = 'start';
      end;

      if (strcmp(action,'start') | strcmp(action,'update'))

         dekaden = 12;
         max_limit = 100;
         min_limit = max_limit / 10^dekaden;
	
      end;	

      if strcmp(action,'start')

        % do not open new window if one exists

        if (isempty(findobj(0, 'Tag', 'Noise')))

	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');

	  % open figure window

	figure ('Position', [40 scnsize(4)-460   100   400], ...
		  'Name', [system,'/','Noise'], ...
		  'Tag', 'Noise', ...
		  'NumberTitle', 'off', ...
		  'MenuBar', 'none' ...
		  );

	set(gcf,'DefaultTextColor','m');

	backcolor = get(gcf,'Color');

	if (backcolor == [1 1 1])
		scalcolor = [0 0 0];
	else
		scalcolor = [1 1 1];
	end;
	
	  % ---------------------------------------
	  % Slider 
	  % ---------------------------------------
	
	  text = uicontrol(gcf, ...
		  'Tag', 'VarianzTextfeld', ...
		  'Style', 'text', ...
		  'Units', 'normalized', ...
          'Position', [.1 .85 .8 .1], ...
		  'BackgroundColor', 'red', ...
		  'ForegroundColor', 'white', ...
		  'String', sprintf('Variance\nStd^2\n%1.3f',varianz) ...
		  );
      
      
	
	  cb = 'vs=findobj(gcf,''Tag'',''VarianzSlider''); ud=get(vs,''UserData''); max_limit=ud(1); min_limit=ud(2); dekaden=ud(3); val=get(vs,''Value''); setnoise(max_limit*10^(-dekaden+val),''update'');';

	  val = dekaden-log10(max_limit)+log10(varianz);

	  slider = uicontrol(gcf, ...
		  'Tag', 'VarianzSlider', ...
		  'Style', 'slider', ...
          'Units', 'normalized', ...
		  'Position', [.2 .025 .2 .775], ...
		  'Min', 0, ...
		  'Max', dekaden, ...
		  'Value', val, ...
		  'Callback', cb, ...
		  'UserData', [max_limit min_limit dekaden] ...
		  );

          % Scale

	  skala = axes('Parent',gcf, ...
		  'Box','off', ...
		  'Color',backcolor, ...
		  'Position',[.8 .060 .2 .700], ...
		  'Units', 'normalized', ...
		  'Tag','VarianzSkala', ...
		  'Visible','on', ...
		  'XColor',backcolor, ...
		  'XLimMode','manual', ...
		  'YColor',scalcolor, ...
		  'YLim',[min_limit max_limit], ...
		  'YLimMode','manual', ...
		  'YScale','log', ...
		  'ZColor',backcolor);

        end;

      end;

      if strcmp(action, 'update')

        set(0,'CurrentFigure',findobj(0,'Tag', 'Noise'));

        
        set(findobj(gcf,'Tag','VarianzTextfeld'),'String', sprintf('Variance\nStd^2\n%1.3f',variance));


	    set_param([system,'/','Channel'],'variance',num2str(varianz));

     
        drawnow;

      end;
    end;
  end;
end;

clear action;
