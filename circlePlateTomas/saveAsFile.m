function saveAsFile(Name, var)
flName = sprintf('%sOutput.txt',Name);
fileID = fopen(flName,'w');
fprintf(fileID,'%s=\r\n',Name);
fprintf(fileID,'% 5.3g\t',var);
fclose(fileID);
end