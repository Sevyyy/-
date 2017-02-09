img1 = imread('blobz1.png');
img2 = imread('blobz2.png');
[m,n] = size(img1);
result1 = zeros(m,n);
result2 = zeros(m,n);

%for the img1
T = mean(mean(img1));
delta_t = 0.01;
n1 = 0;
while(1)
    n1 = n1 + 1;
    part1 = 0;
    count1 = 0;
    part2 = 0;
    count2 = 0;
    for i = 1:m
        for j = 1:n
            if img1(i,j) > T
                part1 = part1 + double(img1(i,j));
                count1 = count1 + 1;
            else
                part2 = part2 + double(img1(i,j));
                count2 = count2 + 1;
            end
        end
    end

    TT = (part1/count1 + part2/count2) / 2;
    if abs(TT-T) < delta_t
        T = TT;
        break;
    end
    T = TT;
end

for i = 1:m
    for j = 1:n
        if img1(i,j) > T
            result1(i,j) = 1;
        end
    end
end
fprintf('img1 : %d times, with T = %f delat_t = 0.01\n',n1,T)

%for the img2
k = 25;
for i = 1:m
    for j = 1:n
        %{
        if i-k < 1
            r_b = 1;
            r_e = k*2+1;
        elseif i+k > m
            r_b = m-k*2;
            r_e = m;
        else
            r_b = uint32(max(1,i-k));
            r_e = uint32(min(m,i+k));
        end
        if j-k < 1
            c_b = 1;
            c_e = k*2+1;
        elseif j+k > n
            c_b = n-k*2;
            c_e = n;
        else
            c_b = uint32(max(1,j-k));
            c_e = uint32(min(n,j+k));
        end
        %}
        
        r_b = uint32(max(1,i-k));
        r_e = uint32(min(m,i+k));
        c_b = uint32(max(1,j-k));
        c_e = uint32(min(n,j+k));
        
        temp = img2(r_b:r_e,c_b:c_e);
        %[counts,x] = imhist(temp);

        T = mean(mean(temp));
        if img2(i,j) > T
            result2(i,j) = 1;
        end
    end
end

subplot(1,2,1);
imshow(result1);
subplot(1,2,2);
imshow(result2);
