% opens slider for rolloff factor

function setrloff(faktor,action)

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

  
	if (system == 'ookwnymf' | system == 'bpswnymf' | system == 'askwnymf')
        	sname1 = [system,'/','Root-RC transmit filter'];
	else
		sname1 = [system,'/','Raised-Cosine transmit filter'];

	end;

   

	if (system == 'ookwnymf' | system == 'bpswnymf' | system == 'askwnymf')
       		ename1 = [system,'/','Root-RC receive filter'];
	else
		ename1 = [system,'/','Raised-Cosine receive filter'];
	end;

 
    e1=isempty(get_param(sname1,'Parent'));
     
    e3=isempty(get_param(ename1,'Parent'));
       

    if ( e1 | e3  )
	   disp('Error! Check if the systems');
	   disp('''Raised-Cosine'' or ''Root-RC''');
	   disp('exist in Transmitter and Receiver!');
    else

          %no argument? Read Rolloff-Factor 
          if nargin < 1
            
	        faktor = get_param([sname1],'MaskParam3');	


          end;
          
          if isstr(faktor) faktor = str2num(faktor); end;

            if (nargin<2)
                action = 'start';
            end;

            if (strcmp(action,'start') | strcmp(action,'update'))

                max_limit = 1;
                min_limit = 0;
	
            end;	

            if strcmp(action,'start')

                % do not open new window if one exists
                
                if (isempty(findobj(0, 'Tag', 'Rolloff')))

	                set(0,'Units','pixels');
	                scnsize = get(0,'ScreenSize');

	                % open figure window
          
	                figure ('Position', [172, scnsize(4)-466, 100, 400], ...
		                'Name', [system,'/','Rolloff'], ...
		                'Tag', 'Rolloff', ...
		                'NumberTitle', 'off', ...
		                'MenuBar', 'none' ...
		                );
	
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
		                'Tag', 'faktorTextfeld', ...
		                'Style', 'text', ...
                        'Units', 'normalized', ...
		                'Position', [.1 .85 .8 .1], ...
		                'BackgroundColor', 'red', ...
		                'ForegroundColor', 'white', ...
                        'String', sprintf('Roll-off\nfactor\n%1.3f',faktor) ...
		                );
	
	                cb = 'sld=findobj(gcf,''Tag'',''faktorSlider''); val=get(sld,''Value''); setrobin(val,''update'');';

	                slider = uicontrol(gcf, ...
		                'Tag', 'faktorSlider', ...
		                'Style', 'slider', ...
                        'Units', 'normalized', ...
		                'Position', [.2 .025 .2 .775], ...
		                'Min', min_limit, ...
		                'Max', max_limit, ...
		                'Value', faktor, ...
		                'Callback', cb ...
		                );

                    % Scale

	            skala = axes('Parent',gcf, ...
		            'Box','off', ...
		            'Color',backcolor, ...
                    'Units', 'normalized', ...
		            'Position',[.8 .060 .2 .700], ...
		            'Tag','faktorSkala', ...
		            'Visible','on', ...
		            'XColor',backcolor, ...
		            'XLimMode','manual', ...
		            'YColor',scalcolor, ...
		            'YLim',[min_limit max_limit], ...
		            'YLimMode','manual', ...
		            'YScale','linear', ...
		            'ZColor',backcolor ...
                    );

                end;

            end;

            if strcmp(action, 'update')

                set(0,'CurrentFigure',findobj(0,'Tag', 'Rolloff'));

                
                set(findobj(gcf,'Tag','faktorTextfeld'),'String', sprintf('Roll-off\nfactor\n%1.3f',faktor));

            
	            set_param(sname1,'MaskParam3',num2str(faktor));
	
	            set_param(ename1,'MaskParam3',num2str(faktor));
	
                drawnow;

            end;
        end;
    end;
end;
 

clear action;
