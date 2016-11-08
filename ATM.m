function [ImgATM] = ATM(img,iter)
    
    
    [H, W] = size(img);
    
    I = img;
    
    ImgATM = zeros(H,W);
    M = H - 1;  
    
    for l = 1: iter
        for i = 0: M
            for j = 0: M
                ij = [ 1, 1 ; 1, 2 ] * [ j ; i ];
                ImgATM(mod(ij(2), H)+1, mod(ij(1), H)+1) = I(i+1, j+1);
            end
        end
        
        I=ImgATM;
    end
    
    
    figure; imshow(uint8(ImgATM));
end