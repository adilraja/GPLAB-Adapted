function tree=swapnode(tree,x,node)
%SWAPNODE    Swaps a node by another in a GPLAB algorithm tree.
%   SWAPNODE(TREE,X,NODE) returns the tree resulting from
%   substituting node number X by NODE in TREE. The nodes
%   are numbered depth-first.
%
%   Input arguments:
%      TREE - the tree where to swap nodes (struct)
%      X - the number of the node to substitute (integer)
%      NODE - the node to replace node number X (struct)
%   Output arguments:
%      TREE - the tree resulting from swapping (struct)
%
%   Note:
%      If a tree node may have more than 3 branches,
%      this function will have to be enhanced.
%
%   See also FINDNODE, MAKETREE
%
%   Copyright (C) 2003-2004 Sara Silva (sara@dei.uc.pt)
%   This file is part of the GPLAB Toolbox

if x==1
   tree=node;
else
   nkids=size(tree.kids,2);
   if nkids==1
      tree.kids{1}=swapnode(tree.kids{1},x-1,node);
   elseif nkids==2
      nnodes=nodes(tree.kids{1})+1;
      if x<=nnodes
         tree.kids{1}=swapnode(tree.kids{1},x-1,node);
      else
         tree.kids{2}=swapnode(tree.kids{2},x-nnodes,node);
      end
   elseif nkids==3
      nnodes1=nodes(tree.kids{1})+1;
      nnodes2=nodes(tree.kids{1})+nodes(tree.kids{2})+1;
      if x<=nnodes1
         tree.kids{1}=swapnode(tree.kids{1},x-1,node);
      elseif x>nnodes1 & x<=nnodes2
         tree.kids{2}=swapnode(tree.kids{2},x-nnodes1,node);
      else
         tree.kids{3}=swapnode(tree.kids{3},x-nnodes2,node);
      end
   else
      error('SWAPNODE: tree with more than 3 children!')
   end
end