function str =appendcoeffs(str)
%here u go with yet another crazy function.
%This function appends coefficients to a GPLab string. Coeff(V) is appended
%and the string is ultimately returned.
%Input-GPLab string individual
%Output:- Coefficient appended string
%
a=findstr(str,'sin');
b=findstr(str,'coz');
c=findstr(str,'adillog');
%d=findstr(str,'times');
%e=findstr(str,'divide');
f=findstr(str,'X');

indices=sort([a b c f]);
indices=[indices length(str)+1];
i=1;
startpos=1;
while(i<=length(indices))
    tmpstr{i}=str(startpos:indices(i)-1);
    startpos=indices(i);
    i=i+1;
end
str=[];
for(i=1:length(indices))
    if(~isempty(tmpstr{i}))
        str=strcat(str,'gcoeff(V)*');
    end
    str=strcat(str,tmpstr{i});
end

% Muhammad Adil Raja November 2006. University of Limerick Ireland.