%read in the image and get the gray and size
office = imread('office.jpg');
office = rgb2gray(office);
[m,n] = size(office);               %220 293
p = 2*m;
q = 2*n;
new_img = zeros(p,q);
new_img(1:m,1:n) = office;

%center transform
temp_one = zeros(p,q);
for  i = 1:p
    for j = 1:q
        temp_one(i,j) = (-1)^(i+j);
    end
end
new_img = log(double(new_img + 1));
F_backup = fft2(new_img .* temp_one);
new_img = new_img .* temp_one;

%do the dft
F = fft2(new_img);

subplot(3,3,1);
imshow(office);
title('origin');

%create function H and filtering
D0 = [160 320 640 1280 2560];

for d = 2:6
    H = zeros(p,q);
    for u = 1:p
        for v = 1:q
            temp = (u - p/2)^2 + (v - q/2)^2;
            H(u,v) = 1.75 * (1 - exp(-(temp / (D0(d-1))^2))) + 0.25;
        end
    end
    G = H .* F;
    G = real(ifft2(G));
    G = G .* temp_one;
    G = G(1:m,1:n);
    G = exp(G)-1;
    
    maxi = max(G);
    mini = min(G);
    range = maxi - mini;
    for u = 1:m
        for v = 1:n
            G(u,v) = 255 * (G(u,v) - mini) / range;
        end
    end
    
    
    subplot(3,3,d);
    imshow(uint8(G));
    title(['D0 =',num2str(D0(d-1))]);
end


D0 = [1 2 4];  %F_back_up
for d = 1:3
    H = zeros(p,q);
    for u = 1:p
        for v = 1:q
            temp = (u - p/2)^2 + (v - q/2)^2;
            H(u,v) = 1 / (1 + (D0(d) / sqrt(temp))^2);
        end
    end
    G = H .* F_backup;
    G = real(ifft2(G));
    G = G .* temp_one;
    G = G(1:m,1:n);
    maxi = max(G);
    mini = min(G);
    range = maxi - mini;
    for u = 1:m
        for v = 1:n
            G(u,v) = 255 * (G(u,v) - mini) / range;
        end
    end
    subplot(3,3,d + 6);
    imshow(uint8(G));
    title(['D0 = ',num2str(D0(d))]);
end





