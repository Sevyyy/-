function fi = fijk(x,j,k)
    n = length(x);
    fi = 0;
    for i = 1:n   
        fi = fi + x(i)^(j - 1) * x(i)^(k - 1);
    end
end