function fullCoord = getFullCoords(coords)
flipedCoord = zeros(length(coords(1:end,3)),1);
%flipedCoord(1) = B(end) + coords(end,3);
j=length(coords);
for i=1:length(flipedCoord)
    flipedCoord(i) = 0 - coords(j);
    j=j-1;
end
fullCoord = [0;coords(1:end,3);flipedCoord];
end