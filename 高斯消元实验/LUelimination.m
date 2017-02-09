function [x, P, L, U] = LUelimination(n, A, b)
    for i = 1 : n
        Ip(i) = i;
    end
    
    for k = 1 : n
        max = k;
        for i = k + 1 : n
            if abs(A(i, k)) > abs(A(max, k))
                max = i;
            end
        end
        
        if max ~= k
            tem = Ip(k);
            Ip(k) = Ip(max);
            Ip(max) = tem;
            
            tem = A(max, :);
            A(max, :) = A(k, :);
            A(k, :) = tem; 
            
            tem = b(max);
            b(max) = b(k);
            b(k) = tem;
        end
        
        for i = k + 1 : n
            mik = A(i, k) / A(k, k);
            A(i, k) = mik;
            for j = k + 1 : n
                A(i, j) = A(i, j) - mik * A(k, j);
            end
            b(i) = b(i) - mik * b(k);
        end
    end
    
    x = zeros(n, 1);
    for i = n : -1 : 1
        x(i) = b(i);
        for j = i + 1 : n
            x(i) = x(i) - A(i, j) * x(j);
        end
        x(i) = x(i) / A(i, i);
    end
    
    P = zeros(n, n);
    for i = 1 : n
        P(i, Ip(i)) = 1;
    end
    L = tril(A, -1);
    for i = 1:n
        L(i, i) = 1;
    end
    U = triu(A);
end