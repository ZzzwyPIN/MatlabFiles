% Convolution of NRZ rectangular pulses

function convnrz(action)


if (nargin<1)
  action = 'start';
end;

if strcmp(action,'start')

	aufloesung = 200;
	laenge = 2;

	x1 = linspace(-laenge,laenge,aufloesung);
	g1 = 0.5*(sign(x1+0.5)-sign(x1-0.5));

	%Faltung 

	c = conv(g1,g1); 

	rng = -2 * x1(1);       % maximum length of axis symmetric
	anz = (length(c)-1)/2;  % number of axis labels to each side

	c = c ./ (anz/rng);     % amplitude correction

	x2 = zeros(size(c));    % compute x axis coordinates
	for k=1 : length(c)
	  x2(k) = (k-anz)*rng/anz;
	end;

end;


if strcmp(action,'start')

	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');

	% open window
	
	figure ('Position', [0.25*scnsize(3)   0.15*scnsize(4)   0.7*scnsize(3)   0.7*scnsize(4)], ...
		'Name', 'Convolution of NRZ Rectangular Pulses', ...
		'Tag', 'ConvNRZRechteck', ...
		'NumberTitle','off' ...
		);

	set(gcf,'DefaultTextColor','m');

	backcolor = get(gcf,'Color');




	% ------------------------------
	% Plot 1: NRZ rectangular pulse
	% ------------------------------
	
	subplot(2,2,1), plot(x1,g1,'EraseMode','background')

	title('NRZ Rectangular Pulse') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvNRZPlot1');

	pos1 = get(gca, 'Position');
	set(gca,'Position',[pos1(1)-.1/2*pos1(3) pos1(2) 1.1*pos1(3) pos1(4)]);
	pos1 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.25 1.25]);

	set(gca,'XTick', [-5 :1: 5]);
	grid


	% ------------------------------
	% Plot 2: NRZ rectangular pulse
	% ------------------------------
	
	subplot(2,2,2), plot(x1,g1,'EraseMode','background')
	title('NRZ Rectangular Pulse') 
	xlabel('t/T')
	
	set(gca,'Tag','ConvNRZPlot2');

	pos2 = get(gca, 'Position');
	set(gca,'Position',[pos2(1)-.1/2*pos1(3) pos2(2) 1.1*pos2(3) pos2(4)]);
	pos2 = get(gca, 'Position');

	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-.25 1.25]);

	set(gca,'XTick', -5: 1 : 5);
	grid




	% ------------------
	% Convolution 
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

	% -------------------------------------------------------
	% Plot 3: convolution of NRZ rectangular pulses
	% -------------------------------------------------------

	subplot(2,2,3), plot(x2,c,'EraseMode','background')
	title('Result of Convolution') 
	xlabel('t/T')
	ylabel('g(t/T)')
	set(gca,'Tag','ConvNRZProdukt');

	pos3 = get(gca, 'Position');
	set(gca,'Position',[pos1(1) pos3(2) pos1(3)+pos2(3)+(pos2(1)-pos1(1)-pos1(3)) pos3(4)]);
	set(gcf,'DefaultTextColor','m')

	set(gca,'XLimMode','manual');
	set(gca,'XLim',[-rng rng]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim',[-0.25 1.25]);

	set(gca,'XTick', -10: 1 : 10);
	grid

end;

clear action;
