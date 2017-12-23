function Image_In=Load_image()
home=pwd;
x= [ home '\dataset'];
cd(x)
[fileName,pathname]= uigetfile('*.dcm*', 'Open Image');
% pathname

if fileName ~= 0 
    cd(pathname);
    Image_In=dicomread(fileName);
    [ m , n , d]= size(Image_In);
    if (d==3)
        Image_In = im2double (Image_In);
        Image_In = rgb2gray (Image_In);
    end

else
    h = msgbox('No Image selected', 'Error','error');
    Image_In=0;

end
cd (home);
%Image_In(1:20,1:20);
 

  
end