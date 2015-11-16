function str=tree2strappendcoeff(tree)

if(~strcmp(tree.op,'minus') && ~strcmp(tree.op,'plus'))
    str=strcat('gcoeff(V)*',tree.op);
else
    str=tree.op;
end
args=[];
for k=1:length(tree.kids)
   args{k}=tree2strappendcoeff(tree.kids{k});
end
if ~isempty(args)
	str=strcat(str,'(',implode(args,','),')');
end