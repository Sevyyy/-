%x1 = (1+ (2*cos(x2*x3))) / 6;
%x2 = sqrt((x1*x1 + sin(x3) + 1.06) / 81) - 0.1;
%x3 = (1 - 10*pi/3 - exp(-1*x1*x2)) / 20;

x0 = [0,0,0];
x1 = x0;
error = 10^-8;
count = 0;
while(1)
    x0 = x1;
    x1(1) = (1+ (2*cos(x0(2)*x0(3)))) / 6;
    x1(2) = sqrt(((x0(1))^2 + sin(x0(3)) + 1.06) / 81) - 0.1;
    x1(3) = (1 - 10*pi/3 - exp(-1*x0(1)*x0(2))) / 20;
    count = count + 1;
    disp(count);
    if norm(x1-x0,1) < error
        break;
    end
    disp(vpa(x1,10));
end

disp(vpa(x1,10));
a = x1(1);
b = x1(2);
c = x1(3);
v1 = 3*a - cos(b*c) - 0.5;
v2 = a*a - 81*(b+0.1)^2 + sin(c) + 1.06;
v3 = exp(-a*b) + 20*c + 10*pi/3 - 1;
disp(vpa(v1,10));
disp(vpa(v2,10));
disp(vpa(v3,10));