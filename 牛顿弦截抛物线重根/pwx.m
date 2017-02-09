count = 0;
x0 = 1;
x1 = 3;
x2 = 2;
x3 = 0;
error = 10^-4;
while(1)
    f2 = x2^3 - 3*x2 - 1;
    f1 = x1^3 - 3*x1 - 1;
    f0 = x0^3 - 3*x0 - 1;
    f21 = (f1 - f2) / (x1 - x2);
    f10 = (f0 - f1) / (x0 - x1);
    f210 = (f10 - f21) / (x0 - x2);
    w = f21 + f210*(x2 - x1);
    if w >= 0
        x3 = x2 - 2*f2 / (w+sqrt(w*w - 4*f2*f210));
    else
        x3 = x2 - 2*f2 / (w-sqrt(w*w - 4*f2*f210));
    end
    x0 = x1;
    x1 = x2;
    x2 = x3;
    count = count + 1;
    if abs(x2 - x1) < error
        break;
    end
    disp(vpa(x3,6));
end

disp(vpa(x3,6));
disp(count);
