function  Segmentation( ct_image_original ,pet_image_original, Axes2, Axes4 )
% [ ct_segmented, pet_segmented] =
% this is main segmentation function that accepts PET and CT images and
% axes to display th result
% It applys HMM to segment both images and displays the result in GUI
% provided


        ct_image = ct_image_original;
        ct_image = double(ct_image);
        ct_image = imresize(ct_image, [256 256]);
        ct_image = ct_image / max(max(ct_image));

        I=ct_image;
        Y=I;
        Z = edge(Y,'canny',0.75);


        pet_image = pet_image_original;
        pet_image = double(pet_image);
        pet_image = imresize(pet_image, [256 256]);
        pet_image = pet_image / max(max(pet_image));

        Y=pet_image;

	k=2;
	EM_iter=10; % max num of iterations
	MAP_iter=10; % max num of iterations


	[X, mu, sigma]=image_kmeans(Y,k);
	% imwrite(uint8(X*120),'initial labels.png');
	initial_labels=X;

	[X, mu, sigma]=HMRF_EM(X,Y,Z,mu,sigma,k,EM_iter,MAP_iter);
	% imwrite(uint8(X*120),'final labels.png');
	final_labels=X;
	% [ct_segmented , pet_segmented] = 

plotandsave(initial_labels,...
            final_labels,ct_image,pet_image, Axes2, Axes4);

%XFUS = PETCTFusion( pet_image_original, ct_image_original , Axes4 );

% 
% 
% XFUS = wfusimg(pet_image,ct_image,'sym4',8,'max','max');
%  subplot(Axes4), imshow(XFUS,[]), title('Fused image')
%  fused_Im=XFUS;
% 
%          ct_image = XFUS;
%         ct_image = double(ct_image);
%         ct_image = imresize(ct_image, [256 256]);
%         ct_image = ct_image / max(max(ct_image));
% 
%         I=ct_image;
%         Y=I;
%         Z = edge(Y,'canny',0.75);
% 
% 
%         %             pet_image = pet_image_original;
%         %             pet_image = double(pet_image);
%         %             pet_image = imresize(pet_image, [256 256]);
%         %             pet_image = pet_image / max(max(pet_image));
%         % 
%         %             Y=pet_image;
% 
%         k=2;
%         EM_iter=10; % max num of iterations
%         MAP_iter=10; % max num of iterations
% 
% 
%         [X, mu, sigma]=image_kmeans(Y,k);
%         % imwrite(uint8(X*120),'initial labels.png');
%         initial_labels=X;
% 
%         [X, mu, sigma]=HMRF_EM(X,Y,Z,mu,sigma,k,EM_iter,MAP_iter);
%         % imwrite(uint8(X*120),'final labels.png');
%         final_labels=X;
% 
% 
%         %% Segmenting fussed image
% 
%         initial=initial_labels;
%             final=final_labels;
%             initial = imcomplement(initial);
%             final = imcomplement(final);
% 
% 
%             SE=[1 0 1;
%                0 1 0;
%                1 0 1];
% 
%             IM1 = initial;
%             IM1 = imdilate(IM1,SE);
%             IM1 = IM1-initial;
% 
%         %     figure;
%         %     imshow(IM1);
% 
%             T=ones(20);
%             IM2 = final;
%             IM21 = imopen(IM2,T);
%             IM2 = imdilate(IM21,SE);
%             IM2 = IM2-IM21;    
% 
%         %     figure;
%         %     imshow(IM2); 
% 
% 
%             [I1,J1]=find(IM1==1);
%             [I2,J2]=find(IM2==1);
%            %{ 
%             figure;
%             imshow(ct_image,[]); title('CT');
%             hold on;
%             %}
%             n1=size(I1);
%             for i=1:n1
%                 hold on
%                 plot(J1(i),I1(i),'r.');
%             end
%             n2=size(I2);
%             for i=1:n2
%                 hold on
%                 plot(J2(i),I2(i),'b.');
%             end
% 
%             saveas(gca,'fused.png');
%              fused_Im = imread('ct_segmented.png');
end