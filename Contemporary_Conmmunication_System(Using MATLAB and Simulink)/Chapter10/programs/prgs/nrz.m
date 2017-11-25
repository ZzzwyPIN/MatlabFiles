% plot impulse response of nrz rectangular pulse

warning off;

set(0,'Units','pixels');
scnsize = get(0,'ScreenSize');


%figure ('Position', [350   375   900   573], ...
figure ('Position', [0.25*scnsize(3)   0.15*scnsize(4)   0.7*scnsize(3)   0.7*scnsize(4)], ...
		'Name', 'Impulse Response and Fourier Transform of NRZ Rectangular Pulse', ...
		'Tag', 'NRZ Rectangular', ...
		'NumberTitle', 'off' ...
		);

set(gcf,'DefaultTextColor','m')


% -----------------------------
% Plot Nr 1: NRZ rectangular pulse
% ------------------------------



x = -2 : 0.005 : 2;
y = 0.5*(sign(x+0.5)-sign(x-0.5));

subplot(2,1,1), plot(x,y, 'linewidth', 2)
axis([-2 2 -0.2 1.2]);
title('Impulse Response') 
xlabel('t/T')
ylabel('g_T(t/T)')
set(gca,'YTick', 0: 0.5 : 1);
grid


% ----------------------------------------------
% Plot Nr 2: Fourier Transform 
% ----------------------------------------------

a = -10 : 0.005 : 10;
b = pi .* a;
c = sin(b)./b;

subplot(2,1,2), plot(a,c, 'linewidth', 2)
title('Fourier Transform')
xlabel('f T')
ylabel('G_T(f/T)/T')
set(gca,'XTick', -10: 1 : 10);
grid

warning on;
