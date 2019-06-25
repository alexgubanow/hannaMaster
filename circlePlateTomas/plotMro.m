function plotMro(fullCoord, M_Ro, fig_num, needToSaveAsTex)
croppedM_Ro = M_Ro;
j=length(M_Ro);
i=3;
k = 0;
while i < j
    croppedM_Ro(i) = [];
    j=length(croppedM_Ro);
    i=i+3 - k;
    k = k +1;
end
flipedM_Ro = zeros(length(croppedM_Ro),1);
j=length(croppedM_Ro);
for i=1:length(croppedM_Ro)
    flipedM_Ro(i) = croppedM_Ro(j);
    j=j-1;
end
fullM_Ro = [flipedM_Ro;croppedM_Ro(2:end)];
fullCoordH = zeros(length(fullCoord) * 2 - 1, 1);
j = 2;
for i=2:2:length(fullCoordH)
    fullCoordH(i - 1) = fullCoord(j - 1);
    fullCoordH(i) = fullCoord(j - 1) + (fullCoord(j) - fullCoord(j - 1)) / 2;
    j = j + 1;
end
fullCoordH(end) = fullCoord(end);
fullCoordi = 0:1e-1:fullCoordH(end);
fullM_Roi = interp1(fullCoordH,fullM_Ro,fullCoordi,'makima');
figure(fig_num);
hold on;
plot(fullCoordH, fullM_Ro,'ro','DisplayName','M_Ro');
plot(fullCoordi,fullM_Roi,'DisplayName','Modifed Akima intepoly');
xlabel('Coordinates of elements, m') 
ylabel('M_{\rho}') 
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
if needToSaveAsTex
    matlab2tikz('fullM_Ro.tex','showInfo', false);
else

end