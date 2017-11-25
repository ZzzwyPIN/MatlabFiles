%Correction by GB 16.1.98:
%sqrt was not considered !
%Correction done for FIR only

function [y, t] = rcosfltk(x, Fd, Fs, type_flag, R, Delay, tol)
%RCOSFLT Filters the input signal using raised cosine filter.
%       Y = RCOSFLT(X, Fd, Fs) filters the input signal X using raised cosine
%       (R-C) FIR filter. The sample frequency for X is Fd (Hz). The sample
%       frequency for Y is Fs. Fs must be larger than Fd. Fs/Fd must be an
%       integer. The rolloff factor R is a default of .5. The time delay is a
%       default of 3. The extra delay has been taken off from output Y,
%       such that offset Fs/Fd - 1 is the best decision point (such as used
%       in function MODMAP). The row number (or vector length) of Y is Ys/Yd
%       times that of X's.
%
%       Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG) gives specific computation
%       instruction. TYPE_FLAG is a string, which can be one of the following.
%       'fir'    Use FIR R-C filter (default).
%       'iir'    Use IIR R-C filter.
%       'normal' Use normal R-C filter (default), in contrast to 'qart'.
%       'sqrt'   Use square root raised cosine filter.
%       'wdelay' Keep the full length of the filtered result, in which case
%                the row number (or vector length) of Y is 
%                (length_of_X + DELAY)*Fs/Fd. The value DELAY is a default of
%                3. The function default has had the delay cut off from
%                the output.
%       'Fs'     X is input with sample frequency Fs. In this case, only
%                elements X(i*Fs/Fd+1,:) are used in the calculation. All
%                others are discarded.
%       'filter' Means filter is provided in this function call. When 
%                TYPE_FLAG contains 'filter', the calling format is
%                Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG, Delay, NUM).
%                When TYPE_FLAG contains both 'filter' and 'iir', the calling
%                format is Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG, DELAY, NUM, DEN).
%                where NUM and DEN are numerator and denominator of raised
%                cosine filter.  DELAY is the filter time delay is 1/Fd steps.
%                If default DELAY has been used in the raised cosine design,
%                use an empty matrix here. The raised cosine filter can be
%                designed using function RCOSINE.
%       'default' Use all default values.
%       TYPE_FLAG can be a combination of the above string with a '/' as
%       separation. For example, TYPE_FLAG = 'iir/sqrt'.
%
%       Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG, R) gives rolloff factor. In
%       general, it is a real number in range [0, 1].
%
%       Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG, R, DELAY) gives the delay in the
%       measure of 1/Fd time steps. DELAY should be a positive integer.
%       DELAY/Fd will be the time delay in the raised cosine filter design.
%       If the default time delay is used, assign an empty matrix for DELAY.
%
%       Y = RCOSFLT(X, Fd, Fs, TYPE_FLAG, R, DELAY, TOL) provides the
%       tolerance in IIR filter design. The default value is .01.
%
%       [Y, T] = RCOSFLT(...) outputs the time vector.
%
%       See also RCOSINE.

%       Wes Wang 1/19/95, 10/11/95.
%       Copyright (c) 1995-96 by The MathWorks, Inc.
%       $Revision: 1.1 $  $Date: 1996/04/01 18:02:18 $

%default tolerance
if nargin < 7
    tol = .01;
end;

%default delay
if nargin < 6
    Delay = 3;
elseif isempty(Delay)
    Delay = 3;
elseif Delay <= 0
    error('DELAY must be a positive integer in RCOSFLT.')
elseif ceil(Delay) ~= Delay
    error('DELAY in RCOSFLT must be an integer.')
end;

%default rolloff factor
if nargin < 5
    R = .5;
elseif R < 0
    error('The Rolloff factor in RCOSFLT cannot be a negative number.')    
end;

%default type_flag
if nargin < 4
    type_flag = '';
elseif ~isstr(type_flag) & ~isempty(type_flag)
    error('TYPE_FLAG in RCOSFLT must be a string.');
end;

%not enough input varible.
if nargin < 3
    error('Not enough input variable for RCOSFLT.')
end;

%process the inptu variable x
if isempty(x)
    y = [];
    return;
end;
[len_x_o, wid_x_o] = size(x);
if min(len_x_o, wid_x_o) == 1
    x = x(:);
end;
[len_x, wid_x] = size(x);

FsDFd = Fs/Fd;
if ceil(FsDFd) ~= FsDFd
    error('Fs/Fd must be an integer.')
end;
type_flag = lower(type_flag);

%filter type.
if findstr(type_flag, 'sqrt')
    filt_type = 'sqrt';
else
    filt_type = 'normal';
end;

%design the filter.
if findstr(type_flag, 'fir')
    if findstr(type_flag, 'filter')
        if nargin < 5
            error('Not enough input variable, FIR filter has to be assigned.')
        else
            num = R;
        end
    else
        num = rcosfir(R, Delay, FsDFd, 1/Fd, filt_type)
    end;
    den = 1;
else
    if findstr(type_flag, 'filter')
        if nargin < 6
            error('Not enough input variable, IIR filter has to be assigned.')
        else
            num = R;
            den = Delay;
        end
    else
        [num, den] = rcosiir(R, Delay, FsDFd, 1/Fd, tol);
    end;
end;

%make the x to have the sample time Fs
if findstr(type_flag, 'fs')
    xx = zeros(len_x+Delay*FsDFd, wid_x);
    for i = 1 : FsDFd : len_x
        xx(i, :) = x(i, :);
    end;
else
    xx = zeros((len_x+Delay)*FsDFd, wid_x);
    for i = 1 : len_x
        xx((i-1)*FsDFd+1, :) = x(i, :);
    end;
end;

%filtering
for i = 1:wid_x
    xx(:, i) = filter(num, den, xx(:, i));
end;

cut_length_b = (Delay - 1) * FsDFd  + 2;
cut_length_e = size(xx, 1) - (FsDFd - 1);
t = [0:size(xx, 1)]/Fs;
if nargout < 1
    % plot the result in comparing the input digit
    xx = xx(cut_length_b:cut_length_e, :);
    t = t(cut_length_b : cut_length_e);
    if isempty(findstr(type_flag, 'Fs'))
        yy = zeros((len_x)*FsDFd, wid_x);
        for i = 1 : len_x
            if i == 1
                yy((i-1)*FsDFd+1:i*FsDFd, :) = ones(FsDFd, 1) * x(i, :);
            else
                yy((i-1)*FsDFd+1:i*FsDFd, :) = x(i*ones(1,FsDFd), :);
            end;
        end;
        x = yy;
        clear yy
    end;
    if (size(x, 2) == 1) | (size(x, 2) > 16)
        plot(t, [xx x])
    else
        col='ymcrgbw';
        plt = [];
        for i = 1 : size(x, 2)
            if i > 1
                plt = [plt, ',t,[xx(:,', num2str(i), '),x(:,', num2str(i), ')],''', col(rem(i-1,7)+1),''''];
            else
                plt = 't,[xx(:,1), x(:,1)],''y''';
            end;
        end;
        plt = ['plot(', plt, ')'];
        eval(plt);
        ylabel('Same color for original-filted pair')
    end;
    title('Raised cosine filted signal v.s. input signal.')
    xlabel('Time (sec, original signal shifted)')
elseif findstr(type_flag, 'wdelay')
    y = xx;
else
    y = xx(cut_length_b:cut_length_e, :);
    t = t(cut_length_b : cut_length_e);
end;
    
%--end of rcosflt.m--
