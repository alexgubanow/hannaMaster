function saveMatrixAsFile(Name, var)
varSize = size(var);
flName = sprintf('%sOutput.txt',Name);
fileID = fopen(flName,'w');
fprintf(fileID,'%s=\r\n',Name);
maxColumns = 8;
columnCounter = varSize(2);
if columnCounter > maxColumns
    stillLeft = columnCounter;
    frstC = 1;
    lstC = maxColumns;
    while stillLeft > 0
            fprintf(fileID,'Columns from %d to %d\r\n', frstC, lstC);
            for i = 1:varSize(1)
                for j = frstC:lstC
                    fprintf(fileID,'%8.3g\t',var(i,j));
                end
                fprintf(fileID,'\r\n');
            end
        
        frstC = frstC + lstC;
        lstC = lstC + maxColumns;
        stillLeft = stillLeft - maxColumns;        
        if stillLeft < maxColumns && stillLeft > 0
            frstC = frstC - (lstC - maxColumns) + maxColumns;
            lstC = frstC - 1 + stillLeft;
            fprintf(fileID,'Columns from %d to %d\r\n', frstC, lstC);
            for i = 1:varSize(1)
                for j = frstC:lstC
                    fprintf(fileID,'%8.3g\t',var(i,j));
                end
                fprintf(fileID,'\r\n');
            end
            stillLeft = -1; 
        end  
    end
else   
    fprintf(fileID,'Columns from 1 to %d\r\n', columnCounter); 
    for i = 1:varSize(1)
        for j = 1:columnCounter
            fprintf(fileID,'%7.3g\t',var(i,j));
        end
        fprintf(fileID,'\r\n');
    end 
end
fclose(fileID);
end