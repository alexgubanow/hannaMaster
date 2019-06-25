function fullCoord = getFullCoords(B, coords)
flipedCoord = zeros(length(coords(1:end,3)),1);
flipedCoord(1) = B(end) + coords(end,3);
j=length(B) - 1;
for i=2:length(coords(1:end,3))
    flipedCoord(i) = B(j) + flipedCoord(i - 1);
    j=j-1;
end
fullCoord = [0;coords(1:end,3);flipedCoord];
end