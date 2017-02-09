count = 0;
error = 10^-8;
x = 1.5;
x_1 = 1.5;

while(1)
    x = x_1;
    x_1 = x - (x^3 + 2*x^2 + 10*x - 20) / (3*x^2 +4*x + 10);
    %x_1 = x - (x^2 - 3*x + 2 - exp(x)) / (2*x - 3 - exp(x));
    count = count + 1;
    disp(vpa(x_1,20));
    if abs(x_1 - x) < error
        break;
    end

end
disp(count);
