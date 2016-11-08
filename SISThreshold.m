function umbral = SISThreshold (I)

[H,W]=size(I);

H = H-1;
W = W-1;

weight = 0; weightTotal = 0; total = 0;

for i=2:H
	for j=2:W
		ei = abs(int32(I(i+1, j)) - int32(I(i-1,j)));
		ej = abs(int32(I(i, j+1)) - int32(I(i,j-1)));
		
		if (ei > ej)
			weight = ei;
		else
			weight = ej;
		end
		
		weightTotal = weightTotal + weight;
		total = total + (weight * int32(I(i,j)));
	end
end

umbral = 0;
if weightTotal > 0
	umbral = double(total/weightTotal);
end


