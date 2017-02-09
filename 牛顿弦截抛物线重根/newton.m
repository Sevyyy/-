count = 0;
x = 2;
x_1 = 2;
error = 10^-4;
while(1)
    x = x_1;
    x_1 = (2*x^3+1) / (3*x^2 - 3);
    count = count + 1;
    if abs(x_1 - x) < error
        break;
    end
    disp(vpa(x_1,6));
end

disp(vpa(x_1,5));
disp(count);