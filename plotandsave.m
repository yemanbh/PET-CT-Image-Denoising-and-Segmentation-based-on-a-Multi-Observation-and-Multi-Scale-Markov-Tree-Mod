function plotandsave(initial_labels,final_labels,ct_image,pet_image, Axes2, Axes4)
    [nRow,nColumn]=size(initial_labels);
   % This function applyies morphological operarion on the segneted image
    % to clean the labeled images and 
    % draws the corresponding contour of the detected tumor
    
    
    %  [ct_segmented , pet_segmented] 
    initial=initial_labels;
    final=final_labels;
%     initial = imcomplement(initial);
%     final = imcomplement(final);
   
    for iRow=1:nRow
        for iColumn=1:nColumn
            if initial(iRow,iColumn)==1
                initial(iRow,iColumn)=0;
            else
                initial(iRow,iColumn)=1;
            end
            if final(iRow,iColumn)==1
                final(iRow,iColumn)=0;
            else
                final(iRow,iColumn)=1;
            end
        end
    end
 
%     figure;
%     imshow(initial);
%     figure;
%     imshow(final);
    
    SE=[1 0 1;
       0 1 0;
       1 0 1];
   
    IM1 = initial;
    IM1 = imdilate(IM1,SE);
    IM1 = IM1-initial;
    
%     figure;
%     imshow(IM1);

    T=ones(10,10);
    IM2 = final;
    IM21 = imopen(IM2,T);
    IM2 = imdilate(IM21,SE);
    IM2 = IM2-IM21;    

%     figure;
%     imshow(IM2); 
    
    
    [I1,J1]=find(IM1==1);
    [I2,J2]=find(IM2==1);
   %{ 
    figure;
    imshow(ct_image,[]); title('CT');
    hold on;
    %}
    axes(Axes4), imshow(ct_image,[]), title('Segmented CT')
    n1=size(I1);
    for i=1:n1
        hold on
        plot(J1(i),I1(i),'r.');
    end
    n2=size(I2);
    for i=1:n2
        hold on
        plot(J2(i),I2(i),'b.');
    end
    
%     saveas(gca,'ct_segmented.png');
%     ct_segmented = imread('ct_segmented.png');
  axes(Axes2), imshow(pet_image,[]), title('Segmented PET')
%     imshow(pet_image,[]); title('PET');
    hold on;
    n1=size(I1);
    for i=1:n1
        hold on
        plot(J1(i),I1(i),'r.');
    end
    n2=size(I2);
    for i=1:n2
        hold on
        plot(J2(i),I2(i),'b.');
    end
%     
%     saveas(gca,'pet_segmented.png');
%     pet_segmented = imread('pet_segmented.png');
end

