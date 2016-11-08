function WEW = ExtractWatermark (Wd,Sc,Uw,Vw,chaos)
    %%  PASO 1: Declaración de variables
    
    % Factor de escala
    a = 0.9;
    
    if chaos >=1
        Wd = ATMv(Wd,chaos);
    end
    
    %%  PASO 2: Realizar la DWT sobre la imagen con la marca de agua (posiblemente distorsionada)
    [LLC,LHC,HLC,HHC] = dwt2(Wd,'haar');
    %%  PASO 3: Obtener los coeficientes de la DCT para HHC_c
    Dw = dct2(LLC);
    
    %%  PASO 4: Calcular los valores singulares para Dw
    [Uw0,Sw0,Vw0] = svd(Dw);
    
    %%  PASO 5: Realizar y aplicar operación SVD
    for i = 0.1 : a
        Sk = (Sw0-Sc)/i;
    end
    [Uw1,Sw1,Vw1] = svd(Sk);
    
    
    %%  PASO 6: Calcular los coeficientes DWT modificados
    Icc = Uw*Sw1*Vw';
    
    %%  PASO 7: Extraer la marca de agua
    WEW = idct2(Icc);
    
    
end