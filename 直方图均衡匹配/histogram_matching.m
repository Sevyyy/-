function histogram_matching()
    file1 = 'EightAM.png';
    file2 = 'LENA.png';

    img1 = imread(file1);
    img2 = imread(file2);
    imgInfo1 = imfinfo(file1);
    imgInfo2 = imfinfo(file2);
    
    %define some variable
    L = 2^imgInfo1.BitDepth;
    pixelCount1 = imgInfo1.Height * imgInfo1.Width;
    pixelCount2 = imgInfo2.Height * imgInfo2.Width;
    
    %count the gray scale for each pixel
    grayScale1 = zeros(1,L);
    for i = 1:imgInfo1.Height
        for j = 1:imgInfo1.Width
            grayScale1(img1(i,j)+1) = grayScale1(img1(i,j)+1) + 1;
        end
    end
    
    grayScale2 = zeros(1,L);
    for i = 1:imgInfo2.Height
        for j = 1:imgInfo2.Width
            grayScale2(img2(i,j)+1) = grayScale2(img2(i,j)+1) + 1;
        end
    end
    
    %calculate probability function
    prob1 = zeros(1, L);
    for i = 1:L
        prob1(i) = grayScale1(i) / pixelCount1;
    end
    
    prob2 = zeros(1, L);
    for i = 1:L
        prob2(i) = grayScale2(i) / pixelCount2;
    end
    
    %calculate the distribution function
    dist1 = zeros(1,L);
    sum = 0;
    for i = 1:L
        sum = sum + prob1(i);
        dist1(i) = sum;
    end
    dist1 = round(dist1 * (L-1));
    
    dist2 = zeros(1,L);
    sum = 0;
    for i = 1:L
        sum = sum + prob2(i);
        dist2(i) = sum;
    end
    dist2 = round(dist2 * (L-1));
    
    %find the new dist
    s = zeros(1,L);
    for i = 1:L
        temp = abs(dist2 - dist1(i));
        [x, y] = min(temp);
        dist1(i) = y;
    end
    
    %make up the new image
    newImage = img1;
    for i = 1:imgInfo1.Height
        for j = 1:imgInfo1.Width
            newImage(i,j) = dist1(img1(i,j) + 1);
        end
    end
    
    %calculate the new prob function
    newGrayScale = zeros(1,L);
    for i = 1:imgInfo1.Height
        for j = 1:imgInfo1.Width
            newGrayScale(newImage(i,j)+1) = newGrayScale(newImage(i,j)+1) + 1;
        end
    end
    
    newProb = zeros(1, L);
    for i = 1:L
        newProb(i) = newGrayScale(i) / pixelCount1;
    end
    
    %figure out
    subplot(2,3,1);
    imshow(img1);
    title('原图');
    subplot(2,3,2);
    imshow(img2);
    title('女神Lena');
    subplot(2,3,3);
    imshow(newImage);
    title('直方图匹配后的结果');
    subplot(2,3,4);
    bar(prob1);
    subplot(2,3,5);
    bar(prob2);
    subplot(2,3,6);
    bar(newProb);
    
    imwrite(newImage,'newEightAM.png');
    
end