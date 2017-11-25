function wnyqui(alpha,action)

%impulse response and Fourier transform of root-raised-cosine pulse

warning off;   % avoid devide by zero warning

if nargin == 0 alpha = .5; end;
if isstr(alpha) alpha = str2num(alpha); end;
if (alpha>1) alpha = 1; end;
if (alpha<0) alpha = 0; end;

if (nargin<2)
  action = 'start';
end;

if (strcmp(action,'start') | strcmp(action,'update'))

	% define constants
	laenge = 5;
	aufloesung = 256;
	
	% generate time basis and raised cosine pulse
	x = linspace(-laenge-1,laenge,aufloesung);
        x2 = linspace(-laenge,laenge+1,aufloesung);
	b = wnyqro(alpha, x);	

	% define frequency
	nw = linspace(-1,1,aufloesung);
	
	% plot spectrum
	th = wnyqrofr(alpha, nw);
	
end;	

if strcmp(action,'start')

	% open Figure window

	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');

	figure ('Position', [0.05*scnsize(3)   0.3*scnsize(4)   .9*scnsize(3)   0.4*scnsize(4)], ...
		'Name', 'Impulse Response and Fourier Transform of Root Raised-Cosine Pulse', ...
		'Tag', 'WNyquistRolloff', ...
		'NumberTitle', 'off' ...
		);
	
	% -----------------------------------
	% Slider for Rolloff Factor
	% -----------------------------------
	
	text = uicontrol(gcf, ...
		'Tag', 'WNyqTextfeld', ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [.01 .82 .08 .13], ...
		'BackgroundColor', 'red', ...
		'ForegroundColor', 'white', ...
        'String', sprintf('Roll-off\nfactor\n%1.3f',alpha) ...
    	);
	
cb = 'wnyqui(get(findobj(gcf,''Tag'',''WNyqSlider''),''Value''),''update'');';

	slider = uicontrol(gcf, ...
		'Tag', 'WNyqSlider', ...
		'Style', 'slider', ...
        'Units', 'normalized', ...
		'Position', [.04 .2 .02 .6], ...
		'Min', 0, ...
		'Max', 1, ...
		'Value', alpha, ...
		'Callback', cb ...
		);

	% ----------------------------------------
	% Plot 1: Root Raised Cosine Pulse
	% ----------------------------------------
	
	subplot(1,2,1); plot(x,b,'b-',x2,b,'g--','EraseMode','background'); set(gca, 'Tag', 'WNyqImpulsantwort');
	pos = get(gca,'Position'); pos = [pos(1,1)-.25/2*pos(1,3)+.03 pos(1,2) 1.25*pos(1,3) pos(1,4)];
	set(gca,'Position',pos); clear pos;
	
	set(gcf,'DefaultTextColor','m')
	xlabel('t/T');
	ylabel('g(t/T)');
	title('Impulse Response');
	set(gca,'XLimMode','manual');
	set(gca,'XLim', [-laenge laenge]);
	set(gca,'XTick', [-laenge : 1 : laenge]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim', [-.23 1.28]);
	grid
	
	% -----------------------
	% Plot 2: Frequency response
	% -----------------------
	
	subplot(1,2,2); plot(nw,[th'],'EraseMode','background'); set(gca, 'Tag', 'WNyqFrequenzgang');
    pos = get(gca,'Position'); pos = [pos(1,1)+.03 pos(1,2) 1.1*pos(1,3) pos(1,4)];
	set(gca,'Position',pos); clear pos;
	
	set(gcf,'DefaultTextColor','m')
	xlabel('f T');
	ylabel('G(f/T)/T');
	title('Fourier Transform');
	set(gca,'XLimMode','manual');
	set(gca,'XLim', [-1 1]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim', [ 0 1.125]);
	grid
	axis([-1 1 -0.2 1.2]);
    
	drawnow;
	
end;

if strcmp(action, 'update')

        set(0,'CurrentFigure',findobj(0,'Tag', 'WNyquistRolloff'));

	
    set(findobj(gcf,'Tag','WNyqTextfeld'),'String', sprintf('Roll-off\nfactor\n%1.3f',alpha));

	set(get(findobj(gcf,'Tag','WNyqImpulsantwort'),'Children'),'YData',b);
	set(get(findobj(gcf,'Tag','WNyqFrequenzgang'),'Children'),'YData',th);

	drawnow;

end;

warning on;

clear action;
