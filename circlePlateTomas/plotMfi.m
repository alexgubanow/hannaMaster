function plotMfi(fullCoord, M_fi, fig_num, needToSaveAsTex)
croppedM_fi = M_fi;
j=length(M_fi);
i=3;
k = 0;
while i < j
    croppedM_fi(i) = [];
    j=length(croppedM_fi);
    i=i+3 - k;
    k = k +1;
end
flipedM_Ro = zeros(length(croppedM_fi),1);
j=length(croppedM_fi);
for i=1:length(croppedM_fi)
    flipedM_Ro(i) = croppedM_fi(j);
    j=j-1;
end
fullM_fi= [flipedM_Ro;croppedM_fi(2:end)];
fullCoordH = zeros(length(fullCoord) * 2 - 1, 1);
j = 2;
for i=2:2:length(fullCoordH)
    fullCoordH(i - 1) = fullCoord(j - 1);
    fullCoordH(i) = fullCoord(j - 1) + (fullCoord(j) - fullCoord(j - 1)) / 2;
    j = j + 1;
end
fullCoordH(end) = fullCoord(end);
fullCoordi = 0:1e-1:fullCoordH(end);
fullM_Roi = interp1(fullCoordH,fullM_fi,fullCoordi,'makima');
figure(fig_num);
hold on;
plot(fullCoordH, fullM_fi,'ro','DisplayName','M_fi');
plot(fullCoordi,fullM_Roi,'DisplayName','Modifed Akima intepoly');
xlabel('Coordinates of elements, m') 
ylabel('M_{\phi}') 
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
if needToSaveAsTex
    matlab2tikz('fullM_fi.tex','showInfo', false);
else

end