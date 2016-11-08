function [Wd,sc,uw,vwt] = HybridWatermarking (HostImage,WatermarkImage,chaos)
    %% PASO 1 & 2: Definición de variables y Leer imagenes
    % Se usan técnicas del dominio de la transformada: DWT, DCT y SVD
    % Filtro Wavelet a usar: 'haar'
    
%     if chaos < 1
%         % Leer la imagen anfitriona
%         C_w = double(imread(HostImage));
% 
%     else
%         % Funcion caotica para la imagen
%         C_w = double(ATM(HostImage,chaos));
%         %W_w = double(ATM(WatermarkImage,chaos));
%     end

    C_w = double(HostImage);
    % Leer la imagen de marca de agua
    %W_w = double(imread(WatermarkImage));
    W_w = double(WatermarkImage);
    
    % Factor de escala
    a = 0.9;
    
    
    %% PASO 3: Realizar DWT sobre la imagen anfitriona y la DCT
    %  sobre la imagen de marca de agua
    
    [LLC,LHC,HLC,HHC] = dwt2(C_w,'haar');
    D = dct2(W_w);
    
    %% PASO 4: Elegir las sub-bandas en la imagen anfitriona y
    % obtener los coeficientes DCT para la misma.
    
    D_c1 = dct2(LLC);
    
    %%  PASO 5: Calcular los valores singulares de
    %   los coeficientes de la DCT para la imagen
    %   anfitriona y la marca de agua
    
    [uc, sc, vct]=svd(D_c1); 
    
    [uw, sw, vwt]=svd(D);
    
    %%  PASO 6: Inserción de la marca de agua
     for i = 0.1 : a
         Wwk = sc + i*sw;
     end

    %%  PASO 7: Calcular los valores singulares para Wwk y obtener
    %   los coeficientes DWT modificados
    
    [uww,sww,vwwt]= svd(Wwk);
    
    %%Coeficientes DWT modificados
    Wmodi = uc * sww * vct';
    
    %% PASO 8: Obtener la imagen con la marca de agua
    
    Widct = idct2(Wmodi);
    
    %   Aplicar la DWT inversa a LLc, LHc, HLc, y HHx con
    %   los coeficientes modificados
    
    Wd = idwt2(Widct,LHC,HLC,HHC,'haar');
    
    %   Revertir el proceso de imagen caotica
    if chaos >= 1
        Wd = iATM(Wd,chaos);
    end
    %sc,uw, vwt funcionarán como llave para la extracción
    
    %Mostrar PSNR
    
end
