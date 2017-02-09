%f(x) = (sin(x) - x/2)^2
%{
syms t;
f(t) = (sin(t) - t/2)^2
fp = diff(f)
fpp = diff(f,2)
%}
error = 10^-5;
x0 = pi/2;
x1 = x0;
count = 0;
%newton
%{
while(1)
    x0 = x1;
    x1 = x0 - ((sin(x0) - x0/2)^2) / (2*sin(x0)*cos(x0) - sin(x0) - x0*cos(x0) + x0/2);
    count = count + 1;
    if abs(x1 - x0) < error
        break;
    end
    disp(vpa(x1,6));
end
%}

%4.13 m = 2
%{
while(1)
    x0 = x1;
    fk = (x0/2 - sin(x0))^2;
    fpk = -2*(cos(x0) - 1/2)*(x0/2 - sin(x0));
    x1 = x0 - 2*fk/fpk;
    count = count + 1;
    if abs(x1 - x0) < error
        break;
    end
    disp(vpa(x1,20));
end
%}

%4.14 m=2

while(1)
    x0 = x1;
    fk = (x0/2 - sin(x0))^2;
    fpk = -2*(cos(x0) - 1/2)*(x0/2 - sin(x0));
    fppk = 2*(cos(x0) - 1/2)^2 + 2*sin(x0)*(x0/2 - sin(x0));
    x1 = x0 - (fk*fpk) / (fpk^2 - fk*fppk);
    count = count + 1;
    if abs(x1 - x0) < error
        break;
    end
    disp(vpa(x1,20));
end


disp(vpa(x1,20));
disp(count);