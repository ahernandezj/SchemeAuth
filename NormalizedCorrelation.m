function NC = NormalizedCorrelation(Wo,Wr)

[X, Y] = size(Wo);
aux1 = double(0); aux2 = double(0);

for i=1:X
	for j=1:Y
		aux1 = aux1 + (Wo(i,j)*Wr(i,j));
		aux2 = aux2 + (Wo(i,j)*Wo(i,j));
	end
end

if aux2 > 0
	NC =aux1/aux2;
else
	NC = 0;
end

end