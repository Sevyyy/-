%A = [4 -1 0; -1 4 -1; 0 -1 4];
%b = [1;4;-3];

%A = [5 2 1; -1 4 2; 2 -3 10];
%b = [-12; 20; 3];

%n = 3;
n = 10;    %6  8  10

A = zeros(n);
for i = 1:n
    for j = 1:n
        A(i,j) = 1/(i+j-1);
    end
end
x_start = ones(n,1);
b = A*x_start;


%x_start = [0.5; 1; -0.5];

error = 1*10^-4;

w = 1.5;
D = diag(diag(A));
L = -tril(A, -1);
U = -triu(A, 1);
B = (D - w*L) \ ((1-w) * D + w*U);
f = (D - w*L) \ b;

%x = [0; 0; 0];
%x_last = [0; 0; 0];
x = zeros(n,1);
x_last = x;
count = 0;
e = [];
tic;
while(1)
    x_last = x;
    for i = 1:n
        x(i) = x(i) + w * (b(i) - A(i,:) * x) / A(i,i);
    end
    %disp(vpa(x,10));
    count = count + 1;
    e(count) = norm(x_last - x, inf);
    if(e(count) < error)
        break;
    end
end
toc;


disp(x);
disp(vpa(x,10));
disp(count);

%count = linspace(1,count,count);
%plot(count,e);

