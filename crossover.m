function newinds=crossover(pop,state,indlist)
%CROSSOVER    Creates new individuals for the GPLAB algorithm by crossover.
%   NEWINDS=CROSSOVER(POPULATION,STATE,PARENTS) returns two new individuals
%   created by swaping subtrees of the two PARENTS at random points.
%
%   Input arguments:
%      POPULATION - the population where the parents are (array)
%      STATE - the current state of the algorithm (struct)
%      PARENTS - the indices of the parents in POPULATION (1x2 matrix)
%   Output arguments:
%      NEWINDS - the two newly created individuals (1x2 matrix)
%
%   See also MUTATION, APPLYOPERATOR
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

i1=indlist(1);
i2=indlist(2);

ind1=pop(i1);
ind2=pop(i2);

if isempty(ind1.nodes)
   ind1.nodes=nodes(ind1.tree);
end
if isempty(ind2.nodes)
   ind2.nodes=nodes(ind2.tree);
end
x1=intrand(1,ind1.nodes); % crosspoint1
x2=intrand(1,ind2.nodes); % crosspoint2

xnode1=findnode(ind1.tree,x1); % node to swap1
xnode2=findnode(ind2.tree,x2); % node to swap2
ind1.tree=swapnode(ind1.tree,x1,xnode2); % substitute crosspoint1 by xnode2
ind2.tree=swapnode(ind2.tree,x2,xnode1); % substitute crosspoint2 by xnode1

ind1.str=tree2str(ind1.tree);
ind1.id=[];
ind1.origin='crossover';
ind1.parents=[pop(i1).id,pop(i2).id];
ind1.xsites=[x1,x2];
ind1.fitness=[];
ind1.result=[];
ind1.testfitness=[];
ind1.level=[];
ind1.nodes=[];
ind1.introns=[];
   
ind2.str=tree2str(ind2.tree);      	
ind2.id=[];
ind2.origin='crossover';
ind2.parents=[pop(i2).id,pop(i1).id];
ind2.xsites=[x2,x1];
ind2.fitness=[];
ind2.result=[];
ind2.testfitness=[];
ind2.level=[];
ind2.nodes=[];
ind2.introns=[];   

newind1=ind1;
newind2=ind2;
newind1.age=0;%Adil. The new individuals have now been created, set their ages to zero.
newind2.age=0;%Adil
newind1.slope=0;%Adil
newind2.slope=0;%Adil

newinds=[newind1,newind2];
