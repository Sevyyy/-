left = 1.0;
right = 1.5;

error = 0.00001;
mid = (right + left) / 2;
count = 0;
tic;
e = [];
while right - left > error
    value = mid^3 - mid - 1;
    if value == 0
        break;
    elseif value < 0
        left = mid;
    else
        right = mid;
    end
    mid = (right + left) / 2;
    count = count + 1;
    e(count) = right - left;
end
toc;
disp(count);
x = linspace(1,count,count);
plot(x, e);
    