function Error=msefitnessforga(coeffs)
%Make the Fitness Function here. The following fitness function has to be
%called by the GA routine. It is designed as per the matlab manual on the
%GA toolbox.
%Input-The array containing the coefficients to be tuned.
%Output: - The mean squared error between the target T and the evolved
%function contained in str.
str1='T-(17.24*(0.5768*(gcoeff(1)*plus(times(gcoeff(2)*adillog10(times(adilsqrt(plus(plus(adilsqrt(gcoeff(3)*X10),gcoeff(4)*X31),times(times(gcoeff(5)*adillog10(gcoeff(6)*X37),adilsqrt(adilsqrt(times(gcoeff(7)*X27,gcoeff(8)*X31)))),gcoeff(9)*sin(gcoeff(10)*X23)))),gcoeff(11)*X31)),adilsqrt(adilsqrt(times(gcoeff(12)*X27,gcoeff(13)*sin(gcoeff(14)*X8))))),gcoeff(15)*adillog(plus(times(times(gcoeff(16)*X31,times(gcoeff(17)*adillog10(gcoeff(18)*X10),plus(gcoeff(19)*X37,gcoeff(20)*X8))),plus(0.15301,gcoeff(21)*X23)),times(adildivide(gcoeff(22)*adillog2(2),2),gcoeff(23)*sin(gcoeff(24)*X23))))))-1.1051)+79.97)';
assignin('base','gcoeff',coeffs);
Error=evalin('base',str1);
%Error= 0.5768*Error-1.1051;
Error=mean(power(Error,2));
