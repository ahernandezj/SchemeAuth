function [r1, r2, secret] = VCRG(Imagen)

    %Lectura y binarización de la imagen
    %P = im2bw(imresize(imread(Imagen),0.25),0.4);
    %P = im2bw(imread(Imagen),0.4);
    P = BinSIS(Imagen);
    % Tamaño de las transparencias (shares)
    s = size(P);
    r1 = zeros((s(1)), (s(2)));
    r2 = zeros((s(1)), (s(2)));
    
    
    for i = 1: s(1)
        for j = 1: s(2)
            % Obtenemos los subsegmentos
            
            %Si el pixel es blanco, ambas transparencias serán iguales,
            %de lo contrario se obtendra una transparencia de manera
            %aleatoria
            
            [p1,p2]=CodingPixel(P(i,j));
            
            r1(i,j) = p1;
            r2(i,j) = p2;
            
        end
    end
    figure;imshow(P);title('Imagen Original');
    figure;imshow(r1);title('Share 1');
    figure;imshow(r2);title('Share 2');
    
    secret = bitor(r1, r2);
    secret = ~secret;
    
    figure;imshow(secret);title('Superposicion de Share 1 & 2');
end

function [ r1, r2 ] = CodingPixel(Pixel)
    if Pixel == 1
        if(round(rand(1)) == 0)
            r1 = 1; r2 = 1;
        else
            r1 = 0; r2 = 0;
        end
    elseif Pixel == 0
        if(round(rand(1)) == 0)
            r1 = 1; r2 = 0;
        else
            r1 = 0; r2 = 1;
        end
    end
        
end

function B = BinSIS(Imagen)
    rgb = imread(Imagen);
    I = rgb(:,:,1);
    [H,W]=size(I);
    B = false (H,W);
    
    Umbral = SISThreshold(I);
    
    for i=1:H
        for j=1:W
            if I(i,j) > Umbral
                B(i,j) = true;
            else
                B(i,j) = false;
            end
        end
    end
end

