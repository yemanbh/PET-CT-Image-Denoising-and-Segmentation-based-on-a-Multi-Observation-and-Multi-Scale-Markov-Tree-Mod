% ========================================================================
%           Medical Sensors Course Project:
%=========================================================================
%       BY: YEMAN BRHANE HAGOS and
%           MINH VU
% =========================================================================

clc;
close all;
clear;
%========================================================================
% Before you run the program add to path the following foldes:
% denoising_BM3D, denoising_WCD, segmentation
addpath(genpath(pwd));

%% ******************** CREATE fIGURE ****************************************


F= figure('Position',[50 35 1130 700],...
   'Name','',...
   'menubar','none','resize','off',...
   'NumberTitle','off');


B=get(F,'Color');
%TITLE
 Title= uicontrol('parent',F,'Style','text','Position',[50 650 1000 50],...
     'string','PET-CT Image Denoising and Segmentation', 'background', B ,...
     'horizontalAlignment','center', 'FontSize',18,'FontWeight','bold');
 
 
%% Panels

% FOR BUTTONS
panel = uipanel('parent',F,'Title','','FontSize',12,...
    'BackgroundColor',B,...
    'units','pixel','Position',[0 0 330 650]);
% FOR AXES
InputImagesPanel= uipanel('parent',F,'Title','','FontSize',12,...
             'BackgroundColor',B,'BorderType','none',...
             'units','pixel','Position',[330,0,400,650]);

         
 %% Button and popup Groups
 color=[ 0.4 0.5 0.7];
 X=50;
 W=250;
 H=30;
 Y=50;
 gap=20;
text1='PET Image';
interpolate='bicubic';
Loadpet=uicontrol('parent',panel,'string','SELECT PET','callback',...
    ['pet_im=Load_image();, subplot(Axes1);'...
    'imshow(pet_im,[]),cla(Axes2), cla(Axes4);'...
    'title(text1);'],'FontSize',14, 'BackgroundColor',color,'Position',[X 590 W/2-2 H]);
text2='CT Image';
LoadICT=uicontrol('parent',panel,'string','SELECT CT','callback',...
    ['ct_im=Load_image();'...
    'subplot(Axes3);'...
    'imshow(ct_im,[]);',...
    'title(text2);'],'BackgroundColor',color,'FontSize',14,'Position',[X+W/2 590 W/2-2 H]);

Tdenoise= uicontrol('parent',F,'Style','text','Position',[X 540 W H],...
     'string','Denoising Method', 'background', B ,...
     'horizontalAlignment','center', 'FontSize',14);

popupdenoise = uicontrol('Style', 'popup','horizontalAlignment','right',...
           'String', {'                  WCD','                  BM3D'},...
           'FontWeight','bold',...
           'FontSize',14,'Position', [X 510 W H+10]);

patternButton=uicontrol('parent',panel,'string','DENOISE','callback',...
    '[image_wavelet , image_contourlet , Pet_image_denoised] = denoise (pet_im,popupdenoise );',...
    'BackgroundColor',color,'FontSize',14, 'HorizontalAlignment','right','Position',[X 470 W H]);


colorButton=uicontrol('parent',panel,'string','REGISTER','callback',...
   [ '[pet_registered , ct_registered] = register( Pet_image_denoised, ct_im );',...
%       'pet_registered= Pet_image_denoised;',...
%       'ct_registered= ct_im;',...
    ],'BackgroundColor',color,'FontSize',14,'Position',[X 390 W H]);

% TMULTI= uicontrol('parent',F,'Style','text','Position',[X 370 W H],...
%      'string','Select Co Segmentation Method', 'background', B ,...
%      'horizontalAlignment','center', 'FontSize',12);

% popupdseg = uicontrol('Style', 'popup','horizontalAlignment','right',...
%            'String', {'                  Fusion','                  Resolution'},...
%            'FontWeight','bold','FontSize',14,'Position', [X 350 W H]);
petTitle='Segmented PET Image';
ctTitle='Segmented CT Image';

%{
'subplot(Axes3);'...
    'imshow(ct_segmented);'...
    'title(ctTitle);'...
    'subplot(Axes4);'...
    'imshow(fused_image);'...
    'title(petTitle);'
%}
% O/p: ct_segmented , pet_segmented,

s=uicontrol('parent',panel,'string','SEGMENT','callback',...
    [
%        ' pet_registered= pet_im;',...
%        'ct_registered= ct_im;',...
%[CTSegmented , PETSegmenmted] =
    ' Segmentation( ct_registered , pet_registered, Axes2, Axes4);'...
    ],'BackgroundColor',color,'FontSize',14,'Position',[X 340 W H]);
T1='Input CT';
T2='Input PET';
T3='Wavelet Denoising';
T4='Contourlet Denoising';
T5='Combined Denoising';
T6='Registered PET';
T7='Registered CT';
% T8='CT Segmented';
% T9='PET Segmented';
% % T10='Fused Image Segmented';
all=uicontrol('parent',panel,'string','VIEW ALL','callback',...
    [
    'figure, subplot(2,1,1), imshow(ct_im, []), title(T1);'...% Inputs
     'subplot(2,1,2), imshow(pet_im, []), title(T2);'...
     'figure;'...% Denoising pet: image_wavelet , image_contourlet , Pet_image_denoised
     'subplot(3,1,1);'...
     'imshow(image_wavelet, []), title(T3);'...
     'subplot(3,1,2), imshow(image_contourlet, []),title(T4) ;'...
    'subplot(3,1, 3), imshow(Pet_image_denoised, []), title(T5);'...
    'figure, subplot(2,1,1) , imshow(pet_registered, []), title(T6);'...% registration
    'subplot(2,1,2) , imshow(ct_registered, []), title(T7);'...
  ],'BackgroundColor',color,'FontSize',14,'Position',[X 240 W H+20]);


%% Help
Background=get(panel,'backgroundColor');
label= uicontrol('parent',panel,'Style','text','Position',[X 160 W H],...
    'string','How to use the software', 'background', [0.5 0.5 0.5],'horizontalAlignment','center', 'FontSize',12); % create a listbox object
h = uicontrol('parent',panel,'Style','text','Position',[X 40 W 120],...
      'min',0,'max',2,'enable','inactive','background', [0.8 0.8 0.9],'horizontalAlignment','left','FontSize',12); % create a listbox object
%str = {['']};
set(h,'string',{'1. Select PET and CT images';'2. Denoise';...
    '3. Register';'4. Segment';'5. View all if you want to see what is happening in side'});
%set(h,'String',str) % display the string



%% *********** AXES TO DISPLAY INPUT *****************

Axes1=axes('parent',InputImagesPanel,'units','pixel','position',[0,320,420,280],'Box','off');
%set(Axes1,'color',Background);
Axes1.Color=Background;
Axes1.XTick=[]; Axes1.YTick=[];

Axes2=axes('parent',InputImagesPanel,'units','pixel','position',[0,5,420,280],'Box','off');
Axes2.Color=Background;
Axes2.XTick=[]; Axes2.YTick=[];
set(Axes1, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])



%% *********** AXES TO DISPLAY OUTPUT *****************
OutputImagesPqnel= uipanel('parent',F,'Title','','FontSize',12,...
             'BackgroundColor',Background,'BorderType','none',...
             'units','pixel','Position',[750,0,400,650]);
Axes3=axes('parent',OutputImagesPqnel,'units','pixel','position',[0,320,420,280],'Box','off');
%set(Axes1,'color',Background);
Axes3.Color=Background;
Axes3.XTick=[]; Axes3.YTick=[];

Axes4=axes('parent',OutputImagesPqnel,'units','pixel','position',[0,5,420,280],'Box','off');
Axes4.Color=Background;
Axes4.XTick=[]; Axes4.YTick=[];

