function [fitness,resultind,bCoeff,aCoeff]=mse_adil(ind,params,data,terminals,varsvals)
%REGFITNESS    Measures the fitness of a GPLAB individual.
%   REGFITNESS(INDIVIDUAL,PARAMS,DATA,TERMINALS,VARSVALS) returns
%   the fitness of INDIVIDUAL, measured as the sum of differences
%   between the obtained and expected results, on DATA dataset.
%
%   [FITNESS,RESULT]=REGFITNESS(INDIVIDUAL,PARAMS,DATA,TERMINALS,VARSVALS)
%   also returns the result obtained in each fitness case.
%
%   Input arguments:
%      INDIVIDUAL - the individual whose fitness is to measure (string)
%      PARAMS - the current running parameters (struct)
%      DATA - the dataset on which to measure the fitness (struct)
%      TERMINALS - the variables to set with the input dataset (cell array)
%      VARSVALS - the string of the variables of the fitness cases (string)
%   Output arguments:
%      FITNESS - the fitness of INDIVIDUAL (double)
%      RESULT - the result obtained in each fitness case (array)
%
%   See also CALCFITNESS, ANTFITNESS
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

%for t=1:params.numvars
	% for all variables (which are first in input list), ie, X1,X2,X3,...
 %  var=terminals{t,1};
  % val=varsvals{t}; % varsvals was previously prepared to be assigned (in genpop)
 %  eval([var '=' val ';']);
   
   
   % (this eval does assignments like X1=2,X2=4.5,...)
   %end

% evaluate the individual and measure difference between obtained and expected results:
%res=eval(ind);
res=evalin('base',ind);%this can be used alternative to the above expression and the for loop; when speedy stuff is required :)

% if the individual is just a terminal, res is just a scalar, but we want a vector:
if length(res)<length(data.result)
   res=res*ones(length(data.result),1);
%else
%res2=reshape(res,4,210);
%res=mean(res2);%Adil this and the above line are added deliberately for the sake of P.563 dimensionality test and should removed afterwards.
%res=res';
end
%adil's code goes here
aCoeff=0;
bCoeff=1;
      res = aCoeff+(bCoeff*res);
      diff = data.result-res;
      meandif=mean(power(diff,2));

%sumdif=sum(abs(res-data.result));
resultind=res;
fitness=meandif;
% raw fitness:
%if(var(res)~=0)
%    fitness=1-meandif/var(data.result); %lower fitness means better individual
 %   fitness=meandif;
%else
 %   fitness=;
%end

% now limit fitness precision, to eliminate rounding error problem:
fitness=fixdec(fitness,params.precision);
if(isnan(fitness)||isinf(fitness))
    fitness=50000;%Give a very large value to fitness so that the individual is removed:Adil
end