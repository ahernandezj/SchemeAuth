close all; clear; clc;


chaos = 5;

%shares
wm = imread('barbara.bmp');
[s1,s2,s] = VCRG('barbara.bmp');

[s1_2,s2_2,s_2] = VCRG('cameraman.tif');
% Imagen a color
RGB = imread('lena.png');

red = RGB(:,:,1);
green = RGB(:,:,2);
blue = RGB(:,:,3);

%Imagenes originales con caos
Io = ATM(green,chaos);
Wo = ATM(s1_2,chaos);
Wo2 = ATM(s1,chaos);

%Insercion de la marca de agua en el componente verde
[Wd, Sc,uw,vwt] = HybridWatermarking(Io,Wo,chaos);

%Insercion en los componentes restantes
red = SetLsbImage(red,Wo2);
blue =SetLsbImage(blue,Wo2);

%Obtener imagen marcada
wRGB = uint8(size(RGB));
wRGB = cat(3,red,Wd,blue);


figure;
%imshow(RGB);
imshow(Wd);

% PSNR de la imagen original respecto a la marcada
[peaksnr, snr] = psnr(uint8(wRGB), RGB);
fprintf('\n Imagen Marcada');
fprintf('\n El valor de PSNR es %0.4f', peaksnr);
fprintf('\n El valor de SNR es %0.4f \n', snr);


%ATAQUES


%COMPRESION
imwrite(uint8(Wd), 'new.jpg', 'Quality', 5);
noise = imread('new.jpg');

%imwrite(uint8(wRGB),'ImageWatermark.bmp');


% noise = imread('ImageWatermark.bmp');
% noise = noise(:,:,2);

%noise = double(imnoise(wRGB(:,:,2),'gaussian'));
%noise = uint8(imnoise(uint8(Wd),'salt & pepper'));
%noise = medfilt2(uint8(Wd));

figure; imshow(uint8(noise));

% dif = uint8(Wd)-noise;
% figure; imshow(dif);

%Extraccion de la marca de agua
WEW = ExtractWatermark (noise,Sc,uw,vwt,chaos);

secret = bitor(logical(WEW), logical(s2_2));
secret = ~secret;

figure;imshow(secret);title('Superposicion de Share 1 & 2');

c = normxcorr2(s_2,secret);
[peaksnr, snr] = psnr(uint8(s_2), uint8(secret));
fprintf('\n Marca de Agua');
fprintf('\n El valor de PSNR es %0.4f', peaksnr);
fprintf('\n El valor de SNR es %0.4f \n', snr);
fprintf('\n Valor de la Correlacion Normalizada (NC): %0.4f \n', max(c(:)));

% Extraer bit menos significativo de la marca en los otros canales
% % 
% % r = logical(GetLsbImage(r));
% % b = logical(GetLsbImage(b));
% % 
% % r = bitor(r, logical(s2/15));
% % r = ~r;
% % b = bitor(b, logical(s2/15));
% % b = ~b;
% % 
% % figure; imshow(r);
% % figure; imshow(b);
% % 
