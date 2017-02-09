function histogram_equalization()
    %read in the JGP and get some attributes
    fileName = 'river.JPG';
    img = imread(fileName);
    imgInfo = imfinfo(fileName);
    
    %define some variable
    L = 2^imgInfo.BitDepth;
    pixelCount = imgInfo.Height * imgInfo.Width;
    
    %count the gray scale for each pixel
    grayScale = zeros(1,L);
    for i = 1:imgInfo.Height
        for j = 1:imgInfo.Width
            grayScale(img(i,j)+1) = grayScale(img(i,j)+1) + 1;
        end
    end
    
    %calculate probability
    prob = zeros(1, L);
    for i = 1:L
        prob(i) = grayScale(i) / pixelCount;
    end
    
    %calculate the distribution
    dist = zeros(1,L);
    sum = 0;
    for i = 1:L
        sum = sum + prob(i);
        dist(i) = sum;
    end
    dist = round(dist * (L-1));
    
    %get the new image
    newImage = img;
    for i = 1:imgInfo.Height
        for j = 1:imgInfo.Width
            newImage(i,j) = dist(img(i,j) + 1); 
        end
    end
   
    %print the 3 image
    subplot(1,3,1);
    imshow(img);
    title('原图');
    subplot(1,3,2);
    imshow(newImage);
    title('自己做的直方图均衡');
    subplot(1,3,3);
    hisImage = histeq(img);
    imshow(hisImage);
    title('histeq的直方图均衡');
    
    imwrite(newImage,'newRiver.jpg');
    imwrite(hisImage,'hisRiver.jpg');
end