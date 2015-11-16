function [acoeff, bcoeff]=linearScaling2(evolved,target)
i=0;
if length(evolved) ~= length(target)
     printf('No of Target Values is not the same as Evolved Values');
     printf('Exiting .... ');
     exit(0);
 end
 
 meanTarget = mean(target);
 meanEvolved = mean(evolved);
 
 b = 1; a=0; numerator=0;denominator=0;
 
      factor = evolved-meanEvolved;
     numerator= sum((target-meanTarget).*factor);
     denominator =sum(power(factor,2));
     bcoeff=1;
 if denominator~=0     bcoeff=numerator/denominator;
   elseif  (meanEvolved == 0)  bcoeff = 1;
   else bcoeff = meanTarget / meanEvolved;
 end
 acoeff=meanTarget - bcoeff*meanEvolved; 