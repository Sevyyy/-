%read in the image
im = imread('book_cover.jpg');
subplot(3,3,1);
imshow(im);
title('origin');
I = im2double(im);
[m,n] = size(im);

%parameter for H
a = 0.1;
b = 0.1;
T = 1;

%get H function
u = 1:m;
v = 1:n;
[u,v] = meshgrid(u,v);
uv = (u-m/2+1).*a + (v-n/2+1).*b + eps;   %with center transform
H = T.*sin(pi.*uv).*exp(-1i.*pi.*uv) ./ (pi.*uv);

%do DFT and center transform
temp_one = ones(n,n);
for i = 1:m
    for j = 1:n
        temp_one(i,j) = (-1)^(i+j);
    end
end
%I = I .* temp_one;
F = fft2(I);
F = fftshift(F);
subplot(3,3,2);
imshow(log(1+abs(F)),[]);
title('fourier spectrum');

%do blur
G = H.*F;
G = ifftshift(G);
G = ifft2(G);
blur = log(1+abs(G));
subplot(3,3,3);
imshow(blur,[]);
title('blurred image');

%add noise mean = 0 var = 500
noise = imnoise(G,'gaussian',0,500/(225^2));
noise_only = imnoise(zeros(n,n),'gaussian',0,500/(255^2));
subplot(3,3,4);
imshow(log(1+abs(noise_only)),[]);
title('the additive noise-500');
subplot(3,3,5);
imshow(log(1+abs(noise)),[]);
title('the noise added');

%restore blur using the inverse filter
G = fft2(blur);
F_inverse = G./H;
F_inverse = abs(ifft2(F_inverse));
subplot(3,3,6);
imshow(F_inverse,[]);
title('direct inverse');

%restore blue + noise using parametric Wiener filter(use 3 parameter)
H2 = H.*conj(H);
HH = (H2 ./ (H .* (H2 + 1)));
N = fft2(noise);
N = fftshift(N);
W = HH.*N;
W = fftshift(W);
W = ifft2(W);
subplot(3,3,7);
imshow(log(1+abs(W)),[]);
title('Parametric Wiener filtering k=1');

H2 = H.*conj(H);
HH = (H2 ./ (H .* (H2 + 0.1)));
N = fft2(noise);
N = fftshift(N);
W = HH.*N;
W = fftshift(W);
W = ifft2(W);
subplot(3,3,8);
imshow(log(1+abs(W)),[]);
title('Parametric Wiener filtering k=0.1');

H2 = H.*conj(H);
HH = (H2 ./ (H .* (H2 + 0.01)));
N = fft2(noise);
N = fftshift(N);
W = HH.*N;
W = fftshift(W);
W = ifft2(W);
subplot(3,3,9);
imshow(log(1+abs(W)),[]);
title('Parametric Wiener filtering k=0.01');



