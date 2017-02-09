A1 = [7 3 -2; 3 4 -1; -2 -1 3];
A2 = [3 -4 3; -4 6 3; 3 3 1];
A3 = [1.0 1.0 0.5; 1.0 1.0 0.25; 0.5 0.25 2.0];
A4 = [0.25 1 0.5; 1 0.25 0.25; 0.5 0.25 1.25];

error = 0.001;
p = 0.75;
A3 = A3 - p*eye(3);
uk = [1;1;1];
vk = uk;
last = 1;

[V,D] = eig(A2)
count = 0;
n = 10;
while(1)
    last = mk;
    vk = A2 * uk;
    mk = max(vk);
    uk = vk / mk;
    disp(uk);
    disp(mk);
    count = count + 1;
    disp(count);
    if abs(last-mk) < error
        break;
    end
end

