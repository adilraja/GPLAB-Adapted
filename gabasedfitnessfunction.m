function [fitness,resultind,gcoeffs,aCoeff]=gabasedfitnessfunction(ind,params,data,terminals,varsvals)




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
numcoeffs
tmpstr=strcat(tmpstr,str(initpos:length(str)));% The last chunk of str is appended to tmpstr
str=tmpstr;%tmpstr is replaced in str.
% A fitness function has to be created
fid=fopen('msefitnessforga.m','w');
str1='function Error=msefitnessforga(coeffs)';
str2='%Make the Fitness Function here. The following fitness function has to be';
str3='%called by the GA routine. It is designed as per the matlab manual on the';
str4='%GA toolbox.';
str5='%Input-The array containing the coefficients to be tuned.';
str6='%Output: - The mean squared error between the target T and the evolved';
str7='%function contained in str.';
str8=strcat('str1=''T-',str,''';');%T-model (contained in str);
str9='assignin(''base'',''gcoeff'',coeffs);';%for exporting the coefficients to workspace to aid the execution of statement below.
str10='Error=evalin(''base'',str1);';%str1 is evaluated in the workspace. It requires the Target-T- and the X1, X2, X3 .... (independent variables) to be present in the workspace
str11='Error=mean(power(Error,2));';%Taking the square and then mean gives the mean squared error.
%str=strcat(str1,'\n',str2);%'\n',str3,'\n',str4,'\n',str5,'\n',str6,'\n',str7,'\n',str8,'\n',str9,'\n')
fprintf(fid,'%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n',str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11);
fclose(fid);
%Ready for the next phase. Call the ga from now onwards,
options=gaoptimset('PopulationSize',5000,'Generations',100);%population size is to a bit large
[gcoeffs, fitness] = ga(@msefitnessforga, numcoeffs,options);
resultind=ind.result;
%fitness=fixdec(fitness,params.precision);
if(isnan(fitness)||isinf(fitness))
    fitness=50000;%Give a very large value to fitness so that the individual is removed:Adil
end

if(ind.slope~=0)
    assignin('base','gcoeff',ind.slope);%slope parameter would contain the coefficients
    str12=strcat('T-',str);%T-model (contained in str);
    oldfitness=evalin('base',str12);
    oldfitness=mean(power(oldfitness,2));
    if(fitness>oldfitness)
        fitness=oldfitness;
        gcoeffs=ind.slope;
    else
        assignin('base','gcoeff',gcoeffs);
        resultind=evalin('base',str);
    end
end
aCoeff=0;
