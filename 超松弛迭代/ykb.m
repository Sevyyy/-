%A = [5 2 1; -1 4 2; 2 -3 10];     %T1
%b = [-12; 20; 3];

%A = [1 0.4 0.4; 0.4 1 0.8; 0.4 0.8 1];    %T2(1)
%b = [1; 2; 3];

A = [1 2 -2; 1 1 1; 2 2 1];              %T2(2)
b = [1; 1; 1];

%get some import matrix
D = diag(diag(A));
L = -tril(A,-1);
U = -triu(A,1);
B = D\(L+U);
f = D\b;

%judge if convergence
flag = true;
R = max(abs(eig(B)));
if R < 1
    fprintf('Convergence!\n');
else
    fprintf('Divergence!\n');
    flag = false;
end

if(flag)
    %begin iteration
    count = 0;
    error = [];
    x = [0;0;0];
    x_last = x;
    errorList = [0.1 0.01 0.001 0.0001 0.00001 0.000001];
    tic;
    for i = 1:6
        while(1)
            x_last = x;
            x = B*x + f;
            count = count + 1;
            error(count) = norm(x-x_last, inf);
            if(error(count) < errorList(i))
                fprintf('当相对误差达到%f以内时，',errorList(i));
                toc;
                fprintf('Iteration count = %d\n',count);
                break;
            end
        end
    end

    fprintf('x=:\n');
    disp(vpa(x,6));
    count = linspace(1,count,count);
    plot(count, error);
    xlabel('Iteration Count');
    ylabel('Error');
    title('T2(2) jacobi');
end




