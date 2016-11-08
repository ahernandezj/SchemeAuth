function [ImgStego] = SetLsbImage(image,wm)
%   image: imagen anfitriona que contendrá la marca de agua
%   wm: imagen binaria a insertar en la imagen anfitriona
%   > ImgStego: Imagen con la marca de agua


[H, W] = size(image);
ImgStego = uint8(zeros(H,W));

for i=1:H
    for j=1:W
        % Se modificará el bit menos significativo (en este caso el 1) para
        % poder insertar el bit correspondiente a la marca de agua
        ImgStego(i,j)= uint8(bitset(image(i,j),1,wm(i,j)));
    end
end

end