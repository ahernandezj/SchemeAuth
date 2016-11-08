close all; clear; clc;

%Imagenes originales
Io = imread('barbara.bmp');
Wo = imread('cameraman.tif');
chaos = 5;

%Insercion de la marca de agua
[Wd, Sc,uw,vwt] = HybridWatermarking('barbara.bmp','cameraman.tif',chaos);

% PSNR de la imagen original respecto a la marcada
[peaksnr, snr] = psnr(uint8(Wd), Io);
fprintf('\n Imagen Marcada');
fprintf('\n El valor de PSNR es %0.4f', peaksnr);
fprintf('\n El valor de SNR es %0.4f \n', snr);

% Correlacion Normalizada
% C = NormalizedCorrelation(double(Io),Wd);
c = normxcorr2(Io,uint8(Wd));
fprintf('\n Valor de la Correlacion Normalizada (NC): %0.4f \n', max(c(:)));
img = Io - uint8(Wd);

%Guardar a archivo
%imwrite(uint8(Wd),'ImageWatermark.bmp');

%Ataques

Wd = double(imnoise(uint8(Wd),'gaussian'));
%Wd = double(imnoise(uint8(Wd),'salt & pepper'));

%Extraccion de la marca de agua
WEW = ExtractWatermark (Wd,Sc,uw,vwt,chaos);

% PSNR de la imagen original respecto a la extraida de la marca
[peaksnr, snr] = psnr(uint8(WEW), Wo);
fprintf('\n Marca de agua extraida');
fprintf('\n El valor de PSNR es %0.4f', peaksnr);
fprintf('\n El valor de SNR es %0.4f \n', snr);


% Correlacion Normalizada
%C = NormalizedCorrelation(double(Wo),WEW);
c = normxcorr2(Wo,uint8(WEW));
fprintf('\n Valor de la Correlacion Normalizada (NC): %0.4f \n', max(c(:)));

%Mostrar 
figure;
imshow(uint8(Wd));
figure;
imshow(uint8(WEW));

