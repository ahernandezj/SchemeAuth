function [image] = iATM(ImgATM,iter)
    [H, W] = size(ImgATM);
    
    image = zeros(H,W);
    M = H - 1;  
    
    for l = 1: iter
        for i = 0: M
            for j = 0: M
                ij = [ 2 -1 ; -1 1 ] * [ j ; i ];
                image(mod(ij(2), H)+1, mod(ij(1), H)+1) = ImgATM(i+1, j+1);
            end
        end
        
        ImgATM=image;
    end
    
    figure; imshow(uint8(image));
end