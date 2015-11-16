function tree=str2tree(str)
%This function takes in the string representation of the GPLab individual and outputs
%its tree representation. The old method was old the new method now
%considers the array as a tree and traverses it.
indicesl=findstr(str,'(');
indicesr=findstr(str,')');
indicesc=findstr(str,',');%commas
startposr=1;
startposl=1;
currposr=1;
currposl=1;
tmppos=1;
%tree.kids=[];
tree.op=str(1:indicesl(1)-1);
tree.op
i=1;
if(length(indicesl)>0&&length(indicesr)>0)
while(currposr<=length(indicesr))
    tmp=currposl;
    currposl=length(find(indicesl(startposl:length(indicesl))<indicesr(currposr)));
    currposr=currposl;
    if(tmp==currposl);
        tree.kids{i}=str2tree(str(indicesl(startposl)+1:indicesr(currposr)-1));
        i=i+1;
  %      currposl=currposl+1;
  %      currposr=currposr+1;
        startposl=currposl;
    end
end
else
    a='temp';
    i=1;
    str=str(indicesl+1:indicesr-1);
    while(~strcmp(a,''));
        [a,str]=strtok(str,',');
        if(~strcmp(a,''))
            tree.kids{i}.op=a;
            tree.kids{i}.kids=[];
        end
        i=i+1;
    end
end