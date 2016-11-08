function [ImgATM] = ATMv(image,iter)
    
    [H, W] = size(image);
    
    ImgATM = zeros(H,W);
    M = H - 1;  
    
    for l = 1: iter
        for i = 0: M
            for j = 0: M
                ij = [ 1, 1 ; 1, 2 ] * [ j ; i ];
                ImgATM(mod(ij(2), H)+1, mod(ij(1), H)+1) = image(i+1, j+1);
            end
        end
        
        image=ImgATM;
    end
    
    figure; imshow(uint8(ImgATM));
end