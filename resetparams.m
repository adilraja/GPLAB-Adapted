function params=resetparams;
%RESETPARAMS    Resets the parameter variables for the GPLAB algorithm.
%   RESETPARAMS sets all the GPLAB algorithm parameter variables with the
%   default values.
%
%   Output arguments:
%      PARAMS - the set of default parameter variables (struct)
%
%   See also SETPARAMS, RESETSTATE
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

params=setparams([],'defaults');
params.initialprobstype='fixed';
%params.calcfitness='gabasedfitnessfunction';
params.calcfitness='computeError';
%params.calcfitness2='gabasedfitnessfunction2';
%params.calcfitness2='rsquareFitness2';
params.calcfitness2='computeError2';
params.slope=0;
params.intercept=0;
params.lowerisbetter=1;
%params.datafilex='p563-reduced-input-params-cond-n-exp-wise.txt';
%params.datafiley='Subj-MOS-1328-cond-wise-sorted.txt';
%params.datafilex='Ie-training-data-X.txt';
params.datafilex='Ie-train-dataX-JEmodel-rev1-sept07.txt';
%params.datafiley='Ie-training-data-Y.txt';
params.datafiley='Ie-train-dataY-JEmodel-rev1-sept07.txt';
params.usetestdata=1;
params.testdatafilex='Ie-test-dataX-JEmodel-rev1-sept07.txt';
params.testdatafiley='Ie-test-dataY-JEmodel-rev1-sept07.txt';
params.graphics=[];
params.survival='halfelitism';
params=setterminals(params,'rand','10','9','8','7','5','3','2');
%params.functions='{''plus'' 2; ''minus'' 2; ''times'' 2; ''sin'' 1; ''cos'' 1; ''adillog'' 1; ''adilpower'' 2; ''adildivide'' 2; ''adilsqrt'' 1,; ''adillog2'' 1,; ''adillog10'' 1}';
params.tournamentsize=2;
params.iniclevel=6;
params.realmaxlevel=7;
params.sampling='lexictour_adil';
