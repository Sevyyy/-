A = [6 2 1;2 3 1;1 1 1];
C = [5 4 1 1;4 5 1 1;1 1 4 2;1 1 2 4];
p = 9.5;
B = C - p*eye(4);

%[V,D] = eig(A);
uk = [1;1;1;1];
vk = uk;
n = 20;
while(n > 0)
    vk = B \ uk;
    mk = max(abs(vk));
    uk = vk / mk;
    n = n - 1;
    if mod(n,2) == 0
        disp(20 - n);
        disp(1/mk + p);
        disp(reshape(uk,1,4));
    end
end
disp(1/mk + p);
disp(vk);