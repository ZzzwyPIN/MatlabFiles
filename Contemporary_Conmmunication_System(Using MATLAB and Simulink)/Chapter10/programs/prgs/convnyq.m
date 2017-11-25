% Convolution of Raised Cosine Pulses

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
	g1 = nyqro(alpha, x1);

	%convolution

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
		'Name', 'Convolution of Raised-Cosine Pulses', ...
		'Tag', 'ConvNyquistRolloff', ...
		'NumberTitle','off' ...
		);

	set(gcf,'DefaultTextColor','m');
	backcolor = get(gcf,'Color');


	% -----------------------------------
	% Slider for Rolloff Factor 
	% -----------------------------------
	
	text = uicontrol(gcf, ...
		'Tag', 'ConvNyqTextfeld', ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [.01 .85 .08 .1], ...
		'BackgroundColor', 'red', ...
		'ForegroundColor', 'white', ...
		'String', sprintf('Roll-off\nfactor\n%1.3f',alpha) ...
		);
	
cb = 'convnyq(get(findobj(gcf,''Tag'',''ConvNyqSlider''),''Value''),''update'');';

	slider = uicontrol(gcf, ...
		'Tag', 'ConvNyqSlider', ...
		'Style', 'slider', ...
        'Units', 'normalized', ...
		'Position', [.04 .2 .02 .6], ...
		'Min', 0, ...
		'Max', 1, ...
		'Value', alpha, ...
		'Callback', cb ...
		);


	% ---------------------------------
	% Plot 1: Raised Cosine Pulse
	% ---------------------------------
	
	subplot(2,2,1), plot(x1,g1,'EraseMode','background')

	title('Raised-Cosine Pulse') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvNyqPlot1');

	pos1 = get(gca, 'Position');
	set(gca,'Position',[pos1(1)-.1/2*pos1(3)+.04 pos1(2) 1.1*pos1(3) pos1(4)]);
	pos1 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.23 1]);

	set(gca,'XTick', [-5 :1: 5]);
	grid


	% ---------------------------------
	% Plot 2: Raised Cosine Pulse
	% ---------------------------------
	
	subplot(2,2,2), plot(x1,g1,'EraseMode','background')
	title('Raised Cosine Pulse') 
	xlabel('t/T')
	%ylabel('g(t/T)')
	set(gca,'Tag','ConvNyqPlot2');

	pos2 = get(gca, 'Position');
	set(gca,'Position',[pos2(1)-.1/2*pos1(3)+.04 pos2(2) 1.1*pos2(3) pos2(4)]);
	pos2 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.23 1]);
	set(gca,'XTick', -5: 1 : 5);
	grid



	% ------------------
	% Convolution star
	% ------------------

	text = uicontrol(gcf, ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [pos1(1)+pos1(3)+0.005, pos1(2)+pos1(4)/2-.15/2, (pos2(1)-pos1(1)-pos1(3))-0.005, .10], ...
		'FontSize', 30, ...
		'BackgroundColor', backcolor, ...
		'ForegroundColor', 'm', ...
		'String', '*' ...
		);


	% ----------------------------------------------------------
	% Plot 3: Convolution
	% ----------------------------------------------------------

	subplot(2,2,3), plot(x2,c,'EraseMode','background')
	title('Result of Convolution') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvNyqProdukt');

	pos3 = get(gca, 'Position');
	set(gca,'Position',[pos1(1) pos3(2) pos1(3)+pos2(3)+(pos2(1)-pos1(1)-pos1(3)) pos3(4)]);
	set(gcf,'DefaultTextColor','m');

	set(gca,'XLimMode','manual');
	set(gca,'XLim',[-rng rng]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-0.23 1]);

	set(gca,'XTick', -10: 1 : 10);
	grid

end;

if strcmp(action, 'update')

    set(0,'CurrentFigure',findobj(0,'Tag', 'ConvNyquistRolloff'));

	set(findobj(gcf,'Tag','ConvNyqTextfeld'),'String', sprintf('Roll-off\nfactor\n%1.3f',alpha));

	set(get(findobj(gcf,'Tag','ConvNyqPlot1'),'Children'),'YData',g1);
	set(get(findobj(gcf,'Tag','ConvNyqPlot2'),'Children'),'YData',g1);
	set(get(findobj(gcf,'Tag','ConvNyqProdukt'),'Children'),'YData',c);

	drawnow;

end;

clear action;
