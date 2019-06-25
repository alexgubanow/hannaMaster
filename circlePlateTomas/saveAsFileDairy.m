function saveAsFileDairy(Name, var)
flName = sprintf('%sOutput.txt',Name);
delete(flName);
diary(flName);    
diary on ;
var
diary off ;%to avoid print other commands.
% Read txt into cell A
fid = fopen(flName,'r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);
% Change cell A
A{1} = sprintf('%s =',Name);
% Write cell A into txt
fid = fopen(flName, 'w');
for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end
fclose(fid);
end