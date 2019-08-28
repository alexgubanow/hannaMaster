function plotU(fullCoord, um_mm, fig_num, needToSaveAsTex)
flipedU = zeros(length(um_mm),1);
j=length(um_mm);
for i=1:length(um_mm)
    flipedU(i) = um_mm(j);
    j=j-1;
end
fullU = [flipedU;um_mm(2:end)];
fullCoordi = fullCoord(1):1e-1:fullCoord(end);
fullUi = interp1(fullCoord,fullU,fullCoordi,'makima');
figure(fig_num);
hold on;
plot(fullCoord, fullU,'ro','DisplayName','Uglob');
p = plot(fullCoordi,fullUi);
set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
xlabel('Coordinates of elements, m') 
ylabel('Displacement, mm') 
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
if needToSaveAsTex
    matlab2tikz('fullU.tex','showInfo', false);
else
end