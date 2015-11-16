function tmpstate=mymat2str(params,tmpstate,data)
for t=1:params.numvars
		% for all variables (which are first in list of inputs), ie, X1,X2,X3,...
   	tmpstate.varsvals{t}=mat2str(data.test.example(:,t));
end