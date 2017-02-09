function fi = fifk(x,y,k)
    n = length(x);
    fi = 0;
    for i = 1:n
        fi = fi + y(i) * x(i)^(k-1);
    end
end