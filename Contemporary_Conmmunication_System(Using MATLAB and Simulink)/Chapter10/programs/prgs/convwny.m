% Convolution of Root-Raised Cosine Pulses

function convnyq(alpha,action)

if nargin == 0 alpha = .5; end;
if isstr(alpha) alpha = str2num(alpha); end;
if (alpha>1) alpha = 1; end;
if (alpha<0) alpha = 0; end;

if (nargin<2)
  action = 'start';
end;

if (strcmp(action,'start') | strcmp(action,'update'))

	rolloff = num2str(alpha);

	aufloesung = 200;
	laenge = 5;

	x1 = linspace(-laenge,laenge,aufloesung);
	g1 = wnyqro(alpha, x1);

	%Faltung 

	c = conv(g1,g1); 

	rng = -2 * x1(1);       % maximum axis value
	anz = (length(c)-1)/2;  % number of axis values for each side

	c = c ./ (anz/rng);     % amplitude correction

	x2 = zeros(size(c));    % compute new x coordinates

	for k=1 : length(c)
	  x2(k) = (k-anz)*rng/anz;
	end;

end;

if strcmp(action,'start')

	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');

	% open window
	figure ('Position', [0.25*scnsize(3)   0.15*scnsize(4)   0.7*scnsize(3)   0.7*scnsize(4)], ...
		'Name', 'Convolution of Root-Raised-Cosine Pulses', ...
		'Tag', 'ConvWNyquistRolloff', ...
		'NumberTitle','off' ...
		);

	set(gcf,'DefaultTextColor','m');
	backcolor = get(gcf,'Color');


	% -----------------------------------
	% Slider for Rolloff Factor
	% -----------------------------------
	
	text = uicontrol(gcf, ...
		'Tag', 'ConvWNyqTextfeld', ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [.01 .85 .08 .1], ...
		'BackgroundColor', 'red', ...
		'ForegroundColor', 'white', ...
        'String', sprintf('Roll-off\nfactor\n%1.3f',alpha) ...
		);
	
cb = 'convwny(get(findobj(gcf,''Tag'',''ConvWNyqSlider''),''Value''),''update'');';

	slider = uicontrol(gcf, ...
		'Tag', 'ConvWNyqSlider', ...
		'Style', 'slider', ...
        'Units', 'normalized', ...
		'Position', [.04 .2 .02 .6], ...
		'Min', 0, ...
		'Max', 1, ...
		'Value', alpha, ...
		'Callback', cb ...
		);


	% ----------------------------------------
	% Plot Nr 1: Root-Raised-Cosine Pulse
	% ----------------------------------------
	
	subplot(2,2,1), plot(x1,g1,'EraseMode','background')

	title('Root-Raised-Cosine Pulse') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvWNyqPlot1');

	pos1 = get(gca, 'Position');
	set(gca,'Position',[pos1(1)-.1/2*pos1(3)+.04 pos1(2) 1.1*pos1(3) pos1(4)]);
	pos1 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.23 1.3]);

	set(gca,'XTick', [-5 :1: 5]);
	grid


	% ---------------------------------
	% Plot Nr 2: Root-Raised-Cosine Pulse
	% ---------------------------------
	
	subplot(2,2,2), plot(x1,g1,'EraseMode','background')
	title('Root-Raised-Cosine Pulse') 
	xlabel('t/T')
	%ylabel('g(t/T)')
	set(gca,'Tag','ConvWNyqPlot2');

	pos2 = get(gca, 'Position');
	set(gca,'Position',[pos2(1)-.1/2*pos1(3)+.04 pos2(2) 1.1*pos2(3) pos2(4)]);
	pos2 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.23 1.3]);

	set(gca,'XTick', -5: 1 : 5);
	grid


	% ------------------
	% Convolution star
	% ------------------

	text = uicontrol(gcf, ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [pos1(1)+pos1(3)+0.005, pos1(2)+pos1(4)/2-.15/2, (pos2(1)-pos1(1)-pos1(3))-0.005, .15], ...
		'FontSize', 30, ...
		'BackgroundColor', backcolor, ...
		'ForegroundColor', 'm', ...
		'String', '*' ...
		);


	% -----------------------------------------------------------------
	% Plot Nr 3: Convolution
	% -----------------------------------------------------------------

	subplot(2,2,3), plot(x2,c,'EraseMode','background')
	title('Result of Convolution') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvWNyqProdukt');

	pos3 = get(gca, 'Position');
	set(gca,'Position',[pos1(1) pos3(2) pos1(3)+pos2(3)+(pos2(1)-pos1(1)-pos1(3)) pos3(4)]);
	set(gcf,'DefaultTextColor','m')

	set(gca,'XLimMode','manual');
	set(gca,'XLim',[-rng rng]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-0.23 1]);

	set(gca,'XTick', -10: 1 : 10);
	grid

end;

if strcmp(action, 'update')

        set(0,'CurrentFigure',findobj(0,'Tag', 'ConvWNyquistRolloff'));

	set(findobj(gcf,'Tag','ConvWNyqTextfeld'),'String', sprintf('Roll-off\nfactor\n%1.3f',alpha));

	set(get(findobj(gcf,'Tag','ConvWNyqPlot1'),'Children'),'YData',g1);
	set(get(findobj(gcf,'Tag','ConvWNyqPlot2'),'Children'),'YData',g1);
	set(get(findobj(gcf,'Tag','ConvWNyqProdukt'),'Children'),'YData',c);

	drawnow;

end;

clear action;
