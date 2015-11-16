function newind=mutation(pop,state,i)
%MUTATION    Creates a new individual for GPLAB by mutation.
%   NEWIND=MUTATION(POPULATION,STATE,PARENT) returns a new individual
%   created by substituting a random subtree of PARENT by a new
%   randomly created tree, with the same depth/size restrictions
%   as the initial random trees.
%
%   Input arguments:
%      POPULATION - the population where the parent is (array)
%      STATE - the current state of the algorithm (struct)
%      PARENT - the index of the parent in POPULATION (integer)
%   Output arguments:
%      NEWIND - the newly created individual (struct)
%
%   See also CROSSOVER, APPLYOPERATOR
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

ind=pop(i);

% calculate number of nodes (we need it to pick a random branch)
if isempty(ind.nodes)
   ind.nodes=nodes(ind.tree);
end
x=intrand(1,ind.nodes); % mutation point

% node to mutate (whole branch from this point downwards):
xnode=findnode(ind.tree,x); 

% build a new branch for this tree, no deeper/bigger than the initial random trees:
% (and obeying the depth/size restrictions imposed by the limits in use)
newtree=maketree(state.iniclevel,state.functions,state.arity,0,state.depthnodes);
% (the maximum size of the new branch is the same as the initial random trees)
% (0 means no exact level)

% now swap old branch with new branch:
ind.tree=swapnode(ind.tree,x,newtree);

ind.id=[];
ind.origin='mutation';
ind.parents=[pop(i).id];
ind.xsites=[x];
ind.str=tree2str(ind.tree);
ind.fitness=[];
ind.result=[];
ind.testfitness=[];
ind.nodes=[];
ind.introns=[];
ind.level=[];
ind.age=0;%Adil. A new individual has been created, set its age to zero
ind.slope=0;%Adil. This is in case if ga is used and slope contains the coeffs
newind=ind;


