%read in the 40 * 10 faces into img, do the block
img = cell(40,10);
for i = 1:40
    dir = ['att_faces/s', num2str(i), '/'];
    for j = 1:10
        url = [dir, num2str(j), '.pgm'];
        temp = zeros(28*23,16);
        image = double(imread(url));
        for p = 1:4
            for q = 1:4
                index = p*4-4+q;
                temp(:,index) = reshape(image(28*p-28+1:28*p,23*q-23+1:23*q),28*23,1);
            end
        end
        img{i,j} = temp;
    end
end

%do the mean-deduct
sum = zeros(28*23,1);
for i = 1:40
    for j = 1:7
        temp = mean(img{i,j},2);
        sum = sum + temp;
    end
end
mean_x = sum/280;
for i = 1:40
    for j = 1:10
        for k = 1:16
            img{i,j}(:,k) = img{i,j}(:,k) - mean_x;
        end
    end
end

%get the conv matrix C
C = zeros(28*23,28*23);
for i = 1:40
    for j = 1:7
        temp = img{i,j} * img{i,j}';
        C = C + temp;
    end
end
C = C/280;

%do the eig, V is the vector, D is the value
[V,D] = eig(C);

%extract k vector for the projection
for k = 1:350
    Vk = V(:,645-k:644);
    alpha = cell(40,7);
    for i = 1:40
        for j = 1:7
            temp = zeros(k,16);
            for l = 1:16
                temp(:,l) = Vk' * img{i,j}(:,l);
            end
            alpha{i,j} = temp;
        end
    end

    %begin testing
    count = 0;
    for i = 1:40
        for j = 8:10
            alphap = zeros(k,16);
            for l = 1:16
                alphap(:,l) = Vk' * img{i,j}(:,l);
            end
            %calculate the norm
            min = 100000000;
            answer = 0;
            for p = 1:40
                temp = 0;
                for q = 1:7
                    temp = temp + norm(alphap-alpha{p,q});
                end
                if temp < min
                    min = temp;
                    answer = p;
                end
            end
            if answer == i
                count = count + 1;
            end
        end
    end
    disp(k);
    disp(count/120);
end
