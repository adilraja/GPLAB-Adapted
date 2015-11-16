
function [myvars, mybs]=startgpinloop()

myvars=[];
mybs=[];
for i=1:50
fid=fopen('counts.txt','w');
fprintf(fid,'%d',i);
fclose(fid);
params=resetparams;
[vars, b]=gplab(50,300,params);
%myvars=[myvars vars];
mybs=[mybs b];

end
save Evolved_Ie_depth_7_JEmodel-rev1-sept07 mybs vars;