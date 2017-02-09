function test(A)
    s = size(A);
    n = s(1);
    disp(det(A(1:3,1:3)));
    %first line is 0
    if A(1,1) == 0
        for temp = 2:n
            if A(temp,1) ~= 0
                for i = 1:n+1
                    temp1 = A(1,i);
                    A(1,i) = A(temp,i);
                    A(temp,i) = temp1;
                end
                break;
            end
        end
    end
    
    %begin
    for i = 2:n
        max = 0;
        index = 1;
        for j = i-1:n
            if abs(A(j,i-1)) > max
                max = abs(A(j,i-1));
                index = j;
            end
        end
        
        for j = 1:n+1
            temp = A(i-1,j);
            A(i-1,j) = A(index,j);
            A(index,j) = temp;
        end
        
        for j = i:n
            %A(j,i-1) = A(j,i-1)/A(i-1,i-1);
            x = A(j,i-1)/A(i-1,i-1);
            for k = i-1:n+1
                A(j,k) = A(j,k) - x*A(i-1,k);
            end
            disp(A);
            disp(det(A(1:3,1:3)));
        end
        
        if A(i,i) == 0
            for temp = i+1:n
                if A(temp,i) ~= 0
                    for q = 1:n+1
                        temp1 = A(i,q);
                        A(i,q) = A(temp,q);
                        A(temp,q) = temp1;
                    end
                    break;
                end
            end
        end
    end
    %disp(A);
    x = zeros(n,1);
    for i = n:-1:1
        b = A(i,n+1);
        for j = n:-1:i+1
            b = b - A(i,j) * x(j);
        end
        x(i) = b/A(i,i);
    end
    disp(x);
    
end
