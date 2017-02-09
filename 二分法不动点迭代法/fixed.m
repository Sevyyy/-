%x = (x+1)^(1/3)

x = 1.5;
%x_next = (x^3-1);
x_next = 1.5;
error = 0.00000000001;
n = 5;
count = 0;

tic;
while count < n
    x = x_next;
    x_next = x^3 - 1;
    count = count + 1;
    disp(vpa(x_next), 10);
    toc;
end

disp(x_next);