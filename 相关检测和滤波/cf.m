function cf(base_name, weight_name) %enter the file name

    %read in the two image base and weight
    base = double(imread(base_name));

    subplot(2,2,1);
    imshow(uint8(base));
    hold on;

    
    weight = double(imread(weight_name));
    
    %get the imformation of the two image(width, height)
    base_info = imfinfo(base_name);
    base_n = base_info.Width;
    base_m = base_info.Height;
    weight_info = imfinfo(weight_name);
    weight_n = weight_info.Width;
    weight_m = weight_info.Height;
    
    %fill out the base image for correlation
    a = int32((weight_m - 1) / 2); 
    b = int32((weight_n - 1) / 2);
    fill1 = zeros(a, base_n);
    fill2 = zeros(a * 2 + base_m, b);
    base = [fill1;base;fill1];
    base = [fill2,base,fill2];
    
    %do the correlation filtering to the output([-1,1])
    output = zeros(base_m,base_n);
    w_mean = sum(sum(weight)) / (weight_m * weight_n);
    for i = 1:base_m
        for j = 1:base_n
            f = base(i:i+2*a,j:j+2*b);
            output(i,j) = correlation(weight,f,weight_m,weight_n,w_mean);
        end
    end
    
    %sort the output,get the top 10 point find them and draw out
    sort_outpu = sort(output(:),'descend');
    disp('The top 10 point:');
    for i = 1:10
        [x,y] = find(output == sort_outpu(i));
        rectangle('Position',[y-b x-a weight_m weight_n],'EdgeColor','r')
        disp([x y]);
    end
    hold off;
    title('the car and its wheel(in red retangle)');

    %draw the weight image
    subplot(2,2,2);
    imshow(uint8(weight));
    title('the wheel to find');

    %map the output to 1-255 and draw out
    output = output * 127 + 128;
    subplot(2,2,3);
    imshow(uint8(round(output)));
    title('the correlation map');
    
end

