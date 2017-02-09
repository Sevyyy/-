%read in the image sport car and get some attribute
file_name = 'sport car.pgm';
img = imread(file_name);
img_info = imfinfo(file_name);
x = img_info.Height;
y = img_info.Width;

%form the random matrix t1 and t2,set t1(x,y)~=t2(x,y)
t1 = round(rand(x,y) * 255);
t2 = round(rand(x,y) * 255);
for i = 1:x
    for j = 1:y
        if t1(i,j) == t2(i,j)
            t1(i,j) = mod((t1(i,j) + 1),256);
        end
    end
end

%make the pepper img
pepper_img = img;
for i = 1:x
    for j = 1:y
        if img(i,j) > max(t1(i,j),t2(i,j));
            pepper_img(i,j) = 255;
        elseif img(i,j) < min(t1(i,j),t2(i,j));
            pepper_img(i,j) = 0;
        else 
            pepper_img(i,j) = pepper_img(i,j);
        end
    end
end

%fill out the img with the window size = 3*3
fill1 = zeros(1,y);
fill2 = zeros(x+2,1);
pepper_img = [fill1;pepper_img;fill1];
pepper_img = [fill2,pepper_img,fill2];

%get the new image after filtering
new_img = img;
for i = 1:x
    for j = 1:y
        window = pepper_img(i:i+2,j:j+2);
        mid = median(reshape(window,1,9));
        new_img(i,j) = round(mid);
    end
end

%draw the four image

subplot(2,2,1);
imshow(img);
title('原图')

subplot(2,2,2);
imshow(pepper_img);
title('产生的椒盐噪声的图像')

subplot(2,2,3);
imshow(new_img);
title('自己实现的中值滤波')


out = medfilt2(pepper_img,[3 3]);
subplot(2,2,4);
imshow(out);
title('调用函数实现的中值滤波')

