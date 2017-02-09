x = [0 0.1 0.2 0.3 0.5 0.8 1];
y = [1 0.41 0.5 0.61 0.91 2.02 2.46];

n = length(x);

%{
G = zeros(n,n);
for j = 1:n
    for k = 1:n
        tempXj = x.^(j-1);
        tempXk = x.^(k-1);
        G(j,k) = tempXj * tempXk';
    end
end

d = zeros(n,1);
for i = 1:n
    tempXk = x.^(i-1);
    d(i) = tempXk * y';
end
%}


fi = [];
for k = 0:n-1
    fi = [fi, x'.^k];
end
%disp(fi);
G = fi'*fi;
d = fi'*y';
%disp(d);
GG = G;
dd = d;


e = 5;
G = G(1:e+1,1:e+1);
d = d(1:e+1,1);
a = G\d;
%disp(a);
x0 = linspace(x(1),x(n));
y0 = linspace(0,0);
for i = 1:e+1
    y0 = y0 + a(i) * x0.^(i-1);
end
plot(x0,y0,'r',x,y,'b');

s = zeros(size(x));
for i = 1:e+1
    s = s + a(i)*x.^(i-1);
end

s = s-y;
delta = s*s';
disp(delta);