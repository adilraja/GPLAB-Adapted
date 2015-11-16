function [fitness,resultind,gcoeffs,aCoeff]=gabasedfitnessfunction2(ind,params,data,terminals,varsvals)




%str=tree2strappendcoeff(ind);% this line of code is used to get a coefficient-appended string given a GPLab tree
str=appendcoeffs(ind.str);
% This loop is supposed to replace the 'V' letter embedded in the
% coefficient with the integers 1, 2, 3 and so on. This piece of code needs
% a bit of explanation as it is a bit tedious

pos=findstr(str,'V');% pos marks the positions of the 'V' letters in the string expression
numcoeffs=length(pos);% As the number of coefficients in the expression is equal to number of V letter so this line counts the number of coefficients in the expression.
initpos=1;% Start position of the string (all string start at index 1:)).
tmpstr=[];% this is for temporary storage of the values.
for(i=1:numcoeffs)
    str1=strrep(str(initpos:pos(i)),'V',num2str(i)); %this line replaces the letters V with numbers 1, 2, 3 in a progressive fashion.
    tmpstr=strcat(tmpstr,str1);% ok cats the string to tmpstr
    initpos=pos(i)+1;% the position pointer is moved to the next letter after V
end
tmpstr=strcat(tmpstr,str(initpos:length(str)));% The last chunk of str is appended to tmpstr
str=tmpstr;%tmpstr is replaced in str.
% A fitness function has to be created
for t=1:params.numvars
	% for all variables (which are first in input list), ie, X1,X2,X3,...
   var=terminals{t,1};
   val=varsvals{t}; % varsvals was previously prepared to be assigned (in genpop)
   eval([var '=' val ';']);
   % (this eval does assignments like X1=2,X2=4.5,...)
end
gcoeff=ind.slope;
resultind=eval(str);
if length(resultind)<length(data.result)
   resultind=resultind*ones(length(data.result),1);
end
fitness=mean(power(data.result-resultind,2));
fitness=fixdec(fitness,params.precision);
if(isnan(fitness)||isinf(fitness))
    fitness=50000;%Give a very large value to fitness so that the individual is removed:Adil
end