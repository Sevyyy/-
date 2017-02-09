%{
[            3,     c*sin(b*c), b*sin(b*c)]
[          2*a, - 162*b - 81/5,     cos(c)]
[ -b*exp(-a*b),   -a*exp(-a*b),         20]
syms a;
syms b;
syms c;
f1 = 3*a - cos(b*c) - 0.5;
f2 = a*a - 81*(b+0.1)^2 + sin(c) + 1.06;
f3 = exp(-a*b) + 20*c + 10*pi/3 - 1;
J=jacobian([f1;f2;f3],[a b c]);
disp(J);
%}
x0 = [0.5;0.5;0.5];
x1 = [0.5;0.5;0.5];
error = 10^-8;
count = 0;
while(1)
    x0 = x1;
    a = x0(1);
    b = x0(2);
    c = x0(3);
    fp = [          3,   c*sin(b*c), b*sin(b*c);
                  2*a, - 162*b - 81/5,     cos(c);
         -b*exp(-a*b),   -a*exp(-a*b),         20];
    fp = inv(fp);
    f = [3*a - cos(b*c) - 0.5;
        a*a - 81*(b+0.1)^2 + sin(c) + 1.06;
        exp(-a*b) + 20*c + 10*pi/3 - 1];
    x1 = x0 - fp*f;
    count = count + 1;
    disp(count);
    if norm(x1-x0,1) < error
        break;
    end 
    disp(vpa(x1,10));
end
disp(vpa(x1,10));