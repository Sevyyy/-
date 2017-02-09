count = 0;
x0 = 2;
x1 = 1.9;
x2 = 0;
error = 10^-4;
while(1)
    f = x1^3 - 3*x1 - 1;
    f1 = x0^3 - 3*x0 - 1;
    x2 = x1 - f * (x1-x0) / (f-f1);
    x0 = x1;
    x1 = x2;
    count = count + 1;
    if abs(x1 - x0) < error
        break;
    end
    disp(vpa(x2,6));
end

disp(vpa(x2,6));
disp(count);

    