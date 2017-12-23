function [pet_registered , ct_registered] = register( pet_image, ct_image )
% [pet_registered , ct_registered] = register( pet_image, ct_image )
%% Input:  Images to be registered
% 1. Pet image
% 2. CT image
%% outputs: Registered Images CT and PEt images
% First mark atleast 4 points in the images and geometric trasformation will
% be taken place based on the selected control points.
movingPoints=[50,50];
fixedPoints=[50,50];

[pet_points,ct_points] = ...
       cpselect(pet_image,ct_image,...
                movingPoints,fixedPoints,...
                'Wait',true);            
 
matrix_transformation = fitgeotrans(pet_points,ct_points,'projective');
Rortho = imref2d(size(ct_image));
pet_registered = imwarp(pet_image,matrix_transformation,'OutputView',Rortho);
ct_registered = ct_image;
% figure, imshowpair(pet_registered,image_ct,'blend')

% figure, imshow(pet_registered,[]); title('PET registered');
% figure, imshow(ct_image,[]); title('CT registered');

end

