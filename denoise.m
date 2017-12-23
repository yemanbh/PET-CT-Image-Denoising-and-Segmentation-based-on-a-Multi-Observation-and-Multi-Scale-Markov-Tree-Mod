function [image_wavelet , image_contourlet , combination] = denoise (image_pet,popUp)
% [image_wavelet , image_contourlet , combination] = denoise (image_pet,popUp)
%Input:
%PET Image, it can be also applied on CT images
%It applys Wavelet transform based image denoising: waveletdenoising( I )
%It applys Contourlet transform based image denoising: Contourletdenoising( I )



I = image_pet;
I = double(I);
I = imresize(I, [256 256]);
M=max(I(:));
size(I)
I = I / M;
% 
% figure;
% imshow(I);
% title('orignal');

% Wavelet denoising
image_wavelet = waveletdenoising( I );
% figure;
% imshow(image_wavelet);
% title('wavelet');

% Contourlet denoising
image_contourlet = contourletdenoising( I );
% figure;
% imshow(image_contourlet);
% title('contourlet');

%% BM3D OR WCD
contents = get(popUp,'String'); 
  value = contents{get(popUp,'Value')};
  if strcmp(value , 'BM3D')
% BM3d
sigma = 25;
[~, image_bmd] = BM3D(1, I, sigma);
combination = image_bmd;
% figure, imshow(image_bmd);
% title('bm3d');
  else
% WCD
%[nRow, nColumn] = size(I);
image_wavecon = (image_contourlet + image_wavelet)/2;
% for iRow=1:nRow
%     for iColumn=1:nColumn
%         image_wavecon(iRow,iColumn)=image_contourlet(iRow,iColumn)/2+image_wavelet(iRow,iColumn)/2;
%     end
% end
combination = image_wavecon;
  end

% figure;
% imshow(image_wavecon);
% title('wavecon');
end

