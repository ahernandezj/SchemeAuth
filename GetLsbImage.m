function [imageWm] = GetLsbImage(ImgStego)
    [H, W] = size(ImgStego);
    imageWm = uint8(zeros(H,W));

    for i=1:H
        for j=1:W
            imageWm(i,j) = uint8(bitget(ImgStego(i,j),1));
        end
    end

end