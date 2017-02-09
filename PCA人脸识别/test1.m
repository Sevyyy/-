%read in the 10 face of each 40 people into img,
%each represented as a column
img = zeros(92*112,40*10);
for i = 1:40
    dir = ['att_faces/s', num2str(i), '/'];
    for j = 1:10
        url = [dir, num2str(j), '.pgm'];
        temp = imread(url);
        temp = reshape(temp,92*112,1);
        img(:,i*10 - 10 +j) = temp;
    end
end

%calculate the mean of 7 face of each people
%and then deduct the mean for each people into x
x = zeros(92*112,40);
for i = 1:40
    x(:,i) = mean(img(:,i*10-10+4:i*10-10+10),2);
end
mean_x = mean(x,2);
average0_x = zeros(92*112,40);
for i = 1:40
    average0_x(:,i) = x(:,i) - mean_x;
end

%get the covariance matrix of these mean-deducted
L = (average0_x'*average0_x);

%get the eigen value D and eigne vector W
[W,D] = eig(L);

%get the V
V = average0_x * W;

%normalize V
for i = 1:40
    V(:,i) = V(:,i) / sqrt(sum(V(:,i)' * V(:,i)));
end

%extract k eigne vector and get the alpha for 40 face

    k = 35;
    Vk = V(:,41-k:40);
    alphak = Vk' * average0_x;
    %diap e face
    %{
    eface = zeros(92*112,40);
    for j = 1:40
        va = zeros(92*112,1);
        for i = 1:k
            va = va + Vk(:,i) * alphak(i,j);
        end
        eface(:,j) = va + mean_x;
        temp = mod(j,8);
        if temp == 0
            temp = 8;
        end
        subplot(4,10,j);
        imshow(uint8(reshape(eface(:,j),112,92)));
    end
    %}
    %begin testing
    count = 0;
    for i = 1:40
        for j = 1:3
            zp = img(:,i*10-10+j);
            zp = zp - mean_x;
            alphap = Vk' * zp;
            answ = 25;
            min = norm(alphap - alphak(:,25),2);
            for l = 1:40
                temp = norm(alphap - alphak(:,l),2);
                if temp < min
                    min = temp;
                    answ = l;
                end
            end
            if answ == i
                count = count + 1;
            end
        end
    end
    disp(count/120);  
    disp(count);
