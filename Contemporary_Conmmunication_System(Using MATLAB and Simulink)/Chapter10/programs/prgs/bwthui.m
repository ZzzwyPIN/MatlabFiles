function bwthui(cfreq,action)

%impulse response and frequency response of Butterworth Lowpass

if nargin == 0 cfreq = 5/(4*pi); end;
if isstr(cfreq) cfreq = str2num(alpha); end;
if (cfreq>1) cfreq = 1; end;
if (cfreq<0) cfreq = 0; end;

if (nargin<2)
  action = 'start';
end;

if (strcmp(action,'start') | strcmp(action,'update'))

	% define constants 
	laenge = 5;
	aufloesung = 20;	% Samples per unit
	
	% identical values as in  Simulink
	
	order = 4;

	cf = 4*tan(pi*cfreq/(aufloesung/4)/2);
 
    
    % get zeros, poles and gain
        
    z = [];
    p = exp(sqrt(-1)*(pi*(1:2:2*order-1)/(2*order)+pi/2)).';
    k = real(prod(-p));
    
    % Compute transfer function

    p1 = cfreq * p; 

    f1=linspace(-1,1);
    w1 = i*f1;

    w1=repmat(w1,order,1);
    p1=repmat(p1,1,length(f1));

    prod(w1-p1);

    Sf1 = k./prod(w1-p1);

    h1 = abs(Sf1);
    h1 = h1/max(h1);
    
    % Compute impulse response

    % first transform from s-space to state space

    p = p(isfinite(p));
    z = z(isfinite(z));

    np = length(p);
    nz = length(z);
    z = cplxpair(z,1e6*nz*norm(z)*eps + eps);
    p = cplxpair(p,1e6*np*norm(p)*eps + eps);

    a=[]; b=zeros(0,1); c=ones(1,0); d=1;

    if rem(np,2) & rem(nz,2)
        a = p(np);
        b = 1;
        c = p(np) - z(nz);
        d = 1;
        np = np - 1;
        nz = nz - 1;
    end
 
    if rem(np,2)
        a = p(np);
        b = 1;
        c = 1;
        d = 0;
        np = np - 1;
    end 

    if rem(nz,2)
        num = real(poly(z(nz)));
        den = real(poly(p(np-1:np)));
        wn = sqrt(prod(abs(p(np-1:np))));
        if wn == 0, wn = 1; end
            t_temp = diag([1 1/wn]); 
            a = t_temp\[-den(2) -den(3); 1 0]*t_temp;
            b = t_temp\[1; 0];
            c = [1 num(2)]*t_temp;
            d = 0;
            nz = nz - 1;
            np = np - 2;
        end

        v = 1;
        
        while v < nz
            index = v:v+1;
            num = real(poly(z(index)));
            den = real(poly(p(index)));
            wn = sqrt(prod(abs(p(index))));
    
            if wn == 0, wn = 1; end
                
            t_temp = diag([1 1/wn]); 
            a1 = t_temp\[-den(2) -den(3); 1 0]*t_temp;
            b1 = t_temp\[1; 0];
            c1 = [num(2)-den(2) num(3)-den(3)]*t_temp;
            d1 = 1;

            [ma1,na1] = size(a);
            [ma2,na2] = size(a1);
            a = [a zeros(ma1,na2); b1*c a1];
            b = [b; b1*d];
            c = [d1*c c1];
            d = d1*d;

            v = v + 2;
        end

        while v < np
            den = real(poly(p(v:v+1)));
            wn = sqrt(prod(abs(p(v:v+1))));
    
            if wn == 0, wn = 1; end
            
            t_temp = diag([1 1/wn]); 
            a1 = t_temp\[-den(2) -den(3); 1 0]*t_temp;
            b1 = t_temp\[1; 0];
            c1 = [0 1]*t_temp;
            d1 = 0;
 
            [ma1,na1] = size(a);
            [ma2,na2] = size(a1);
            a = [a zeros(ma1,na2); b1*c a1];
            b = [b; b1*d];
            c = [d1*c c1];
            d = d1*d;

            v = v + 2;
        end

    % Consider cutoff frequency

    a = a * cf;
    b= b * cf;
	 
  	t_temp = 1/2;
	r_temp = sqrt(t_temp);
	t1_temp = eye(size(a)) + a*t_temp/2;
	t2_temp = eye(size(a)) - a*t_temp/2;
	a = t2_temp\t1_temp;
   	b = t_temp/r_temp*(t2_temp\b);

    a = poly(a);
  
    cf = 2*atan2(cf,4);
    
    r = -ones(order,1);
    w = 0;
    
    b = poly(r);
    
    ehochj = exp(-j*w*(0:length(b)-1));
    b = real(b*(ehochj*a(:))/(ehochj*b(:)));
    
    % compute impulse response

	t = (0:(laenge*aufloesung-1))';
    imp = filter(b,a,t==0);

    t = t/aufloesung;

    
	% response to rectangular pulse
    
	x = [ones(aufloesung,1); zeros((laenge-1)*aufloesung,1)];
	rec = filter(b,a,x);
			
end;	


if strcmp(action,'start')

	% open window


	set(0,'Units','pixels');
	scnsize = get(0,'ScreenSize');

	figure ('Position', [0.05*scnsize(3)   0.3*scnsize(4)   0.9*scnsize(3)   0.4*scnsize(4)], ...
		'Name', 'Impulse Response, Rectangular Response and Frequency Response of 4th Order Butterworth Lowpass', ...
		'Tag', 'Butterworth', ...
		'NumberTitle', 'off' ...
		);
	
	% ----------------------------------
	% Slider for cuttoff frequency
	% ----------------------------------
	
	text = uicontrol(gcf, ...
		'Tag', 'BwthTextfeld', ...
		'Style', 'text', ...
        'Units', 'normalized', ...
		'Position', [.01 .82 .08 .13], ...
		'BackgroundColor', 'red', ...
		'ForegroundColor', 'white', ...
        'String', sprintf('Cut-off\nfrequency\n%1.3f',cfreq) ...
		);
	
    cb = 'bwthui(get(findobj(gcf,''Tag'',''BwthSlider''),''Value''),''update'');';

	slider = uicontrol(gcf, ...
		'Tag', 'BwthSlider', ...
		'Style', 'slider', ...
        'Units', 'normalized', ...
		'Position', [.04 .2 .02 .6], ...
		'Min', 0, ...
		'Max', 1, ...
		'Value', cfreq, ...
		'Callback', cb ...
		);

	% -------------------------------------------
	% Plot 1: impulse response
	% -------------------------------------------
	
	subplot(1,3,1);
	plot(t,imp,'EraseMode','background');
	set(gca, 'Tag', 'BwthImpulsantwort');

	set(gcf,'DefaultTextColor','m')
	xlabel('t/T');
	ylabel('g(t/T)');
	title('Impulse Response');
	set(gca,'XLimMode','manual');
	set(gca,'XLim', [0 laenge]);
	set(gca,'XTick', [0 : 1 : laenge]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim', [-.025 .125]);
	grid
	


	% -------------------------------------------
	% Plot 2: response to rectangular pulse
	% -------------------------------------------
	
	subplot(1,3,2);
	plot(t,rec,t,x,'EraseMode','background');
	set(gca, 'Tag', 'BwthRechteckantwort');

	set(gcf,'DefaultTextColor','m')
	xlabel('t/T');
	ylabel('g_r(t/T)');
	title('Response to Rectangular Pulse');
	set(gca,'XLimMode','manual');
	set(gca,'XLim', [0 laenge]);
	set(gca,'XTick', [0 : 1 : laenge]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim', [-.25 1.25]);
	grid
	
	% -----------------------
	% Plot 3: Frequency Response
	% -----------------------
	
	subplot(1,3,3);
	plot(f1,h1,'EraseMode','background');
    
	set(gca, 'Tag', 'BwthFrequenzgang');

	set(gcf,'DefaultTextColor','m')
	xlabel('f T');
	ylabel('G(f/T)/T');
	title('Fourier Transform');
	set(gca,'XLimMode','manual');
	set(gca,'XLim', [-1 1]);
	set(gca,'YLimMode','manual');
	set(gca,'YLim', [ 0 1.125]);
	grid
	
	drawnow;
	
end;

if strcmp(action, 'update')

        set(0,'CurrentFigure',findobj(0,'Tag', 'Butterworth'));

        set(findobj(gcf,'Tag','BwthTextfeld'),'String', sprintf('Cut-off\nfrequency\n%1.3f',cfreq));
	

	set(get(findobj(gcf,'Tag','BwthImpulsantwort'),'Children'),'YData',imp);
	chld = get(findobj(gcf,'Tag','BwthRechteckantwort'),'Children');
	set(chld(1),'YData',x); set(chld(2),'YData',rec); clear chld;
    set(get(findobj(gcf,'Tag','BwthFrequenzgang'),'Children'),'YData',h1);
    
	drawnow;

end;

clear action;
