%read in the image
barb = imread('barb.png');

%get the size m,n and get the p,q and filling it into new_img
[m,n] = size(barb);
p = 2*m;
q = 2*n;
new_img = zeros(p,q);
new_img(1:m,1:n) = barb;

%center transform
temp_one = ones(m,n);
for  a = 1:p
    for b = 1:q
        temp_one(a,b) = (-1)^(a+b);
    end
end
new_img = new_img .* temp_one;

%do the DFT
F = fft2(new_img);

%create function H and filtering
D0 = [10 20 40 80];                 % 10 20 40 80
for d = 1:4
    H = zeros(p,q);
    for u = 1:p
        for v = 1:q
            H(u,v) = 1 / (1 + (sqrt((u - p/2)^2 + (v - q/2)^2) / D0(d))^2);
        end
    end
    G = H .* F;

    %do the idft
    G = real(ifft2(G));
    G = G .* temp_one;
    G = G(1:m,1:n);
    subplot(2,3,d);
    imshow(uint8(G));
    title(['D0 = ',num2str(D0(d))]);
end

subplot(2,3,5);
imshow(barb);
title('oringin');


