function junky();

fid=fopen('msefitnessforga.m','w');
str1='function Error=msefitnessforga(coeffs)';
str2='%Make the Fitness Function here. The following fitness function has to be';
str3='%called by the GA routine. It is designed as per the matlab manual on the';
str4='%GA toolbox.';
str5='%Input-The array containing the coefficients to be tuned.';
str6='%Output: - The mean squared error between the target T and the evolved';
str7='%function contained in str.';
str8='global gacoeffs;';
str9='gacoeffs=coeffs;%the gacoeffs are appended to str';
%str1=strcat('T-',str);%T-model (contained in str);
%fprintf=(fid,'%s','Error=evalin(base,str1);%str1 is evaluated in the workspace. It requires the Target-T- and the X1, X2, X3 .... (independent variables) to be present in the workspace
%Error=power(Error,2);%Taking the square gives the mean squared error.
%str=strcat(str1,'\n',str2);%'\n',str3,'\n',str4,'\n',str5,'\n',str6,'\n',str7,'\n',str8,'\n',str9,'\n')
fprintf(1,'%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n',str1,str2,str3,str4,str5,str6,str7,str8,str9)
fclose(fid);

