function params=checkvarsparams(start,continuing,params,n);
%CHECKVARSPARAMS    Initializes GPLAB algorithm parameter variables.
%   CHECKVARSPARAMS(START,CONTINUE,PARAMS,POPSIZE) returns a complete
%   set of valid parameter variables for the GPLAB algorithm, after
%   checking for necessary initializations and eventually request
%   some input from the user.
%
%   Input arguments:
%      START - true if no generations have been run yet (boolean)
%      CONTINUE - true if some generations have been run (boolean)
%      PARAMS - the algorithm running parameters (struct)
%      POPSIZE - the number of individuals in the population (integer)
%   Output arguments:
%      PARAMS - the complete running parameter variables (struct)
%
%   See also CHECKVARSSTATE, CHECKVARSDATA, GPLAB
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

% check parameter variables:

if start
   if isempty(params)
      params=setparams([],'defaults','params');
      if ~strcmp(params.output,'silent')
   		fprintf('\n- Setting algorithm parameters with default initial values.\n');
		end   	
   else
      if ~strcmp(params.output,'silent')
         fprintf('\n- Using algorithm parameters with previously set values.\n');
      end
   end
   
   % manage initial operator probabilities:
   if isempty(params.initialvarprobs)
      params.initialvarprobs=normalize(ones(1,length(params.operatornames)),1);
   end
   if isempty(params.initialfixedprobs)
      params.initialfixedprobs=normalize(ones(1,length(params.operatornames)),1);
   end
   
   % manage min probability of any operator, so that the user doesn't set it too low:
   realminprob=0.01/length(params.operatornames);
   if params.minprob<realminprob
      params.minprob=realminprob;
      fprintf('\n   (increasing parameter ''minprob'' to %f)\n',params.minprob);
   end
   
   % manage what is considered a small difference in operator probabilities,
   % considering the percentage changed in each adaptation:
   if isempty(params.smalldifference)
      % the maximum change of the operator with minimum probability:
      maxchangeofminimum=params.percentchange*params.minprob/length(params.operatornames);
      % lets adopt it:
      params.smalldifference=maxchangeofminimum;
   end
   
   % manage filters for strict/dynamic depth/size:
   f1={};
   f2={};
   if strcmp(params.depthnodes,'1') % depth
      if strcmp(params.fixedlevel,'1')
         f1={'strictdepth'};
      end
      if strcmp(params.dynamiclevel,'1')
         f2={'dyndepth'};
      elseif strcmp(params.dynamiclevel,'2')
         f2={'heavydyndepth'};
      end
   else % nodes
      if strcmp(params.fixedlevel,'1')
         f1={'strictnodes'};
      end
      if strcmp(params.dynamiclevel,'1')
         f2={'dynnodes'};
      elseif strcmp(params.dynamiclevel,'2')
         f2={'heavydynnodes'};
      end
   end
   params.filters={f1{:},f2{:}};
   
   % set depth/size parameters that are still empty:
   if isempty(params.inicmaxlevel)
      if strcmp(params.depthnodes,'1') %depth
         params.inicmaxlevel=6;
      else %nodes
         params.inicmaxlevel=28;
         % for symbolic regression of the quartic polynomial and parity 3 problems,
         % this is the number of nodes that gives an initial distribution of sizes
         % more alike the distribution obtained with depth 6. 28 is where the difference
         % between both problems, in the 't' value of the Kolmogorov-Smirnov, is minimal.
      end
      fprintf('\n   (setting parameter ''inicmaxlevel'' automatically...)\n');
   end
   if ~strcmp(params.dynamiclevel,'0') & isempty(params.inicdynlevel)
      if strcmp(params.depthnodes,'1') %depth
         params.inicdynlevel=6;
      else %nodes
         params.inicdynlevel=28;
      end
      fprintf('\n   (setting parameter ''inicdynlevel'' automatically...)\n');
   end
   if ~strcmp(params.fixedlevel,'0') & isempty(params.realmaxlevel)
      if strcmp(params.depthnodes,'1') %depth
         params.realmaxlevel=17;
      else %nodes
         params.realmaxlevel=512;
         % this does not need to be higher for simple problems like symbolic regression
         % of the quartic polinimial and parity 3. some numbers were retrieved from the
         % runs with depth, like the average nodes, tree fill rate, and absolute maximum
         % number of nodes, for each depth, in both problems. 512 nodes is more than
         % ever needed on a tree with depth 17, because tree fill rate is very low.
      end
      fprintf('\n   (setting parameter ''realmaxlevel'' automatically...)\n');
   end
   
   % make sure inicdynlevel is correct:
   if params.inicdynlevel<1
      % correct possible error:
      params.inicdynlevel=1;
      fprintf('\n   (increasing parameter ''inicdynlevel'' to %d)\n',params.inicdynlevel);
   end
      
   % make sure realmaxlevel is at least as high as inicdynlevel:
   if params.inicdynlevel>params.realmaxlevel
      params.realmaxlevel=params.inicdynlevel;
      fprintf('\n   (increasing parameter ''realmaxlevel'' to %d)\n',params.realmaxlevel);
   end
      
   % make sure inicmaxlevel is at least as low as inicdynlevel:
   if params.inicdynlevel<params.inicmaxlevel
      params.inicmaxlevel=params.inicdynlevel;
      fprintf('\n   (decreasing parameter ''inicmaxlevel'' to %d)\n',params.inicmaxlevel);
   end
      
   % make sure inicmaxlevel is correct:
   if params.inicmaxlevel<1
      % correct possible error:
      params.inicmaxlevel=1;
      fprintf('\n   (increasing parameter ''inicmaxlevel'' to %d)\n',params.inicmaxlevel);
   end
      
   % manage generation gap:
   if isempty(params.gengap)
      params.gengap=n;
   else
      if params.gengap<=0
         % correct possible error:
         params.gengap=n;
         fprintf('\n   (increasing parameter ''gengap'' to %d)\n',params.gengap);
      end
      % if gengap is lower than 1, it represents a proportion of the population:
	   if params.gengap<1
         params.gengap=round(params.gengap*n);
      end
   end
   
   % manage automatic probability setting variables (Davis 89)
	if strcmp(params.operatorprobstype,'variable') | strcmp(params.initialprobstype,'variable')
		if isempty(params.adaptinterval)
      	params.adaptinterval=params.gengap;
      	% (by default, adapt operator probabilities every generation)
         if ~strcmp(params.output,'silent')
            fprintf('\n   (setting parameter ''adaptinterval'' automatically...)\n');
         end
   	end
   	if isempty(params.adaptwindowsize)
      	params.adaptwindowsize=max([params.numbackgen*params.gengap params.numbackgen*n]);
         % (by default, adapt window size includes numbackgen generations of individuals
         %  or numbackgen times the population size, which one is larger)
         if ~strcmp(params.output,'silent')
            fprintf('\n   (setting parameter ''adaptwindowsize'' automatically...)\n');
         end
   	end
	end

	% manage tournament size:
	if (strcmp(params.sampling,'tournament') | strcmp(params.sampling,'lexictour'))
   	if isempty(params.tournamentsize)
      	params.tournamentsize=0.1;
      	% (by default, the tournament size is 10% of the population size)
      	% (if tournamentsize were integer, it would mean absolute numbers)
         if ~strcmp(params.output,'silent')
            fprintf('\n   (setting parameter ''tournamentsize'' automatically...)\n');
         end
      end
      if params.tournamentsize<=0
         % correct possible error:
         params.tournamentsize=0.1;
         fprintf('\n   (increasing parameter ''tournamentsize'' to %d)\n',max(round(params.tournamentsize*n),2));
      end
      % if tournamentsize is lower than 1, it represents a proportion of the population:
      if params.tournamentsize<1
         params.tournamentsize=max(round(params.tournamentsize*n),2);
         % (2 individuals minimum for the tournament)
      end
      % (if tournamentsize==1 the selection for reproduction will be random)
      % (if tournamentsize==popsize only the best individual will produce offspring)
   end

end

if continuing
   if ~strcmp(params.output,'silent')
      fprintf('\n- Using algorithm parameters with previously set values.\n');   
   end
end

% manage directory where to save the algorithm files:
if ~strcmp(params.savetofile,'never') & isempty(params.savedir)
   dirname=input('\nPlease name the directory to store the algorithm files: ','s');
   parentdir=strrep(fwhich(mfilename),strcat(mfilename,'.m'),'');
   status=mkdir(parentdir,dirname);
   switch status
   case 0
      error('CHECKVARSPARAMS: invalid directory name!');
   case 2
      error('CHECKVARSPARAMS: directory already exists!');
   end
   newdir=strcat(parentdir,dirname);
   params.savedir=newdir;
end

% manage "keepevalssize"
if isempty(params.keepevalssize)
	params.keepevalssize=n; % keep only popsize most used individuals
end

% remove 'plotdiversity' from list of plots to draw, in case diversity is not calculated:
if isempty(params.calcdiversity)
   f=find(strcmp(params.graphics,'plotdiversity'));
   if ~isempty(f)
      params.graphics={params.graphics{find(~strcmp(params.graphics,'plotdiversity'))}};
      fprintf('\n   Diversity parameter off: diversity plot will not be drawn.\n');
   end
end

if strcmp(params.output,'verbose')
   fprintf('\n');
   params
   fprintf('\n');
end
