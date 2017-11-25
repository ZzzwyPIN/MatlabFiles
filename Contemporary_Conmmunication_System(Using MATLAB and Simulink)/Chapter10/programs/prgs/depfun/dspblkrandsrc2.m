function varargout = dspblkrandsrc2(action)
% DSPBLKRANDSRC2 DSP Blockset Random Source Generator block helper function.

% Copyright 1995-2001 The MathWorks, Inc. 
% $Revision: 1.3 $ $Date: 2001/04/05 15:48:32 $

blk = gcbh;

if nargin==0, action = 'dynamic'; end

RepMode = get_param(blk,'RepMode');

switch action
 case 'icon'
  % Plotting of icon:
  
  % Random data:
  x = (0:.1:.9)';
  y = [0.5645
       0.3024
       0.7520
       0.4752
       0.1684
       0.5462
       0.5798
       0.3904
       0.8463
       0.1681];
  
  % Axes:
  x=[x;NaN;0; 0;NaN;0;1];
  y=[y;NaN;1;-1;NaN;0;0];
  
  varargout(1:2) = {x,y};
 
 case 'seed'
  % Compute (if necessary) seed value
  
  % There is a structure in Random Source's UserData parameter
  % that has two fields, Seed and SeedFlag.  They are used as:
  % Seed:
  %       This is (a string representation) of the seed value
  %       that is actually passed into the S-fcn.  This value
  %       is only equal to the seed in the dialog if the 
  %       repeatabilit mode is 'Specify seed'.  Its default
  %       value is '-1'.
  % SeedFlag: 
  %       This flag can have three values: (1) 'SaveSeed' if 
  %       the repeatability mode is 'Repeatable' and a seed
  %       has already been calculated, (2) 'DoNotSaveSeed' if
  %       the repeatability mode is 'Specify seed' or 'Not
  %       repeatable' (and thus the seed field in the user 
  %       data is not the 'official' seed - it's either truly
  %       not saved, or in the dialog seed) and (3) 'Unset'
  %       for either a new block or an old block that was
  %       saved before this functionality change.  The
  %       default value is 'Unset'
  
  ud = get_param(blk,'userdata');
  ud_old = ud;
  
  % Currently, if UserData = [] and UserDataPersistent = 'off', 
  % then this is an old block -  that is, one that was saved 
  % before this functionality change.
  % It seems that for now the userdata is NOT copied into old
  % blocks from the library block.  Assuming this doesn't
  % change, detecting an 'old block' is trivial - just check
  % either field
  %
  % If it DOES change, then the following logic will be needed
  % to detect old blocks:
  % Change the default value of Seed in the library model file to
  % '-1', and use the logic below:
  % if (strcmp(ud.SeedFlag, 'Unset'))
  %   if (strcmp(get_param(blk,'Seed'),'-1'))
  %     % This is the library block
  %     ud.Seed = '1';
  %     ud.SeedFlag = 'DoNotSaveSeed'; 
  %     set_param(blk,'Seed','1');
  %   else
  %     % This is an 'old' block
  %     ud.Seed = get_param(blk,'Seed');
  %     ud.SeedFlag = 'DoNotSaveSeed'; 
  %     set_param(blk,'RepMode','Specify seed');
  %   end
  % end
  %
  % Existing R12 models need this block of code to work properly
  % for R12.1 and possible future releases
  %

  if isempty(ud),
    % This is an old block (before R12.1)
    ud.Seed = get_param(blk,'Seed');
    ud.SeedFlag = 'DoNotSaveSeed';
    
    % Need to reset the RepMode
    % (note: this is intentially done
    %  and without the user necessarily
    %  being aware of it...)
    % Note: using dspsafe_set_param below
    % because sometimes the set_param fails
    % and we don't want this function to 
    % end here (some tests will fail when
    % they shouldn't)
    dspsafe_set_param(blk,'RepMode','Specify seed');
  else
    % This is a new block (R12.1 or later)
    
    % Create an initial random seed when necessary
    % return current seed otherwise
    
    if (strcmp(RepMode,'Specify seed'))
      % Use seed specified by user
      ud.Seed = get_param(blk,'Seed');
      ud.SeedFlag = 'DoNotSaveSeed'; 
    
    elseif (strcmp(RepMode,'Repeatable'))
      % Only need to change seed if this is a change in mode
      % That is, if we were already in Repeatable mode,
      % do not recalculate seed.  
      if strcmp(ud.SeedFlag,'DoNotSaveSeed'),
        % Just changed to Repeatable mode
        seedVal = floor(rand(1)*100000);
        ud.Seed = num2str(seedVal);
        ud.SeedFlag = 'SaveSeed';
      end
    
    else 
      % Not repeatable: recalculate seed
      seedVal = floor(rand(1)*100000);
      ud.Seed = num2str(seedVal);
      ud.SeedFlag = 'DoNotSaveSeed';
    end
  end
  
  % update the user data if it changed
  if ~isequal(ud,ud_old),
    % Using dspsafe_set_param for same reasons as
    % above
    dspsafe_set_param(blk,'userdata',ud);
  end
  
  % set the return arg to the seed value
  varargout = {ud.Seed};
  
 case 'dynamic'
  % Adjust mask enables
  SrcType = get_param(blk,'SrcType');
  InheritMode = strcmp(get_param(blk,'Inherit'),'on');
  SampMode = get_param(blk,'SampMode');
  enables = get_param(blk,'maskenables');
  oldenables=enables;
  
  % Check for distribution change
  if strcmp(SrcType,'Gaussian')
    enables(4:5) = {'on'};
    enables(2:3) = {'off'};
    enables(6)   = {'on'};
  else
    enables(4:5) = {'off'};
    enables(2:3) = {'on'};
    enables(6)   = {'on'};	
  end
  
  % Check for repeatability mode change
  if strcmp(RepMode,'Specify seed')
    enables(7) = {'on'};
  else
    enables(7) = {'off'};
  end
  
  % Check for inherit mode change
  if InheritMode,
    enables(9:12)  = {'off'};
  elseif (~InheritMode & strcmp(SampMode,'Discrete'))
    enables(9:12)  = {'on'};
  elseif (~InheritMode & strcmp(SampMode,'Continuous'))
    enables(9)    = {'on'};
    enables(10:11) = {'off'};
    enables(12)   = {'on'};
  end

  % Only reset the enables if they have changed
  if (~isequal(enables,oldenables))
    set_param(blk,'maskenables',enables);
  end
  
 otherwise
  error('dspblkrandsrc2: unhandled action'); 
end

% [EOF] dspblkrandsrc2.m